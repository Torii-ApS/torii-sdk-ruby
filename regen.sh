#!/usr/bin/env bash
# Regenerate the generated REST client under src/torii/backend/generated/ from
# spec/server-v1.json. Idempotent; safe to re-run after a spec bump.
set -euo pipefail
cd "$(dirname "$0")"

# Clear the vendored lib first so renamed/removed models (e.g. a spec rename
# UserResponse -> ServerUserResponse) don't leave stale files behind.
rm -rf src/torii/backend/generated/lib

npx -y @openapitools/openapi-generator-cli generate \
  -i spec/server-v1.json -g ruby -o src/torii/backend/generated \
  --additional-properties=gemName=torii_backend_generated,moduleName=ToriiBackendGenerated

echo "✓ regenerated src/torii/backend/generated/ from spec/server-v1.json"
