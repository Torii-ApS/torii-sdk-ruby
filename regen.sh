#!/usr/bin/env bash
# Regenerate the generated REST client under src/torii/backend/generated/ from
# spec/server-v1.json. Idempotent; safe to re-run after a spec bump.
set -euo pipefail
cd "$(dirname "$0")"

npx -y @openapitools/openapi-generator-cli generate \
  -i spec/server-v1.json -g ruby -o src/torii/backend/generated \
  --additional-properties=gemName=torii_backend_generated,moduleName=ToriiBackendGenerated

echo "✓ regenerated src/torii/backend/generated/ from spec/server-v1.json"
