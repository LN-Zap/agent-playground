# Remaining Work Backlog

Primary reference: `plans/oss-transition-master-plan.md`.

## Current state (2026-02-15)

Done:
- Local actionization complete (`setup-devenv`, `bake-devenv-image`, `devenv-summary`).
- Reusable workflows migrated to those actions.
- Setup verification false-negative fixed; telemetry added for activation diagnostics.
- Latest remote runs green for both key workflows.

## Active backlog

## Epic 1 — Public actions publishing (now)
1. Create/select public actions repo (single repo containing multiple actions).
2. Copy `setup-devenv` and `bake-devenv-image` and add README + interface contracts.
3. Add producer smoke workflows in actions repo.
4. Consume refs from this repo and validate.
5. Tag release and pin this repo to immutable refs.
6. Reserve `LN-Zap/zap-github-actions` for internal reusable workflows/actions.
7. Keep `devenv-summary` internal until/if genericized.

## Epic 2 — Internal repo split
1. Create `LN-Zap/zap-agent-playground`.
2. Push internal baseline from current project state.
3. Keep internal-only sources/runners/runbooks in internal repo.
4. Document upstream sync policy.

## Epic 3 — Public template rebuild
1. Create neutral keep/remove file matrix.
2. Remove internal/private defaults from public template.
3. Default workflows to GitHub-hosted runners.
4. Add public governance files and onboarding docs.
5. Validate clean external onboarding flow.

## Epic 4 — Public history strategy
1. Decision made: fresh-history curated import.
2. Execute curated public import sequence.
3. Run pre-release audits for internal residue.

## Definition of complete

- Shared actions are published and pinned.
- Internal downstream repo exists and is operational.
- Public `agent-playground` is clean, neutral, and OSS-ready.
- Public release checks are green.
- Governance includes MIT license files/policies.
- Public action scope includes setup + bake only (summary internal).
