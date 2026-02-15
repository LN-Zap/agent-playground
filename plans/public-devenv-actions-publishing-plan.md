# Public Devenv Actions Publishing Plan

## Context (Current)
- Reusable logic is actionized in this repo:
  - `.github/actions/setup-devenv`
  - `.github/actions/bake-devenv-image`
  - `.github/actions/devenv-summary`
- Workflows already consume these local actions.
- Latest remote validation is green.

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

---

## 2) Repository model

Use one public repo containing multiple actions (valid and common).

Target structure:
- `.github/actions/setup-devenv/action.yml`
- `.github/actions/bake-devenv-image/action.yml`

---

## 3) Naming strategy

Decision candidate:
- Keep `setup-devenv` for familiarity with `setup-*` ecosystem pattern.
- Keep `bake-devenv-image` and `devenv-summary` for now.
- Revisit naming harmonization before `v1` only.

---

## 4) Execution plan

### Phase A — Create public actions repo
- Initialize repo and baseline docs.
- Add MIT-aligned licensing/readme metadata.

### Phase B — Import actions
- Copy 2 actions from this repo (`setup-devenv`, `bake-devenv-image`).
- Add per-action README (inputs/outputs/usage/failure modes).
- Add smoke test workflows.

### Phase C — Consumer integration
- Update this repo to consume branch refs from public actions repo.
- Validate `Copilot Setup Steps` and `Devenv Image`.

### Phase D — Versioned release
- Tag release (`v0.x`).
- Pin this repo to immutable tag/SHA refs.
- Document migration snippets for other repos.

---

## 5) Validation requirements

- YAML parse passes.
- actionlint passes.
- Action smoke workflows pass in producer repo.
- Consumer workflows pass in this repo.
- Internal summary output remains correct in this repo.

---

## 6) Definition of done

- Public actions repo is live with 2 versioned actions.
- This repo consumes pinned refs from that public actions repo.
- `zap-github-actions` remains internal-only for shared internal orchestration.
- `devenv-summary` remains internal or is replaced later by a generic trend-summary abstraction.
