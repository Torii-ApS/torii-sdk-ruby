# frozen_string_literal: true

require 'json'

require_relative 'authenticate_request'
require_relative 'errors'

module Torii
  module Backend
    # Rack middleware. Rails-compatible — mount with
    #
    #   config.middleware.use Torii::Backend::Rack::RequireAuth,
    #     issuer: 'https://acme.torii.so'
    #
    # On success the verified +Torii::Backend::Auth+ is placed at
    # +env['torii.auth']+ before the rest of the stack runs. On failure
    # the middleware short-circuits with a 401 JSON body matching the
    # shape used by Node/Python SDKs:
    #
    #   { "error": { "code": "authentication_failed", "message": "..." } }
    module Rack
      class RequireAuth
        # @param app [#call] the inner Rack app.
        # @param issuer [String] required — the per-tenant issuer URL.
        # @param audience [String, Array<String>, nil] optional +aud+ to
        #   enforce.
        # @param leeway [Integer] clock-skew tolerance in seconds.
        # @param header [String] which incoming header to read the bearer
        #   token from. Defaults to the Rack-canonical
        #   +HTTP_AUTHORIZATION+; pass a friendlier name like
        #   +"authorization"+ if you prefer.
        def initialize(app, issuer:, audience: nil, leeway: 30, header: 'HTTP_AUTHORIZATION')
          raise ArgumentError, 'issuer is required' if !issuer.is_a?(String) || issuer.empty?

          @app = app
          @issuer = issuer
          @audience = audience
          @leeway = leeway
          @header = header
        end

        def call(env)
          auth = Torii::Backend.authenticate_request(
            env,
            issuer: @issuer,
            audience: @audience,
            leeway: @leeway,
            header: @header,
          )
          env['torii.auth'] = auth
          @app.call(env)
        rescue Torii::Backend::AuthError => e
          unauthorized(e.message)
        end

        private

        def unauthorized(message)
          body = JSON.generate(error: { code: 'authentication_failed', message: message })
          [
            401,
            { 'content-type' => 'application/json', 'content-length' => body.bytesize.to_s },
            [body],
          ]
        end
      end
    end
  end
end
