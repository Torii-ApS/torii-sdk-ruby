# frozen_string_literal: true

module Torii
  module Backend
    # Subset of fields the backend SDK exposes from a verified torii JWT.
    # For full claim access (custom claims, audience, etc.) read +raw+.
    #
    # Kept as a plain Struct for Ruby 3.1 compatibility (Data.define is
    # 3.2+). Behaviour is the same — frozen value object, positional or
    # keyword construction, hash-like access.
    Auth = Struct.new(
      :user_id,
      :environment_id,
      :issuer,
      :email_verified,
      :profile_complete,
      :impersonating,
      :locale,
      :raw,
      keyword_init: true,
    ) do
      def initialize(*) # rubocop:disable Lint/MissingSuper
        super
        freeze
      end
    end
  end
end
