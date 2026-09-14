#!/usr/bin/env bash
set -euo pipefail

output=$("$JQ" --version)
if [[ ! "$output" =~ "jq" ]]; then
  echo "ERROR: Expected 'jq' in version output, got: $output"
  exit 1
fi
