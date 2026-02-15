# OSS Transition Master Plan (Agent Playground)

## End Goal

Publish `agent-playground` as a clean, open-source-ready template while preserving and advancing Zap-specific/internal capabilities in a separate internal repository.

This includes:
1. Extracting Devenv GitHub Actions into shared repos and publishing versioned releases.
2. Creating `zap-agent-playground` as the internal downstream repo.
3. Reworking `agent-playground` into a neutral public template.
4. Delivering clean, intentional history for the public repo launch.

## Overall Progress Checklist

- [x] Public scope locked: publish `setup-devenv` + `bake-devenv-image`; keep `devenv-summary` internal
- [x] Dedicated public repos created: `LN-Zap/setup-devenv`, `LN-Zap/bake-devenv-image`
- [x] Public docs hub created: `LN-Zap/devenv-actions` (docs-only)
- [x] `zap-agent-playground` created and baseline established
- [x] `agent-playground` workflows switched to public action refs with SHA pinning
- [x] End-to-end workflow validation passed after migration
- [x] Fresh-history cleanup executed for the active OSS trajectory
- [ ] Create and adopt stable major tags (`v1`) for public actions
- [ ] Complete public template neutralization + governance hardening

---

## Program Tracks

## Track A — Actions Strategy (Public + Internal)

Scope:
- Publicly publish:
  - `setup-devenv`
  - `bake-devenv-image`
- Keep internal reusable workflows in internal infra repo(s).
- Keep `devenv-summary` internal until/if a generic trend-summary core is designed.

Execution:
1. Create dedicated public action repos (one repo per action).
2. Add per-action docs (inputs/outputs/examples/failure modes).
3. Add producer-repo smoke workflows.
4. Tag versions (`v0.x` then `v1` when stable).
5. Switch this repo to pinned public action refs.
6. Keep `LN-Zap/zap-github-actions` for internal shared workflows/actions only.

Status:
- Completed: repo split, docs, and pinned consumer migration
- Remaining: producer smoke workflows + stable tagging strategy

Exit criteria:
- Actions are versioned and consumable externally.
- This repo no longer depends on local action copies.

---

## Track B — Internal Repo Split (`zap-agent-playground`)

Scope:
- Create internal downstream home for Zap-specific behavior.
- Push current internal configuration/workflows there.

Execution:
1. `LN-Zap/zap-agent-playground` has been created.
2. Current codebase baseline has been pushed there.
3. Keep internal-only items there:
   - private rulesync sources
   - internal runner labels and custom images
   - incident/runbook operational material
4. Add internal README section defining upstream sync policy.

Status:
- Completed: creation + baseline push
- Remaining: codify and document upstream sync policy

Exit criteria:
- Internal repo is operational and authoritative for Zap-specific ops.

---

## Track C — Public Template Rebuild (`agent-playground`)

Scope:
- Make public repo fully neutral and low-friction.

Execution:
1. Remove internal/private defaults and references.
2. Default workflows to GitHub-hosted runners.
3. Keep advanced custom-runner mode as optional docs.
4. Keep Supported Tools/Agents synced with source config.
5. Provide clear extension points for private/org customization.

Exit criteria:
- Fresh external user can onboard without private repos, internal runner labels, or private operational context.

Status:
- In progress: foundational OSS split complete
- Remaining: explicit neutralization pass and onboarding polish

---

## Track D — Clean History Strategy

Two viable options:

### Option 1 (recommended): Fresh-history public repo
- Start `agent-playground` from a curated import commit set.
- Keep internal/full historical context in `zap-agent-playground`.
- Pros: safest, fastest, least risk of leakage.
- Cons: no full historical continuity in public repo.

### Option 2: Rewrite existing history for public release
- Use filter tooling and secret/private-reference scrubs.
- Pros: preserves chronology.
- Cons: high risk and high review burden.

Decision:
- Use **Option 1 (fresh curated history)**.

Exit criteria:
- Public repo history contains only intended open-source content.

Status:
- In progress/completed for active repos: history has been cleaned and curated
- Remaining: final audit at public launch cut

---

## Track E — Validation and Release

Validation matrix:
- Actionlint/YAML checks pass.
- Public workflows pass on GitHub-hosted runners.
- Internal workflows pass on Zap runners.
- Shared actions pass producer smoke tests and consumer tests.

Release gates:
1. Shared actions published and pinned.
2. Internal repo created and stable.
3. Public repo passes onboarding and CI smoke checks.
4. Governance files present with **MIT** license policy:
  - `LICENSE` (MIT)
  - `CONTRIBUTING.md`
  - `SECURITY.md`
  - issue/PR templates

---

## Execution Order (Recommended)

1. Track A (public actions extraction/publish + internal workflow boundary)
2. Track B (create/push `zap-agent-playground`)
3. Track C + D (public template rebuild + clean history approach)
4. Track E (final validation + release)

---

## Immediate Next Actions

1. Create stable major tags (`v1`) in both public action repos.
2. Decide consumer pinning policy (`@v1` vs SHA) and apply consistently.
3. Draft/execute explicit public template keep/remove matrix.
4. Complete governance and onboarding hardening for public template release.

Current public action scope lock:
- publish `setup-devenv` and `bake-devenv-image`
- keep `devenv-summary` internal for now
