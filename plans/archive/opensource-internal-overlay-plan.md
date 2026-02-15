# Open Source Readiness Plan

## Two-Repo Strategy (Current)

## 1. Strategic Decision

Maintain a clean public template and a separate internal implementation.

Current direction:
- Public repo: neutral `agent-playground` template
- Internal repo: Zap-specific downstream with private sources, internal runner ops, and incident tooling

Do not sanitize internal operational concerns in-place in the public template path.

---

## 2. Why this is the right approach

Benefits:
- No risk of mixing internal and public concerns in the same repo.
- Public repo can be opinionated for broad adoption, not constrained by internal debt.
- Internal repo keeps velocity and operational context.
- Clear governance boundary: public template vs private implementation.

Tradeoff:
- Requires an explicit sync process from public template -> internal repo.

---

## 3. Repository Boundary Contract

## 3.1 Public repository (template)

Must include:
- Generic template docs and setup.
- Public-safe defaults.
- Public skill sources only.
- GitHub-hosted runner default workflows.

Must not include:
- Zap org/repo references.
- Private skills source references.
- Internal runner label assumptions.
- Internal incident/runbook operational content.

## 3.2 Internal repository (Zap downstream)

May include:
- Zap-specific rulesync sources and secret model.
- Internal custom image and runner strategy.
- Internal runbooks and incident procedures.
- Internal tool/provider assumptions.

---

## 4. Exact Public Scope: What should and should not be included

## 4.1 MCP servers

### Keep in public template (recommended defaults)
- github
- context7
- deepwiki
- playwright
- chrome-devtools

Reason:
- broadly useful for code, docs, browser automation/debugging.
- no company coupling by default.

### Include as optional presets (not default-on)
- notion
- pagerduty
- figma

Reason:
- valid public tools, but often org/account specific and can create setup friction.
- figma local bridge (`127.0.0.1`) is environment-specific and better as opt-in docs/preset.

### Exclude from public defaults
- Any internal/private MCP endpoints.
- Any localhost bridge that is mandatory for baseline startup.

## 4.2 Skills sources

### Keep in public template
- Public upstream sources only (e.g., Anthropic/OpenAI/Cloudflare public skill repos).
- Keep source list small and stable by default.

### Exclude from public template
- Private Zap skills source (currently in [rulesync.jsonc](rulesync.jsonc)).
- Any company-private GitHub source URL.

### Public template pattern
- `rulesync.jsonc` in public repo should require no private token for baseline setup.
- Provide documented "add your private skills source" extension section.

## 4.3 Workflows

### Public defaults
- Use GitHub-hosted runners (`ubuntu-latest`) by default.
- Reusable workflows should run in a fork with no org-specific runner setup.

### Internal-only (keep in internal repo)
- Custom image workflow tied to internal labels.
- Any workflow requiring runner labels like `devenv-image-gen` or `copilot-devenv-runner`.

### Public optional extensions
- Document "advanced custom runner mode" as an optional add-on guide.

## 4.4 Secrets and environment variables

### Public baseline (should be optional)
- No required private PAT for baseline install.
- Secrets only needed for optional integrations.

### Internal-only expectations
- Private token workflows and private source read access.
- Internal provider credentials and production-oriented setup assumptions.

## 4.5 Documentation and branding

### Public docs should
- Use neutral language and org-agnostic examples.
- Explain extension points for teams.

### Public docs should not
- Reference Zap org URLs as defaults.
- Depend on internal runbooks.
- Include internal operational procedures.

---

# 5. Migration Plan

## Phase A: Lock interface baseline (now)

Deliverables:
- Keep action-centric architecture stable (`setup-devenv`, `bake-devenv-image`, `devenv-summary`).
- Ensure wrappers/reusable workflows remain orchestration-only.
- Record validated behavior and known constraints.

## Phase B: Create/refresh public template repo (2-4 days)

Deliverables:
- Create `agent-playground` repository.
- Copy/selectively port only public-safe files and defaults.
- Remove/replace Zap-specific references.

## Phase C: Public hardening and OSS packaging (2-4 days)

Deliverables:
- Public quickstart and extension docs.
- Public workflow validation on GitHub-hosted runners.
- Governance files (license, contributing, security policy, templates).

## Phase D: Internal repo alignment (1-3 days)

Deliverables:
- Point internal repo to public template as upstream reference.
- Keep internal customizations explicit and localized.
- Validate parity for internal dev and CI flows.

## Phase E: Sync model operationalization (ongoing)

Deliverables:
- Documented update cadence.
- Owner-defined merge process for template updates.
- Conflict handling checklist.

---

## 6. File-by-file direction from current state

## 6.1 Files to keep in internal repo and not port directly to public
- Zap-specific runbooks and internal operational docs.
- Internal runner topology assumptions in workflows.
- Private source defaults.

## 6.2 Files to port to public with edits
- README.md (neutralize org references and defaults)
- rulesync.jsonc (public-only skill sources)
- devenv.nix (remove internal defaults/assumptions)
- .devcontainer.json (remove org-specific repository mapping)
- Reusable workflows (public runner defaults)

## 6.3 New files for public repo
- Public quickstart guide
- Optional integrations guide (Notion/PagerDuty/Figma etc.)
- Advanced runners guide (optional, non-default)
- Template customization guide (skills, MCP, workflows)

---

## 7. Risks and mitigations

## Risk 1: Public repo still carries internal residue
Mitigation:
- enforce a pre-release grep audit for org names, private repos, runner labels, and internal secret names.

## Risk 2: Internal repo drifts too far from public template
Mitigation:
- define strict "customization boundaries" and scheduled upstream sync.

## Risk 3: Public template becomes too thin to be useful
Mitigation:
- keep robust public defaults and provide optional advanced modules as documented add-ons.

## Risk 4: Team confusion on where to contribute
Mitigation:
- explicit contribution routing docs:
  - generic/template improvements -> public repo
  - Zap-specific operations -> internal repo

---

## 8. Validation checklist before public launch

- Public clone works with baseline setup and no private tokens.
- CI passes on GitHub-hosted runners only.
- No references to Zap-private repos/labels in defaults.
- MCP defaults are account-agnostic and documented.
- Skills sources are public only.
- Docs are neutral and complete for first-time users.

---

## 9. Definition of Done

Done when:
- `agent-playground` is fully usable as a neutral public template.
- `zap-agent-playground` preserves internal capabilities without blocking template quality.
- There is a documented, repeatable process for syncing public improvements into internal usage.

---

## 10. Immediate next actions (updated)

1. Complete extraction of shared actions to `LN-Zap/zap-github-actions`.
2. Keep this repo as the proving ground until shared actions are pinned.
3. Bootstrap the clean public template from stabilized shared interfaces.
4. Validate public defaults on GitHub-hosted runners.
5. Publish public `v0.1` template with clear downstream customization model.
