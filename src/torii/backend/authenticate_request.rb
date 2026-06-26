# frozen_string_literal: true

require_relative 'errors'
require_relative 'verify'

module Torii
  module Backend
    module_function

    # Extract a bearer token from a Rack +env+ hash (or any plain header
    # hash) and verify it. Accepts either:
    #
    # * a Rack environment, in which case the +header+ option is matched
    #   against the +HTTP_*+ keys (default: +HTTP_AUTHORIZATION+);
    # * a plain hash of headers (string keys like +"authorization"+ or
    #   symbol keys like +:authorization+).
    #
    # The header name match is case-insensitive and tolerant of the Rack
    # +HTTP_AUTHORIZATION+ convention.
    #
    # @return [Torii::Backend::Auth]
    # @raise [Torii::Backend::AuthError]
    def authenticate_request(env_or_headers, issuer:, audience: nil, leeway: 30, header: 'authorization')
      raw = extract_header(env_or_headers, header)
      raise AuthError, "Missing #{header} header" if raw.nil? || raw.empty?

      match = /\ABearer\s+(.+)\z/i.match(raw)
      raise AuthError, "#{header} header is not in 'Bearer <token>' form" unless match

      verify_token(match[1].strip, issuer: issuer, audience: audience, leeway: leeway)
    end

    # Internal: pull a header value out of a Rack env or a plain hash.
    # Handles the +HTTP_*+ rack convention, dashes-vs-underscores, and
    # both string and symbol keys.
    def extract_header(env_or_headers, name) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      return nil unless env_or_headers.respond_to?(:each_pair) || env_or_headers.respond_to?(:each)

      lower = name.to_s.downcase
      rack_key = "HTTP_#{name.to_s.upcase.tr('-', '_')}"
      # Rack always uses HTTP_AUTHORIZATION even when the input header is
      # 'authorization', so check that explicitly too.
      rack_key = 'HTTP_AUTHORIZATION' if lower == 'authorization'

      env_or_headers.each do |key, value|
        key_str = key.to_s
        next unless key_str == rack_key ||
                    key_str.downcase == lower ||
                    key_str.downcase.tr('_', '-') == lower

        return value.is_a?(Array) ? value.first : value
      end
      nil
    end
  end
end
