# Copilot Fast Path

This repository supports two Copilot setup paths:

- **Fast path**: prebuilt runner snapshot `<repo>-devenv`
- **Fallback path**: dynamic activation on runners without the pre-baked activation script

`devenv.nix` is the single source of truth for toolchain content in both paths.

## One-time setup

1. Configure `RULESYNC_GITHUB_TOKEN` with read access to configured rulesync source repositories.
1. Ensure runner capacity for:
   - `.github/workflows/devenv-image.yml` (build snapshot)
   - `.github/workflows/copilot-setup-steps.yml` on `<repo>-devenv-runner` (consume snapshot)
1. Run `Devenv Image` once.
1. Run `Copilot Setup Steps` and confirm verification passes.

## Workflow roles

- `.github/workflows/devenv-image.yml`
  - builds and refreshes snapshot `<repo>-devenv`
- `.github/workflows/copilot-setup-steps.yml`
  - starts on `<repo>-devenv-runner`
  - activates pre-baked environment
  - verifies required tools (`devenv`, `node`, `python3`, `jq`)

## Action pinning

External action dependencies are pinned to immutable SHAs in workflow files.

## If fast path is not used

If setup logs indicate missing activation script, the workflow falls back to dynamic activation for that run. Refresh/recreate `<repo>-devenv-runner` to restore fast path behavior.
