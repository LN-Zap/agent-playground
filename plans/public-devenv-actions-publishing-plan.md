# Public Devenv Actions Publishing Plan

## Context (Current)
- Reusable logic is actionized in this repo:
  - `.github/actions/setup-devenv`
  - `.github/actions/bake-devenv-image`
  - `.github/actions/devenv-summary`
- Public action repos now exist and are live:
  - `LN-Zap/setup-devenv`
  - `LN-Zap/bake-devenv-image`
- `agent-playground` workflows now consume SHA-pinned refs from those public repos.
- Latest remote validation is green after migration.

Goal:
- Publish these as **public reusable actions**.
- Keep `LN-Zap/zap-github-actions` for internal workflow reuse, not public action distribution.

---

## 1) Publish Scope

Publish now:
1. `setup-devenv`
2. `bake-devenv-image`

Keep internal (for now):
- `devenv-summary`

Rationale:
- `setup-devenv` and `bake-devenv-image` are cleaner public primitives.
- `devenv-summary` is currently tightly coupled to Devenv-specific metrics and log parsing.

Status: ✅ Completed and aligned

---

## 2) Repository model

Use one repo per action for clean external consumer syntax.

Selected model:
- `LN-Zap/setup-devenv`
- `LN-Zap/bake-devenv-image`

Status: ✅ Completed

---

## 3) Naming strategy

Decision candidate:
- Keep `setup-devenv` for familiarity with `setup-*` ecosystem pattern.
- Keep `bake-devenv-image` and `devenv-summary` for now.
- Revisit naming harmonization before `v1` only.

---

## 4) Execution plan

### Phase A — Create public action repos
- [x] Initialize dedicated repos and baseline docs.
- [x] Add MIT-aligned licensing/readme metadata.

### Phase B — Import actions
- [x] Copy 2 actions from this repo (`setup-devenv`, `bake-devenv-image`).
- [x] Add per-action README (inputs/outputs/usage/failure modes).
- [x] Add smoke test workflows in each producer repo.

### Phase C — Consumer integration
- [x] Update this repo to consume public action refs (SHA pinned).
- [x] Validate `Copilot Setup Steps` and `Devenv Image`.

### Phase D — Versioned release
- [x] Complete full audit of both public action repos.
- [ ] Decide if public tags should be introduced after audit.
- [x] This repo currently pinned to immutable SHAs.
- [x] First-party/internal consumers remain SHA pinned.
- [ ] Document migration snippets for downstream repos.

---

## 5) Validation requirements

- YAML parse passes.
- actionlint passes.
- Action smoke workflows pass in producer repo.
- Consumer workflows pass in this repo.
- Internal summary output remains correct in this repo.

---

## 6) Definition of done

- Public action repos are live with 2 versioned actions.
- This repo consumes pinned refs from those public action repos.
- `zap-github-actions` remains internal-only for shared internal orchestration.
- `devenv-summary` remains internal or is replaced later by a generic trend-summary abstraction.

Current completion: 3 / 4 done (blocking item is post-audit release/versioning).
