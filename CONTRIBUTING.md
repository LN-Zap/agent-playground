# Contributing

Thanks for contributing.

## Development setup

1. Clone the repository
1. Run `npm install` (installs hooks and generates rulesync outputs)
1. Optionally run `direnv allow`

See [README.md](README.md) for full setup.

## What to edit

Edit source files only:

- `.rulesync/`
- `rulesync.jsonc`
- `devenv.nix`
- docs and workflows

Generated agent files are gitignored and should not be committed.

## Before opening a PR

Run:

- `npx rulesync generate --delete`
- `devenv shell -- treefmt`
- `devenv shell -- actionlint .github/workflows/*.yml`

If updating remote rulesync sources intentionally, run:

- `npm run rulesync:update`

## Pull request expectations

- Keep changes focused and scoped.
- Update docs when behavior changes.
- Prefer immutable action pins in workflows.
- Avoid unrelated formatting/refactoring noise.

## Reporting issues

For bugs and regressions, include:

- Repro steps
- Expected vs actual behavior
- Relevant logs or workflow run link
