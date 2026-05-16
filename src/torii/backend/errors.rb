# frozen_string_literal: true

module Torii
  module Backend
    # Base class for all errors raised by torii-backend.
    class Error < StandardError; end

    # Raised when /api/server/v1/** responds non-2xx. Inspect +status+, +code+
    # (from the error body if present), and +support_id+ (echoed correlation
    # id) for diagnostics. +body+ is the raw parsed response.
    class ApiError < Error
      attr_reader :status, :code, :support_id, :body

      def initialize(message, status:, body: nil)
        super(message)
        @status = status
        @body = body
        @code = body['code'] if body.is_a?(Hash) && body['code'].is_a?(String)
        @support_id = (body['supportId'] || body['support_id']) if body.is_a?(Hash)
      end
    end

    # Raised by verify_token / authenticate_request when a token cannot be
    # verified (bad signature, wrong issuer, missing claim, expired, ...).
    class AuthError < Error
      attr_reader :cause

      def initialize(message, cause: nil)
        super(message)
        @cause = cause
      end
    end
  end
end
