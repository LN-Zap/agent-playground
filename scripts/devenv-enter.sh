#!/bin/sh
# devenv enterShell hook — validates git hooks and rulesync state.

hello
git --version
python3 --version

if [ -d .git ] && { [ ! -x .git/hooks/post-checkout ] || [ ! -x .git/hooks/post-merge ]; }; then
  if [ -d node_modules ]; then
    echo "ℹ️  Git sync hooks missing; attempting install via npm run prepare"
    npm run --silent prepare >/dev/null 2>&1 || true
  fi

  if [ ! -x .git/hooks/post-checkout ] || [ ! -x .git/hooks/post-merge ]; then
    echo "⚠️  Git sync hooks are not installed yet. Run: npm run prepare"
  fi
fi

if [ -d .git ] && {
  ! git diff --quiet -- .rulesync rulesync.jsonc rulesync.lock 2>/dev/null ||
  ! git diff --cached --quiet -- .rulesync rulesync.jsonc rulesync.lock 2>/dev/null;
}; then
  echo "⚠️  Rulesync source files changed. Regenerate outputs: npx rulesync generate --delete"
fi
