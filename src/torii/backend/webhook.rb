# frozen_string_literal: true

require_relative 'errors'

module Torii
  module Backend
    module_function

    # Verify an outbound torii webhook signature.
    #
    # WARNING: torii's outbound webhook subsystem is not yet available. This
    # stub reserves the SDK surface so adopting it later won't be a breaking
    # change for callers.
    def verify_webhook(secret:, headers:, payload:) # rubocop:disable Lint/UnusedMethodArgument
      raise AuthError,
            "verifyWebhook: torii's outbound webhook subsystem is not yet available."
    end
  end
end
