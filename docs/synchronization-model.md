# Synchronization Model

This project keeps agent configuration in source form and regenerates agent-specific output automatically.

## Source of truth

- `.rulesync/` for rules, MCP definitions, and subagent metadata
- `rulesync.jsonc` for targets, features, and remote skill sources

## What is generated

Generated outputs are created by `rulesync generate` into tool-specific paths (for example `.claude/`, `.codex/`, `.gemini/`, `.opencode/`, `.agents/`) and are gitignored.

## Regeneration triggers

- `npm install` runs `postinstall` (`rulesync install` + `rulesync generate --delete`)
- Git hooks (`post-merge`, `post-checkout`) run the same commands
- Manual: `npx rulesync install && npx rulesync generate --delete`

## Drift policy

CI runs rulesync generation and fails if tracked files change after regeneration.

If CI fails for drift:

1. Run `npx rulesync install && npx rulesync generate --delete`
1. Review changes
1. Commit intended source changes and regenerated outputs where appropriate
