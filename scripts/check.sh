#!/usr/bin/env bash
# 构建 + 测试门禁。用法：scripts/check.sh [--build-only]
set -euo pipefail
cd "$(dirname "$0")/.."

xcodegen generate
xcodebuild -scheme Mochi -destination 'platform=macOS' -quiet build

if [[ "${1:-}" != "--build-only" ]]; then
  xcodebuild -scheme Mochi -destination 'platform=macOS' -quiet test
fi
echo "check passed"
