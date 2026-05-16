# frozen_string_literal: true

# Public entry point for torii-backend. Requires lazy-load all
# sub-modules — load order matters only to keep cycles out, not for
# correctness, since each sub-module +require_relative+s its own
# dependencies.

require_relative 'backend/version'
require_relative 'backend/errors'
require_relative 'backend/auth'
require_relative 'backend/verify'
require_relative 'backend/authenticate_request'
require_relative 'backend/webhook'
require_relative 'backend/patch'
require_relative 'backend/client'
require_relative 'backend/rack'

module Torii
  # Backend SDK for torii. See
  # {https://github.com/Torii-ApS/torii torii} for documentation.
  module Backend
  end
end
