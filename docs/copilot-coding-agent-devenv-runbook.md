# Copilot Coding Agent + devenv Runbook (Public)

This runbook describes the public, OSS-safe setup for Copilot Coding Agent workflows in this repository.

## Scope

- Public template behavior only
- GitHub-hosted runner defaults
- No private repository assumptions
- No organization-specific runner labels

For Zap-specific internal runner/image operations, use the runbook in `zap-agent-playground`.

## Workflows

This public template uses two workflows:

- `.github/workflows/devenv-image.yml`
- `.github/workflows/copilot-setup-steps.yml`

## Environment model

- `devenv.nix` is the source of truth for tooling.
- `devenv-image.yml` prepares activation assets and optional cache cleanup.
- `copilot-setup-steps.yml` runs setup verification for Copilot job readiness.

Both workflows default to `ubuntu-latest` and consume first-party actions:

- `LN-Zap/setup-devenv@master`
- `LN-Zap/bake-devenv-image@master`

## Secrets

Optional but recommended for stable GitHub API access when fetching remote sources:

- `RULESYNC_GITHUB_TOKEN`

If not set, workflows fall back to `github.token`.

## Operating steps

### 1) Build/update image assets

Run `Devenv Image`:

- Trigger manually with `workflow_dispatch`, or
- Let scheduled/push triggers run automatically.

Expected behavior:

1. Install Nix + devenv
2. Build devenv shell
3. Generate activation script
4. Run cache slimming for configured paths
5. Emit summary metrics

### 2) Validate setup path for Copilot jobs

Run `Copilot Setup Steps`.

Expected behavior:

1. Checkout repository
2. Activate or install devenv environment via `setup-devenv`
3. Verify required tools/files
4. Emit setup summary

## Troubleshooting

- `rulesync`/GitHub fetch failures:
  - Set `RULESYNC_GITHUB_TOKEN` with read access to configured sources.
- Missing tool verification failures (`devenv`, `node`, `python3`, `jq`):
  - Re-run `Devenv Image`, then re-run `Copilot Setup Steps`.
- Nix/devenv setup failures on hosted runners:
  - Re-run once to rule out transient network/cache issues.
  - Check logs in Install Nix / Install devenv / Build devenv shell steps.

## Change management

When changing `devenv.nix`:

1. Commit the change.
2. Run `Devenv Image`.
3. Run `Copilot Setup Steps`.
4. Confirm summary output and tool verification pass.
