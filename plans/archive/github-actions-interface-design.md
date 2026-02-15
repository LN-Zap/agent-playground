# GitHub Actions Interface Design

## Objective
Keep one clear default path for adopters while separating advanced image-bake concerns.

## Current Decision (2026-02-15)
Use a **2+1 action model**:

1. `setup-devenv` (primary, default)
2. `bake-devenv-image` (advanced, image build path)
3. `devenv-summary` (reporting, reusable but Devenv-coupled)

Reusable workflows stay thin wrappers/orchestrators.

---

## Current Implementation State

Implemented locally in this repo:
- `.github/actions/setup-devenv`
- `.github/actions/bake-devenv-image`
- `.github/actions/devenv-summary`

Integrated into:
- `.github/workflows/reusable-copilot-setup-steps.yml`
- `.github/workflows/reusable-devenv-image.yml`

Recent hardening:
- removed redundant explicit `npm install` from reusable image workflow
- fixed same-step command verification in `setup-devenv`
- added setup telemetry for runner/script/path diagnostics

---

## Interface Guardrails

### `setup-devenv`
- Modes: `auto`, `image`, `install`
- Must support stale-runner diagnostics and deterministic failures
- Must verify required files/commands with reliable in-step PATH behavior

### `bake-devenv-image`
- Produces activation script and cache metrics
- Keeps scheduling, labels, and permissions in workflows (not action internals)

### `devenv-summary`
- Supports `setup` and `image` summary modes
- Reads previous successful run context via `gh`
- Keeps formatting/reporting logic out of workflows

---

## Publish Path

Phase 1 (now): stabilize interfaces in this repo.

Phase 2: extract actions to `LN-Zap/zap-github-actions` on a feature branch.

Phase 3: pin this repo to released refs (tag/SHA) from shared actions repo.

Phase 4: publish public-facing action interfaces once org-neutral contracts are finalized.

---

## Acceptance Criteria

- Copilot setup and image build both pass on current refs.
- Workflow YAML stays thin and readable (minimal shell boilerplate).
- Summary/reporting logic is centralized in `devenv-summary`.
- Action interfaces are stable enough for extraction to shared repo.
