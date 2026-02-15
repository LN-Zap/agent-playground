# Remaining Work Backlog

Primary reference: `plans/oss-transition-master-plan.md`.

## Current state (2026-02-15)

Done:
- Local actionization complete (`setup-devenv`, `bake-devenv-image`, `devenv-summary`).
- Reusable workflows migrated to those actions.
- Setup verification false-negative fixed; telemetry added for activation diagnostics.
- Public split complete into dedicated repos:
	- `LN-Zap/setup-devenv`
	- `LN-Zap/bake-devenv-image`
- `LN-Zap/devenv-actions` converted to docs-only hub.
- `LN-Zap/zap-agent-playground` created and baseline synchronized.
- `agent-playground` migrated to public SHA-pinned action refs.
- Latest remote runs green for both key workflows after migration.

## Overall checklist

- [x] Define publish scope (setup+bake public, summary internal)
- [x] Create dedicated public action repos
- [x] Migrate consumers in `agent-playground`
- [x] Validate end-to-end workflows after migration
- [x] Establish internal downstream repo baseline
- [x] Convert umbrella repo to docs hub
- [x] Clean up history for active public trajectory
- [x] Add producer smoke workflows in public action repos
- [x] Confirm first-party pin strategy: SHA only
- [ ] Complete full audit of public action repos before creating any tags
- [ ] Finish public template neutralization and governance docs

## Active backlog

## Epic 1 — Public actions publishing (now)
1. ✅ Create dedicated public action repos (`setup-devenv`, `bake-devenv-image`).
2. ✅ Publish action contracts and docs in each repo.
3. ✅ Add producer smoke workflows in each public action repo.
4. ✅ Consume refs from this repo and validate.
5. ✅ Confirm SHA-only pin policy for first-party/internal consumers.
6. ⏳ Complete full audit before creating any public tags.
7. ✅ Reserve `LN-Zap/zap-github-actions` for internal reusable workflows/actions.
8. ✅ Keep `devenv-summary` internal until/if genericized.

## Epic 2 — Internal repo split
1. ✅ Create `LN-Zap/zap-agent-playground`.
2. ✅ Push internal baseline from current project state.
3. ⏳ Keep internal-only sources/runners/runbooks in internal repo.
4. ⏳ Document upstream sync policy.

## Epic 3 — Public template rebuild
1. ⏳ Create neutral keep/remove file matrix.
2. ⏳ Remove internal/private defaults from public template.
3. ⏳ Default workflows to GitHub-hosted runners.
4. ⏳ Add public governance files and onboarding docs.
5. ⏳ Validate clean external onboarding flow.

## Epic 4 — Public history strategy
1. ✅ Decision made: fresh-history curated import.
2. ✅ Execute curated public import sequence for active repos.
3. ⏳ Run final pre-release audits for internal residue.

## Definition of complete

- Shared actions are published and pinned.
- Internal downstream repo exists and is operational.
- Public `agent-playground` is clean, neutral, and OSS-ready.
- Public release checks are green.
- Governance includes MIT license files/policies.
- Public action scope includes setup + bake only (summary internal).
