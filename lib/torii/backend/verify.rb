# frozen_string_literal: true

require 'jwt'
require 'json'
require 'net/http'
require 'uri'

require_relative 'auth'
require_relative 'errors'

module Torii
  module Backend
    # Networkless JWT verification. The first call to +verify_token+ for a
    # given issuer fetches that issuer's JWKS; subsequent calls reuse the
    # cached set until the TTL expires or a kid miss forces a re-fetch.
    #
    # This is the core DX win behind a backend SDK — verify_token has no
    # per-request round trip to torii.
    module_function

    # Time-to-live for the JWKS cache, in seconds. Matches the Node and
    # Python SDKs (5 minutes).
    JWKS_TTL_SECONDS = 300

    # Internal: cached JWKS entry. +jwks+ is a JWT::JWK::Set, +fetched_at+ is
    # a monotonic timestamp so cache TTL is robust against wall-clock changes.
    @jwks_cache = {}
    @jwks_cache_mutex = Mutex.new

    class << self
      attr_accessor :jwks_cache
      attr_reader :jwks_cache_mutex
    end

    # Verify a torii-issued JWT against the issuer's JWKS.
    #
    # @param token [String] Compact JWS as received from the customer frontend.
    # @param issuer [String] Expected issuer URL (per-tenant), e.g.
    #   +https://acme.torii.so+ or +https://auth.acme.com+.
    # @param audience [String, Array<String>, nil] Optional +aud+ claim to
    #   enforce. torii doesn't set +aud+ today, so +nil+ skips the check.
    # @param leeway [Integer] Clock-skew tolerance in seconds for +exp+/+nbf+.
    # @return [Torii::Backend::Auth]
    # @raise [Torii::Backend::AuthError] if signature, issuer, expiry, or
    #   required claims fail validation.
    def verify_token(token, issuer:, audience: nil, leeway: 30)
      raise AuthError, 'verify_token: token must be a non-empty string' if !token.is_a?(String) || token.empty?
      raise AuthError, 'verify_token: issuer is required' if !issuer.is_a?(String) || issuer.empty?

      jwks = jwks_for_issuer(issuer)
      verify_options = {
        algorithm: 'ES256',
        iss: issuer,
        verify_iss: true,
        verify_iat: true,
        leeway: leeway,
        jwks: jwks,
      }
      if audience
        verify_options[:aud] = audience
        verify_options[:verify_aud] = true
      end

      payload, =
        begin
          ::JWT.decode(token, nil, true, verify_options)
        rescue ::JWT::JWKError, ::JWT::DecodeError, ::JWT::VerificationError => e
          # kid miss can happen after rotation; flush this issuer's cache and
          # retry once before giving up.
          if e.is_a?(::JWT::DecodeError) && e.message.include?('Could not find public key')
            invalidate_jwks(issuer)
            begin
              ::JWT.decode(token, nil, true, verify_options.merge(jwks: jwks_for_issuer(issuer)))
            rescue ::JWT::DecodeError => retry_err
              raise AuthError.new("JWT verification failed: #{retry_err.message}", cause: retry_err)
            end
          else
            raise AuthError.new("JWT verification failed: #{e.message}", cause: e)
          end
        end

      user_id = payload['sub']
      environment_id = payload['pid']
      iss = payload['iss']
      unless user_id.is_a?(String) && environment_id.is_a?(String) && iss.is_a?(String)
        raise AuthError,
              "JWT is missing required string claims (sub=#{!user_id.nil?}, pid=#{!environment_id.nil?}, iss=#{!iss.nil?})"
      end
      raise AuthError, 'JWT missing iat claim' unless payload['iat']
      raise AuthError, 'JWT missing exp claim' unless payload['exp']

      locale = payload['locale']
      Auth.new(
        user_id: user_id,
        environment_id: environment_id,
        issuer: iss,
        email_verified: payload['email_verified'] == true,
        # profile_complete defaults to true when claim is absent (mirrors Node/Python SDK).
        profile_complete: payload['profile_complete'] != false,
        impersonating: payload['impersonating'] == true,
        locale: locale.is_a?(String) ? locale : nil,
        raw: payload,
      )
    end

    # Internal: fetch+cache the JWKS for an issuer.
    def jwks_for_issuer(issuer)
      normalized = issuer.sub(%r{/+\z}, '')
      now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      @jwks_cache_mutex.synchronize do
        entry = @jwks_cache[normalized]
        return entry[:jwks] if entry && (now - entry[:fetched_at]) < JWKS_TTL_SECONDS
      end

      fetched = fetch_jwks(normalized)
      @jwks_cache_mutex.synchronize do
        @jwks_cache[normalized] = { jwks: fetched, fetched_at: now }
      end
      fetched
    end

    # Internal: HTTP-fetch and parse the issuer's JWKS document.
    def fetch_jwks(normalized_issuer)
      url = URI.parse("#{normalized_issuer}/_torii/.well-known/jwks.json")
      response =
        begin
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = (url.scheme == 'https')
          http.open_timeout = 10
          http.read_timeout = 10
          http.request_get(url.request_uri, { 'accept' => 'application/json' })
        rescue StandardError => e
          raise AuthError.new("Failed to fetch JWKS from #{url}: #{e.message}", cause: e)
        end

      unless response.is_a?(Net::HTTPSuccess)
        raise AuthError, "Failed to fetch JWKS from #{url}: HTTP #{response.code}"
      end

      begin
        parsed = JSON.parse(response.body)
      rescue JSON::ParserError => e
        raise AuthError.new("JWKS at #{url} is not valid JSON: #{e.message}", cause: e)
      end

      ::JWT::JWK::Set.new(parsed)
    end

    # Internal: drop the cache entry for a specific issuer.
    def invalidate_jwks(issuer)
      normalized = issuer.sub(%r{/+\z}, '')
      @jwks_cache_mutex.synchronize { @jwks_cache.delete(normalized) }
    end

    # Test-only: clear all cached JWKS. Production code should not need
    # this — the cache TTL plus rotation-on-kid-miss handles real-world
    # key rotation automatically.
    def clear_jwks_cache_for_tests
      @jwks_cache_mutex.synchronize { @jwks_cache.clear }
    end
  end
end
