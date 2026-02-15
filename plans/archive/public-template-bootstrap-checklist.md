# Public Template Bootstrap Checklist

## Goal
Create a new public, neutral `agent-playground` repository while keeping this repo as the internal Zap implementation.

---

## Phase 0 — Decisions and Guardrails

- [ ] Confirm naming:
  - internal repo: `zap-agent-playground`
  - public repo: `agent-playground`
- [ ] Confirm contribution routing policy:
  - template/generic improvements -> public repo
  - Zap-specific/internal operations -> internal repo
- [ ] Confirm public boundary policy:
  - no private repos, no internal runner labels, no internal runbooks in public defaults

Exit criteria:
- Boundary policy approved by maintainers.

---

## Phase 1 — Create Public Repository Skeleton

- [ ] Create new public GitHub repo: `agent-playground`.
- [ ] Initialize with default branch and baseline files.
- [ ] Enable template-repository mode (GitHub settings).
- [ ] Add required branch protection for main.

Exit criteria:
- Empty public repo exists and is ready for first import commit.

---

## Phase 2 — First Wave File Port (Copy + Sanitize)

## 2.1 Port these files with edits

- [ ] [README.md](README.md)
- [ ] [rulesync.jsonc](rulesync.jsonc)
- [ ] [devenv.nix](devenv.nix)
- [ ] [devenv.yaml](devenv.yaml)
- [ ] [package.json](package.json)
- [ ] [.gitignore](.gitignore)
- [ ] [.rulesync/mcp.json](.rulesync/mcp.json)
- [ ] [.github/workflows/reusable-copilot-setup-steps.yml](.github/workflows/reusable-copilot-setup-steps.yml)
- [ ] [.github/workflows/reusable-devenv-image.yml](.github/workflows/reusable-devenv-image.yml)
- [ ] [.github/workflows/copilot-setup-steps.yml](.github/workflows/copilot-setup-steps.yml)
- [ ] [.github/workflows/devenv-image.yml](.github/workflows/devenv-image.yml)
- [ ] [.github/actions/setup-devenv/action.yml](.github/actions/setup-devenv/action.yml)
- [ ] [.github/actions/bake-devenv-image/action.yml](.github/actions/bake-devenv-image/action.yml)
- [ ] [.github/actions/devenv-summary/action.yml](.github/actions/devenv-summary/action.yml)
- [ ] [.github/actionlint.yaml](.github/actionlint.yaml) (if needed for public workflow labels; otherwise simplify/remove)

## 2.2 Do NOT port these as public defaults

- [ ] Internal runbooks and internal operations docs.
- [ ] Any references to private Zap repos or private runner assumptions.
- [ ] Any internal incident artifacts/content.

Exit criteria:
- Public repo has a coherent first-pass file set with no obvious Zap/private coupling.

---

## Phase 3 — Mandatory Sanitization Changes

## 3.1 README sanitization

- [ ] Replace LN-Zap org-specific URLs and wording with neutral placeholders.
- [ ] Rewrite setup so baseline does not require private token.
- [ ] Move advanced/internal-like setup to optional sections.
- [ ] Keep Supported Tools/Supported Agents sections aligned with `.rulesync/mcp.json` and current targets.

## 3.2 rulesync source sanitization

- [ ] Remove private source entries from [rulesync.jsonc](rulesync.jsonc).
- [ ] Keep only public source repositories by default.
- [ ] Add docs for users to add their own private sources.

## 3.3 Devcontainer/devenv sanitization

- [ ] Remove org-specific repository mapping from devcontainer settings.
- [ ] Keep neutral defaults and optional integration env vars.
- [ ] Ensure baseline `npm install` and environment setup succeed without private assets.

## 3.4 Workflow sanitization

- [ ] Ensure public defaults use GitHub-hosted runners.
- [ ] Remove required assumptions for custom internal labels/images.
- [ ] Keep workflow YAML thin by using reusable actions over inline shell blocks.
- [ ] Remove redundant package-install steps where devenv auto-install already handles dependency install.
- [ ] Keep advanced custom-runner mode as optional guide, not default behavior.

Exit criteria:
- Public repo is runnable in a fork without private repos, private secrets, or custom runners.

---

## Phase 4 — Public Scope Matrix Implementation

## 4.1 MCP defaults

- [ ] Keep default-on: `github`, `context7`, `deepwiki`, `playwright`, `chrome-devtools`.
- [ ] Make optional (documented): `notion`, `pagerduty`, `figma`.
- [ ] Ensure no private/internal MCP endpoints are present.

## 4.2 Skills defaults

- [ ] Keep public skill sources only.
- [ ] Remove Zap-private skill source from defaults.
- [ ] Document extension pattern for team-specific/private skill sources.

## 4.3 Secrets policy

- [ ] Baseline setup requires no private PAT.
- [ ] Optional integrations clearly marked optional.
- [ ] Any secret requirement is tied to optional feature, not baseline.

Exit criteria:
- Public defaults are truly public and low-friction.

---

## Phase 5 — Public Documentation Pack

- [ ] Add `docs/public-quickstart.md`.
- [ ] Add `docs/customization-guide.md` (skills/MCP/workflows).
- [ ] Add `docs/advanced-runners.md` (optional, non-default).
- [ ] Ensure README links to these docs in a clear onboarding sequence.

Exit criteria:
- First-time external user can onboard using docs only.

---

## Phase 6 — OSS Governance and Compliance

- [ ] Add LICENSE.
- [ ] Add CONTRIBUTING.md.
- [ ] Add SECURITY.md.
- [ ] Add CODEOWNERS.
- [ ] Add issue and PR templates.
- [ ] Add release/changelog policy.

Exit criteria:
- Repository is governance-complete for public collaboration.

---

## Phase 7 — Validation and Release Candidate

## 7.1 Automated checks
- [ ] Workflow YAML lint passes.
- [ ] Actionlint passes for public workflow labels.
- [ ] Composite action manifests parse and run in smoke workflows.
- [ ] Setup workflow passes on GitHub-hosted runners.

## 7.2 Manual checks
- [ ] Fresh clone in clean environment succeeds.
- [ ] Public docs walkthrough validated by someone not familiar with this repo.
- [ ] Spot-check for private references across repo.

## 7.3 Pre-release audit commands
- [ ] Run grep audit for org/private residue in public repo.
- [ ] Confirm no internal-only docs/files are included.

Exit criteria:
- Public repo reaches `v0.1` release-candidate readiness.

---

## Phase 8 — Internal Repo Alignment

- [ ] Rename current repo to `zap-agent-playground`.
- [ ] Add note in internal README: this repo tracks public template + internal customizations.
- [ ] Document sync process from public -> internal.
- [ ] Run one complete sync rehearsal and resolve conflicts.

Exit criteria:
- Internal repo is stable and able to ingest public updates predictably.

---

## Fast Start Task List (first 48 hours)

1. [ ] Create public repo and enable template mode.
2. [ ] Port first-wave files.
3. [ ] Remove private rulesync sources and Zap defaults.
4. [ ] Switch workflows to GitHub-hosted runner defaults.
5. [ ] Rewrite README for neutral public onboarding.
6. [ ] Run validation and publish initial public RC.

---

## Ownership Template (fill in)

- Product/Direction owner: [ ]
- Technical implementation owner: [ ]
- Docs owner: [ ]
- Security/compliance owner: [ ]
- Release owner: [ ]

---

## Definition of Done

- Public repo works out-of-the-box for external users.
- No private/internal coupling remains in public defaults.
- Internal repo remains fully operational with Zap-specific capabilities.
- Upstream/downstream sync process is documented and exercised.
