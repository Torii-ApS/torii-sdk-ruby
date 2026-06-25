#!/usr/bin/env bash
# Set the published gem version. Called by the torii release train (and
# `just sdk-release`) right before tagging. release.yml asserts the tag against
# Torii::Backend::VERSION. Only the hand-written version.rb is touched; the
# generated client's internal version.rb (…/generated/…) is left alone.
set -euo pipefail
cd "$(dirname "$0")"

VERSION="${1:?usage: ./bump.sh <version>  (e.g. 0.0.5)}"
VERSION="${VERSION#v}"
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+([.-][0-9A-Za-z.]+)?$ ]]; then
	echo "✗ invalid version: '$VERSION'" >&2
	exit 1
fi

FILE="src/torii/backend/version.rb"
# \x27 is a literal single quote, so the perl program stays single-quotable.
perl -i -pe 's/(VERSION\s*=\s*\x27)[^\x27]*(\x27)/${1}'"$VERSION"'${2}/' "$FILE"
grep -q "VERSION = '$VERSION'" "$FILE" || { echo "✗ $FILE not bumped to $VERSION" >&2; exit 1; }
echo "✓ torii-sdk-ruby -> $VERSION ($FILE)"
