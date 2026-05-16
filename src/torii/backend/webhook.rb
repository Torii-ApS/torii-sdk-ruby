# frozen_string_literal: true

require_relative 'errors'

module Torii
  module Backend
    module_function

    # Verify an outbound torii webhook signature.
    #
    # WARNING: torii's outbound webhook subsystem has not shipped yet
    # (tracked in {https://github.com/GOOD-Code-ApS/torii/issues/424 #424}
    # Phase 0.5). This stub keeps the SDK surface stable so adopting it
    # later won't be a breaking change for callers.
    def verify_webhook(secret:, headers:, payload:) # rubocop:disable Lint/UnusedMethodArgument
      raise AuthError,
            "verifyWebhook: torii's outbound webhook subsystem has not shipped yet " \
            '— see #424 Phase 0.5'
    end
  end
end
