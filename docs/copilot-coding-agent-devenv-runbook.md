# Copilot Coding Agent + devenv Runbook

This runbook describes how to operate the Copilot Coding Agent environment so it matches `devenv.nix` while keeping startup fast.

## Goal

- Keep `devenv.nix` as the single source of truth for tooling.
- Use a custom image for fast startup on the Copilot Coding Agent.
- Keep Copilot setup lean by consuming the pre-baked image directly (no runtime reinstall).

## Why this needs a custom-image runner

The image build job is not only about more CPU. It must also produce a reusable custom image (`copilot-devenv`) that Copilot setup jobs can run on later.

- More cores speed up build time.
- Custom-image support enables build-once/reuse-many startup performance.
- A plain larger runner without custom-image support cannot replace this workflow end-to-end.

## Do we need to run our own infrastructure?

Not always. There are two valid setup modes:

1. **GitHub-managed custom-image runners (no self-hosted infra)**
   - Use this if your GitHub plan/org has Actions custom images available.
   - Runner capacity is managed by GitHub.
   - Recommended when available.

2. **Self-hosted runners with custom images enabled**
   - Use this when GitHub-managed custom images are not available to your org.
   - You manage compute (VMs/scale/cost/patching).

## How to choose quickly

In GitHub settings, check whether your organization/repository can create and use custom images for Actions runners.

- If yes: use GitHub-managed custom-image runners.
- If no: use self-hosted runner infrastructure.

## Files Involved

- `.github/workflows/devenv-image.yml`
- `.github/workflows/copilot-setup-steps.yml`
- `devenv.nix`

## Required Secrets and Access

Because `npm install` runs `rulesync` and this repo depends on private/remote skill sources, workflows need a GitHub token with adequate API quota and repository access.

### Secret name used by workflows

- `RULESYNC_GITHUB_TOKEN`

Both workflows export this token to `GITHUB_TOKEN` and `GH_TOKEN` during job execution, with fallback to the default `github.token` when the secret is absent.

### Token requirements

Use a fine-grained PAT (recommended):

- Resource owner: account/org that can read all configured `rulesync` source repositories
- Repository access: include private repo `LN-Zap/zap-skills`
- Permissions:
   - `Contents: Read-only`
   - `Metadata: Read-only`

### Where to configure the secret

Set `RULESYNC_GITHUB_TOKEN` in one of these locations:

1. Repository secret (simplest)
2. Organization secret scoped to this repository
3. Environment secret (if workflows are bound to an environment)

If you use environment secrets, ensure the workflows run in that environment and that required approvals/policies allow execution.

### GitHub UI click-path steps

#### Option A: Repository secret (recommended default)

1. Open repository Settings.
2. Go to Secrets and variables → Actions.
3. Select Secrets tab.
4. Click New repository secret.
5. Name: `RULESYNC_GITHUB_TOKEN`.
6. Paste PAT value and save.

Use this when only this repository needs access.

#### Option B: Organization secret (multiple repositories)

1. Open organization Settings.
2. Go to Secrets and variables → Actions.
3. Select Secrets tab.
4. Click New organization secret.
5. Name: `RULESYNC_GITHUB_TOKEN`.
6. Choose repository access policy and include this repository.
7. Paste PAT value and save.

Use this when several repositories share the same rulesync source access model.

#### Option C: Environment secret (approval-controlled)

1. Open repository Settings.
2. Go to Environments.
3. Open target environment (for example, `copilot`) or create it.
4. Under Environment secrets, click Add secret.
5. Name: `RULESYNC_GITHUB_TOKEN`.
6. Paste PAT value and save.
7. Ensure workflow jobs are configured to run in that environment.

Use this when you need branch protections, required reviewers, or environment-level controls.

### Quick validation after secret creation

1. Run `Devenv Image` manually.
2. Confirm logs no longer show rulesync GitHub API rate-limit/403 failures for configured sources.
3. Run `Copilot Setup Steps` and confirm successful npm/rulesync execution.

### Why default `github.token` is not enough here

- It often cannot read private repositories outside the current repository scope.
- It can also hit lower effective API limits for this usage pattern.
- Result: intermittent `403`/rate-limit errors during `rulesync install` and `rulesync generate`.

## One-Time Setup (GitHub Settings)

Configure two Linux x64 runners with at least 4 cores (GitHub-managed custom-image or self-hosted, depending on availability):

1. **Image generation runner**
   - Label: `devenv-image-gen`
   - Requirement: custom-image support enabled
   - Purpose: builds and snapshots `copilot-devenv`

2. **Copilot setup runner**
   - Label: `copilot-devenv-runner`
   - Base image: `copilot-devenv`
   - Purpose: executes `copilot-setup-steps` with pre-baked devenv dependencies

Before running either workflow, configure `RULESYNC_GITHUB_TOKEN` as described above.

### Setup path A: GitHub-managed (preferred when available)

1. In GitHub Actions runner settings, create runner capacity for image generation with label `devenv-image-gen`.
2. Ensure custom images are enabled for that runner capacity.
3. Run the `Devenv Image` workflow once to produce `copilot-devenv`.
4. Create Copilot setup runner capacity with label `copilot-devenv-runner` using image `copilot-devenv`.
5. Run `Copilot Setup Steps` to validate.

### Setup path B: Self-hosted infrastructure

1. Provision Linux x64 runner hosts (recommended 4+ cores).
2. Register one runner with label `devenv-image-gen` and custom-image capability enabled.
3. Trigger `Devenv Image` to create `copilot-devenv`.
4. Register a second runner with label `copilot-devenv-runner` configured to use `copilot-devenv`.
5. Run `Copilot Setup Steps` to validate.

## Image Build and Refresh

Workflow: `.github/workflows/devenv-image.yml`

Triggers:

- Weekly schedule
- Pushes touching `devenv.nix`, `devenv.yaml`, or `devenv.lock`
- Manual `workflow_dispatch`

Build flow:

1. Checkout repository
2. Install Nix
3. Configure Cachix (`devenv`)
4. Install `devenv`
5. Build devenv shell (`devenv shell -- echo 'devenv ready'`)
6. Run `devenv shell -- npm ci --ignore-scripts --no-audit --fund=false`
7. Run `devenv shell -- npx rulesync install && npx rulesync generate --delete`
8. Snapshot image as `copilot-devenv`

## Copilot Setup Flow

Workflow: `.github/workflows/copilot-setup-steps.yml`

Primary path (custom image present):

1. Checkout repository
   - Uses `clean: false` so pre-baked generated artifacts are preserved.
   - Uses `SKIP_SIMPLE_GIT_HOOKS=1` so checkout does not trigger repository hooks.
2. Export devenv environment to `GITHUB_PATH` and `GITHUB_ENV`
3. Verify pre-baked runtime tools and generated artifacts exist

No runtime npm install or rulesync generation should be needed in this workflow when the runner image is correctly baked.

## Verification Checklist

After setup or updates:

1. Trigger `Devenv Image` workflow manually.
2. Confirm `copilot-devenv` appears in org/repo custom images.
3. Run `Copilot Setup Steps` workflow and verify all steps pass.
4. Confirm agent runtime tools are available (for example: `node`, `python3`, `jq`, `gcloud`).
5. Confirm setup time target:
   - Custom image path: under 1 minute
6. Confirm no `rulesync` GitHub API `403`/rate-limit errors appear in workflow logs.

## New Fork Bootstrap Checklist (first-time setup)

Use this when creating a fresh copy of the repository and setting it up from zero.

1. Fork or clone the repository.
2. Confirm `rulesync.jsonc` sources include all repositories you intend to use.
3. Create a fine-grained PAT with read access to required source repositories (including private `LN-Zap/zap-skills` if used).
4. Add `RULESYNC_GITHUB_TOKEN` secret (repository, organization, or environment).
5. Configure runner strategy:
   - GitHub-managed custom-image runners if available, otherwise self-hosted.
6. Create image builder runner with label `devenv-image-gen` and custom-image support.
7. Run `Devenv Image` workflow once and verify `copilot-devenv` image exists.
8. Create setup runner with label `copilot-devenv-runner` using base image `copilot-devenv`.
9. Run `Copilot Setup Steps` workflow and confirm success.
10. Confirm workflow logs contain no rulesync private-repo access errors.
11. Assign a test issue to Copilot Coding Agent and validate tooling availability (`node`, `python3`, `jq`, `gcloud`).

## Troubleshooting

- **Runner label mismatch**: ensure workflow `runs-on` labels match configured runners exactly.
- **`rulesync` 403/rate-limit errors**: verify `RULESYNC_GITHUB_TOKEN` is set and can read `LN-Zap/zap-skills`.
- **Failure during `Checkout code` with rulesync/node errors**: ensure checkout runs with `SKIP_SIMPLE_GIT_HOOKS=1` so repository git hooks do not execute inside `actions/checkout`.
- **Failure in `Verify pre-baked runner image`**: the runner is not using a fresh `copilot-devenv` image. Re-run `Devenv Image`, then update/recreate `copilot-devenv-runner` to use the latest image.
- **Failure in `Verify pre-baked artifacts`**: generated files were not baked into the image. Confirm image workflow completed `npm install` successfully before snapshot.
- **Cannot find custom-image options in GitHub**: your org/plan may not expose GitHub-managed custom images; use self-hosted setup path.
- **No custom image produced**: verify custom images are enabled on `devenv-image-gen` runner.
- **Slow fallback setup**: verify `/nix/store` cache is restoring and `devenv.lock` is stable.
- **Missing tools in agent shell**: check `Export devenv environment` step output and confirm `PATH` additions were written to `GITHUB_PATH`.

## Change Management

When tooling changes in `devenv.nix`:

1. Commit the `devenv.nix` update.
2. Allow auto-triggered image build or run it manually.
3. Re-run setup workflow to validate environment export.
4. Re-verify startup time and tool availability.
