# Troubleshooting

## rulesync fetch or rate-limit failures

- Symptom: GitHub API `403`/rate-limit errors during `rulesync install` or `rulesync generate`
- Fix: set `GITHUB_TOKEN` locally and `RULESYNC_GITHUB_TOKEN` in CI with read access to source repositories

## Generated-file drift in CI

- Symptom: CI fails after running rulesync generation with tracked-file changes
- Fix: run `npx rulesync generate --delete` locally and commit intended updates

## Frozen-lock failures

- Symptom: `rulesync install --frozen` fails during `npm install` or git hooks
- Cause: `rulesync.lock` is out of sync with configured sources
- Fix: run `npm run rulesync:update`, review lockfile changes, and commit them intentionally

## Shell reminder: rulesync sources changed

- Symptom: `devenv shell` prints: `Rulesync source files changed. Regenerate outputs: npx rulesync generate --delete`
- Cause: One of `.rulesync/**`, `rulesync.jsonc`, or `rulesync.lock` has staged or unstaged changes
- Fix: run `npx rulesync generate --delete`
- Note: pre-commit also runs frozen install + generate when those files are staged

## Copilot setup missing activation script

- Symptom: setup falls back to dynamic activation and is slower
- Fix: run `Devenv Image` and refresh `<repo>-devenv-runner` instances so they use latest `<repo>-devenv` snapshot

## Tool verification failures (`devenv`, `node`, `python3`, `jq`)

- Symptom: `copilot-setup-steps` verification step fails
- Fix: rebuild image with `Devenv Image`, then rerun `Copilot Setup Steps`
