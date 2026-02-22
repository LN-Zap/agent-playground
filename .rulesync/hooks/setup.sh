#!/bin/sh
set -eu

# Only run in remote environments
if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}"

# Install Node dependencies (triggers postinstall → rulesync sync)
if [ ! -d node_modules ]; then
  npm install
fi

# Persist environment variables for subsequent Bash commands
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  # shellcheck disable=SC2016 # single quotes intentional — written literally to env file
  echo 'export PATH="$PATH:./node_modules/.bin"' >> "$CLAUDE_ENV_FILE"
fi
