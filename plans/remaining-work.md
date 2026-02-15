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
- `agent-playground` and `zap-agent-playground` migrated to first-party public action refs on `@master`.
- Latest remote runs green for both key workflows after migration.
- Public action repos (`setup-devenv`, `bake-devenv-image`, `devenv-actions`) were re-curated to clean single-commit histories.

## Overall checklist

- [x] Define publish scope (setup+bake public, summary internal)
- [x] Create dedicated public action repos
- [x] Migrate consumers in `agent-playground`
- [x] Validate end-to-end workflows after migration
- [x] Establish internal downstream repo baseline
- [x] Convert umbrella repo to docs hub
- [x] Clean up history for active public trajectory
- [x] Add producer smoke workflows in public action repos
- [x] Confirm first-party internal strategy: track `@master` for org-owned actions
- [x] Complete full audit of public action repos before creating any tags
- [x] Keep public action repos on clean curated history
- [ ] Finish public template neutralization and governance docs

## Active backlog

## Epic 1 — Public actions publishing (now)
1. ✅ Create dedicated public action repos (`setup-devenv`, `bake-devenv-image`).
2. ✅ Publish action contracts and docs in each repo.
3. ✅ Add producer smoke workflows in each public action repo.
4. ✅ Consume refs from this repo and validate.
5. ✅ Confirm first-party/internal policy to consume org-owned actions via `@master`.
6. ✅ Complete full audit before creating any public tags.
7. ✅ Reserve `LN-Zap/zap-github-actions` for internal reusable workflows/actions.
8. ✅ Keep `devenv-summary` internal until/if genericized.

## Epic 2 — Internal repo split
1. ✅ Create `LN-Zap/zap-agent-playground`.
2. ✅ Push internal baseline from current project state.
3. ⏳ Keep internal-only sources/runners/runbooks in internal repo.
4. ⏳ Document upstream sync policy.

## Epic 3 — Public template rebuild
1. ✅ Create neutral keep/remove file matrix (initial draft below).
2. ⏳ Remove internal/private defaults from public template.
3. ⏳ Default workflows to GitHub-hosted runners.
4. ⏳ Add public governance files and onboarding docs.
5. ⏳ Validate clean external onboarding flow.

### Public template neutralization matrix (initial draft)

| Area | Candidate | Decision | Action |
| --- | --- | --- | --- |
| Workflow runner defaults | `.github/actionlint.yaml` self-hosted label (`copilot-devenv-runner`) | **Make optional** | Keep GitHub-hosted as default path; gate self-hosted checks/docs behind optional mode. |
| Workflow docs/runbooks | `docs/copilot-coding-agent-devenv-runbook.md` (internal runbook sections) | **Split** | Keep public operator guidance; move internal operational specifics to internal repo. |
| Rulesync source config | `rulesync.jsonc`, `rulesync.lock` org/private source references | **Isolate** | Replace public defaults with neutral/public sources; keep internal source wiring only in internal repo. |
| Dev environment wiring | `devenv.nix` references to org-private resources (for example `LN-Zap/zap-skills`) | **Parameterize** | Convert to optional/local override pattern; public default must work without private repos. |
| Auth/env examples | `.env.example` token guidance tied to private use cases | **Generalize** | Keep only public-safe variables and provider-agnostic guidance. |
| CI image workflows | `.github/workflows/devenv-image.yml` + reusable image workflow | **Retain with neutral defaults** | Preserve flow, ensure no internal labels/endpoints are required by default. |
| Plan/archive residue | `plans/archive/*` internal phrasing/context | **Retain as archive** | Keep archived artifacts; ensure active docs clearly represent current OSS policy. |

### Epic 3 execution checklist (prioritized)

- [x] Finalize initial keep/remove decisions for each matrix row with explicit owner/result.
- [ ] Apply runner-default neutralization in workflow configs and lint config.
- [ ] Remove or parameterize private Rulesync/skills references from public defaults.
- [ ] Refactor runbook into public-safe docs + internal-only counterpart.
- [ ] Normalize `.env.example` to public-safe, least-assumption guidance.
- [ ] Re-run workflow smoke checks using only public/default path.
- [ ] Update root README onboarding so external users can succeed without internal assets.

### File-level decision list (implementation queue)

| File / Area | Decision | Planned change |
| --- | --- | --- |
| `.github/actionlint.yaml` | **Edit** | Remove hard requirement on self-hosted label; validate GitHub-hosted default path. |
| `.github/workflows/reusable-copilot-setup-steps.yml` | **Edit** | Keep first-party action refs; ensure default execution path does not require internal runner labels. |
| `.github/workflows/reusable-devenv-image.yml` | **Edit** | Keep workflow; ensure defaults stay public-safe and internal optimizations are optional inputs only. |
| `.github/workflows/devenv-image.yml` | **Keep + edit** | Retain pipeline; verify triggers/inputs assume public-safe defaults only. |
| `rulesync.jsonc` | **Edit** | Replace private/org-specific defaults with neutral/public-safe defaults. |
| `rulesync.lock` | **Regenerate** | Refresh lockfile after `rulesync.jsonc` neutralization to remove stale private-source coupling. |
| `devenv.nix` | **Edit** | Parameterize or guard private repo integrations (for example org-private skill sources). |
| `.env.example` | **Edit** | Keep only broadly applicable variables; rewrite comments to avoid private-org assumptions. |
| `docs/copilot-coding-agent-devenv-runbook.md` | **Split** | Keep public troubleshooting content here; move internal operations/runbook details to internal repo. |
| `README.md` | **Edit** | Align setup/onboarding steps with neutralized defaults and optional internal overlay model. |
| `plans/archive/*` | **Keep** | Preserve historical artifacts; no functional changes required. |

### Step 1 deliverable complete

- Matrix has been converted into a concrete, file-level implementation queue.
- Next implementation pass should begin with workflow/lint defaults (`.github/actionlint.yaml`, reusable workflows), then config neutralization (`rulesync.jsonc`, `devenv.nix`, `.env.example`).

## Epic 4 — Public history strategy
1. ✅ Decision made: fresh-history curated import.
2. ✅ Execute curated public import sequence for active repos.
3. ✅ Re-run history curation after final documentation simplification.
4. ⏳ Run final pre-release audits for internal residue.

## Definition of complete

- Shared actions are published and consumed via current first-party policy.
- Internal downstream repo exists and is operational.
- Public `agent-playground` is clean, neutral, and OSS-ready.
- Public release checks are green.
- Governance includes MIT license files/policies.
- Public action scope includes setup + bake only (summary internal).
