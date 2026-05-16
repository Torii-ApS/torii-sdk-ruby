# frozen_string_literal: true

require 'uri'

require_relative '../../torii-backend-generated'
require_relative 'errors'
require_relative 'patch'
require_relative 'version'

module Torii
  module Backend
    # Default torii API base URL. Override via +api_url+ for staging or
    # self-hosted.
    DEFAULT_API_URL = 'https://api.torii.so'

    # Top-level entry point for the REST surface.
    #
    # Construct with +Torii::Backend::Client.new(secret_key: '...')+.
    # Reuse the instance across requests — the underlying generated
    # client (which wraps Faraday) maintains a connection-keeping
    # configuration.
    class Client
      attr_reader :users, :sessions

      # @param secret_key [String] backend secret key, e.g. +sk_live_*+
      #   or +sk_test_*+. Required.
      # @param api_url [String] backend base URL. Defaults to
      #   +https://api.torii.so+. Override for staging/self-hosted.
      # @param http_adapter [Object, nil] optional callable used to stub
      #   requests in tests. When provided, it must respond to
      #   +#call(method, url, headers, body, query)+ and return a Hash
      #   with +:status+, +:headers+, +:body+. The generated client uses
      #   Typhoeus by default; the stub is only consulted when the
      #   underlying +ApiClient+ is replaced by a test helper.
      def initialize(secret_key:, api_url: DEFAULT_API_URL, http_adapter: nil)
        raise ArgumentError, 'secret_key is required' if !secret_key.is_a?(String) || secret_key.empty?

        @config = build_config(secret_key: secret_key, api_url: api_url)
        @api_client = ToriiBackendGenerated::ApiClient.new(@config)
        @http_adapter = http_adapter
        @users = UsersClient.new(@api_client)
        @sessions = SessionsClient.new(@api_client)
      end

      # @return [ToriiBackendGenerated::ApiClient] the underlying
      #   generated client. Exposed for advanced callers who need to
      #   tweak Faraday config; most code should not need this.
      attr_reader :api_client

      private

      def build_config(secret_key:, api_url:)
        config = ToriiBackendGenerated::Configuration.new
        uri = URI.parse(api_url)
        config.scheme = uri.scheme || 'https'
        config.host = [uri.host, uri.port].compact.join(':')
        config.base_path = uri.path.to_s.sub(%r{/+\z}, '')
        # The generated client treats +access_token+ as a Bearer token
        # but only applies it when an operation declares +bearerAuth+ as
        # an auth_setting. Our spec doesn't (yet), so the per-call
        # wrappers below inject the header directly.
        config.access_token = secret_key
        config
      end
    end

    # Hand-written wrapper around the generated +ServerUsersApi+. The
    # wrapper:
    #
    # * keeps a Pythonic / idiomatic-Ruby keyword surface that matches
    #   the surface promised in the SDK docs across languages;
    # * sets the secret-key header on every call (the generated client
    #   does not, see comment in Client#build_config);
    # * deserialises generated model instances to plain hashes so
    #   callers don't need to learn the generated namespace.
    class UsersClient
      def initialize(api_client)
        @api_client = api_client
        @api = ToriiBackendGenerated::ServerUsersApi.new(api_client)
      end

      # Search users. Server-side cursor-paginated; call repeatedly with
      # +cursor: page[:next_cursor]+ until +page[:has_more]+ is false.
      def list(limit: nil, cursor: nil, name: nil, email: nil, statuses: nil, created_after: nil, created_before: nil)
        body = ToriiBackendGenerated::ServerUserSearchRequest.new(
          name: name,
          email: email,
          statuses: statuses,
          created_after: created_after,
          created_before: created_before,
        )
        opts = { server_user_search_request: body, header_params: auth_headers }
        opts[:limit] = limit unless limit.nil?
        opts[:cursor] = cursor unless cursor.nil?
        result = @api.search_users(opts)
        page_to_hash(result)
      end

      def get(user_id)
        model_to_hash(@api.get_user(user_id, header_params: auth_headers))
      end

      def create(email: nil, name: nil, phone: nil, password: nil, address: nil, date_of_birth: nil)
        body = ToriiBackendGenerated::CreateUserRequest.new(
          email: email,
          name: name,
          phone: phone,
          password: password,
          address: address,
          date_of_birth: date_of_birth,
        )
        model_to_hash(@api.create_user(body, header_params: auth_headers))
      end

      # PATCH a user. Each kwarg must be a {Torii::Backend::Patch}
      # instance — Ruby keyword args can't distinguish "absent" from
      # "explicit nil" on their own, so we use a wrapper:
      #
      #   client.users.update(user_id,
      #     name: Torii::Backend::Patch.set("Ada"),  # set field
      #     phone: Torii::Backend::Patch.set(nil),   # null on the wire (clear)
      #   )
      #
      # Omitted kwargs are left untouched on the server. Field names map
      # to the JSON keys the server expects (camelCase).
      def update(user_id, **patches)
        body = {}
        patches.each do |field, patch|
          unless patch.is_a?(Patch)
            raise ArgumentError, "kwarg #{field} must be a Torii::Backend::Patch (got #{patch.class})"
          end

          json_key = PATCH_FIELD_MAP.fetch(field) do
            raise ArgumentError, "unknown PATCH field: #{field}. Valid: #{PATCH_FIELD_MAP.keys.inspect}"
          end

          # Patch.set(value) emits the key; nil value → JSON null (clear).
          body[json_key] = patch.value
        end

        # +debug_body+ on the generated client is the escape hatch for
        # sending a pre-rendered request body. The generated
        # +UpdateUserRequest+ model strips nil-valued attributes when
        # serialising, which would defeat the +Patch.clear+ case, so we
        # bypass it and ship our hand-built JSON instead.
        result = @api.update_user(
          user_id,
          ToriiBackendGenerated::UpdateUserRequest.new,
          debug_body: body.to_json,
          header_params: auth_headers,
        )
        model_to_hash(result)
      end

      # Map of Ruby snake_case kwargs to the JSON keys the server
      # expects on the PATCH body. Centralised so +update+ can validate
      # field names with a single +fetch+.
      PATCH_FIELD_MAP = {
        name: 'name',
        phone: 'phone',
        avatar_url: 'avatarUrl',
        locale: 'locale',
        address: 'address',
        date_of_birth: 'dateOfBirth',
      }.freeze

      def delete(user_id)
        @api.delete_user(user_id, header_params: auth_headers)
        nil
      end

      def ban(user_id)
        model_to_hash(@api.ban_user(user_id, header_params: auth_headers))
      end

      def unban(user_id)
        model_to_hash(@api.unban_user(user_id, header_params: auth_headers))
      end

      private

      def auth_headers
        { 'Authorization' => "Bearer #{@api_client.config.access_token}" }
      end

      def model_to_hash(model)
        return model if model.nil? || model.is_a?(Hash)

        model.respond_to?(:to_hash) ? model.to_hash : model
      end

      def page_to_hash(page)
        return page if page.nil? || page.is_a?(Hash)

        {
          items: (page.items || []).map { |u| model_to_hash(u) },
          next_cursor: page.respond_to?(:next_cursor) ? page.next_cursor : nil,
          has_more: page.respond_to?(:has_more) ? page.has_more : false,
        }
      end
    end

    # Hand-written wrapper around the generated +ServerSessionsApi+.
    # See the +UsersClient+ docstring for the rationale.
    class SessionsClient
      def initialize(api_client)
        @api_client = api_client
        @api = ToriiBackendGenerated::ServerSessionsApi.new(api_client)
      end

      def list_for_user(user_id)
        result = @api.list_sessions(user_id, header_params: auth_headers)
        (result || []).map { |s| s.respond_to?(:to_hash) ? s.to_hash : s }
      end

      def revoke_all_for_user(user_id)
        @api.revoke_all_sessions(user_id, header_params: auth_headers)
        nil
      end

      def revoke(user_id, session_id)
        @api.revoke_session(user_id, session_id, header_params: auth_headers)
        nil
      end

      private

      def auth_headers
        { 'Authorization' => "Bearer #{@api_client.config.access_token}" }
      end
    end
  end
end
