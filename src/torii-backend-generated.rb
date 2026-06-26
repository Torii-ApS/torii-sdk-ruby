# frozen_string_literal: true

# Bridge shim: the openapi-generator output is vendored under
# +src/torii/backend/generated/lib+ to keep it isolated from hand-written
# code. Add that directory to +$LOAD_PATH+ and load the generated entry
# point so callers can +require 'torii-backend-generated'+ from anywhere.
#
# The generated entry point (+torii_backend_generated.rb+, gemName from
# regen.sh) requires every model + api, so this shim stays drift-proof: it
# never hand-lists generated files.

generated_root = File.expand_path('torii/backend/generated/lib', __dir__)
$LOAD_PATH.unshift(generated_root) unless $LOAD_PATH.include?(generated_root)

require 'torii_backend_generated'
