# frozen_string_literal: true

# Bridge shim: the openapi-generator output is vendored under
# +lib/torii/backend/generated/lib+ to keep it isolated from
# hand-written code. We add that directory to +$LOAD_PATH+ here and
# then load the generated entry point so callers can simply
# +require 'torii-backend-generated'+ from anywhere in the gem.

generated_root = File.expand_path('torii/backend/generated/lib', __dir__)
$LOAD_PATH.unshift(generated_root) unless $LOAD_PATH.include?(generated_root)

require 'torii-backend-generated/api_client'
require 'torii-backend-generated/api_error'
require 'torii-backend-generated/api_model_base'
require 'torii-backend-generated/version'
require 'torii-backend-generated/configuration'

require 'torii-backend-generated/models/create_user_request'
require 'torii-backend-generated/models/cursor_page_response_user_response'
require 'torii-backend-generated/models/server_user_search_request'
require 'torii-backend-generated/models/update_user_request'
require 'torii-backend-generated/models/user_response'
require 'torii-backend-generated/models/user_session_response'

require 'torii-backend-generated/api/server_sessions_api'
require 'torii-backend-generated/api/server_users_api'
