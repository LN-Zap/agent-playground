# Formatting and Hooks

This repository uses `treefmt` for formatting/lint orchestration and `simple-git-hooks` for regeneration hooks.

## Enabled formatters/linters

Configured in `devenv.nix`:

- `actionlint` for `.github/workflows/*.yml` and `.github/workflows/*.yaml`
- `mdformat` for maintained docs:
  - `README.md`
  - `docs/**/*.md`

## Why markdown exclusions are needed

The `treefmt` mdformat integration has a broad default markdown include pattern.

To prevent side effects, the repository explicitly excludes metadata/generated markdown paths (for example `.rulesync/**` and generated agent directories) so mdformat does not rewrite frontmatter-sensitive or generated files.

## Enabled hooks

Configured in `package.json` (`simple-git-hooks`):

- `post-checkout`: `npx rulesync install --frozen && npx rulesync generate --delete`
- `post-merge`: `npx rulesync install --frozen && npx rulesync generate --delete`

Configured in `devenv.nix` (`git-hooks`):

- `pre-commit`: `treefmt` (through generated `.pre-commit-config.yaml`)

## Manual commands

- Regenerate sync outputs:
  - `npx rulesync generate --delete`
- Refresh source lockfile intentionally:
  - `npm run rulesync:update`
- Run formatting/lint:
  - `devenv shell -- treefmt`
  - `devenv shell -- actionlint .github/workflows/*.yml`
