# Maintenance Guide

This document describes routine maintenance for this repository.

## Scope

The source of truth is:

- `.rulesync/`
- `rulesync.jsonc`
- `devenv.nix`
- `.github/workflows/`

Generated outputs are intentionally not committed.

## Regular Maintenance Tasks

### 1) Rulesync source updates

When you intentionally refresh remote skill/source refs:

1. Run `npm run rulesync:update`
1. Review `rulesync.lock` changes
1. Run `npx rulesync generate --delete`
1. Commit intentional updates

Do not run source updates as part of unrelated changes.

### 2) Validate deterministic generation

Before merge:

1. Run `npx rulesync generate --delete`
1. Run workflow lint: `devenv shell -- actionlint .github/workflows/*.yml`
1. Run formatter/lint: `devenv shell -- treefmt`

CI also enforces rulesync drift checks.

### 3) Action SHA bump procedure

External workflow actions are pinned to immutable SHAs.

When bumping:

1. Update the SHA and comment in workflow file
1. Run local lint (`actionlint`)
1. Trigger relevant workflows and confirm green runs
1. Document behavior changes in README/docs when needed

### 4) Fast-path health checks

If Copilot fast path appears degraded:

1. Run `Devenv Image`
1. Run `Copilot Setup Steps`
1. Check workflow summary for fast-path usage
1. If fallback is used, refresh runner capacity/image assignment

See [docs/copilot-fast-path.md](docs/copilot-fast-path.md).

## Change Discipline

- Keep README aligned with implementation.
- Keep `Supported Tools` in README aligned with `.rulesync/mcp.json`.
- Keep `Supported Agents` in README aligned with configured targets.
- Keep formatter scope limited to maintained docs to avoid generated-file side effects.
