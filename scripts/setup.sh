#!/bin/sh
set -eu

# Only run in remote environments
if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}"

# Install Node dependencies (triggers postinstall → rulesync sync)
if [ ! -d node_modules ]; then
  npm install >&2
fi

# Persist environment variables for subsequent Bash commands
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  # shellcheck disable=SC2016 # single quotes intentional — written literally to env file
  echo 'export PATH="$PATH:./node_modules/.bin"' >> "$CLAUDE_ENV_FILE"
fi

# Inject generated CLAUDE.md as context for the current session.
# rulesync outputs are generated during npm install but CLAUDE.md is read by
# Claude Code before hooks fire, so the freshly generated rules would otherwise
# be invisible until the next session.
CLAUDE_MD="CLAUDE.md"
if [ -f "$CLAUDE_MD" ]; then
  CONTENT=$(cat "$CLAUDE_MD")
  # Use jq to safely produce valid JSON
  jq -n --arg ctx "$CONTENT" '{
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      additionalContext: $ctx
    }
  }'
fi
