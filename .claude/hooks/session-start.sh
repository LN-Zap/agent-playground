#!/bin/bash
set -euo pipefail

# Only run in Claude Code remote (web) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}"

# Install npm dependencies (triggers postinstall → rulesync generate)
npm install --ignore-scripts

# Run rulesync to generate agent configs (CLAUDE.md, .claude/, etc.)
npm run --silent rulesync:sync
