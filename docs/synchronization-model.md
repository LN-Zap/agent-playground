# Synchronization Model

This project keeps agent configuration in source form and regenerates agent-specific output automatically.

## Source of truth

- `.rulesync/` for rules, MCP definitions, and subagent metadata
- `rulesync.jsonc` for targets, features, and remote skill sources

## What is generated

Generated outputs are created by `rulesync generate` into tool-specific paths (for example `.claude/`, `.codex/`, `.gemini/`, `.opencode/`, `.agents/`) and are gitignored.

## Regeneration triggers

- `npm install` runs `postinstall` (`rulesync install --frozen` + `rulesync generate --delete`)
- Git hooks (`post-merge`, `post-checkout`) run the same frozen flow
- `pre-commit` runs the same frozen flow when staged files match `.rulesync/**`, `rulesync.jsonc`, or `rulesync.lock`
- Manual deterministic regen: `npx rulesync generate --delete`
- Manual source refresh: `npm run rulesync:update`

## First-time bootstrap requirement

Automatic post-merge/post-checkout regeneration depends on git hooks being installed once.

- Run `npm install` after cloning to install hooks.
- In dev containers/Codespaces, `postCreateCommand` runs `devenv shell -- npm run prepare` to install hooks in the live checkout.
- In dev containers/Codespaces, `updateContentCommand` runs a one-time warm-up and writes `.devenv/.warmup-done` so repeated startups skip duplicate warm-up.
- If hooks are still missing in a shell and `node_modules` exists, `devenv` shell retries `npm run prepare` automatically.
- `devenv` shell prints a warning only if hooks are still missing after that retry.
- `devenv` shell also prints a reminder when `.rulesync/**`, `rulesync.jsonc`, or `rulesync.lock` are modified.

## Frozen-lock policy

`--frozen` is used by default to keep local and CI behavior deterministic and to prevent unexpected lockfile churn.

When intentionally updating remote sources, use `npm run rulesync:update` and commit the resulting `rulesync.lock` changes.

## Drift policy

CI runs rulesync generation and fails if tracked files change after regeneration.

If CI fails for drift:

1. Run `npx rulesync generate --delete`
1. Review changes
1. Commit intended source changes and regenerated outputs where appropriate
