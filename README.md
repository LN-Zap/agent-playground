# Agent Playground

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/LN-Zap/agent-playground?quickstart=1)

A sandbox for experimenting with AI agent workflows and multi-agent environments. This project serves as a reference implementation for building maintainable, provider-agnostic agent ecosystems with fully reproducible development environments.

**Key objectives:**

- **Provider-agnostic agent management**: Centrally define skills, rules, and configurations once, then distribute them across multiple AI coding assistants
- **Reproducible environments**: Ensure consistent development environments across all platforms and contributors
- **Automated workflows**: Leverage git hooks and package scripts for seamless synchronization without manual intervention
- **Real-world patterns**: Demonstrate practical approaches to managing complexity in modern AI-assisted development

## Core Philosophy

The agent ecosystem is young and fragmented, with competing standards for how tools store skills, rules, MCP configurations, hooks, commands, and ignore lists. This repo exists as a boilerplate for dealing with that complexity: keeping flexibility across agent harnesses, avoiding lock-in, and resisting proprietary formats.

**[rulesync](https://github.com/dyoshikawa/rulesync)** is the engine that makes this possible. It provides a provider-agnostic framework for managing agent configurations centrally and distributing them to multiple agent platforms. This project demonstrates how rulesync can be applied in a real-world development environment to maintain consistency across diverse AI coding assistants.

- **Define Once, Support Everywhere**: Rules and capabilities are defined centrally in [.rulesync](.rulesync) and distributed to all supported agents.
- **Provider Agnostic**: Skills and instructions are managed independently of any specific AI platform.
- **Automated Synchronization**: rulesync propagates rules, skills, and configurations to all agent interfaces. Generated files are gitignored and created automatically. Nothing to commit.
- **Declarative Sources**: Remote skill repositories are declared in [rulesync.jsonc](rulesync.jsonc) and fetched automatically with lockfile-based determinism.

## Key Components

- **Skills**: A curated collection of reusable capability modules. Skills are declared in [rulesync.jsonc](rulesync.jsonc), fetched from remote GitHub repositories, and distributed to all agents.
- **Rules**: Provider-agnostic instructions defined in [.rulesync/rules](.rulesync/rules) and generated into each agent's native format.
- **MCP Servers**: External tool integrations defined in [.rulesync/mcp.json](.rulesync/mcp.json) and synchronized across agents.

## Supported Tools

| Name | Description |
| --- | --- |
| [context7](https://context7.com/docs/resources/all-clients) | Documentation and reference retrieval via Context7 MCP. |
| [figma](https://developers.figma.com/docs/figma-mcp-server/) | Local Figma MCP bridge for design and file interactions. |
| [github](https://github.com/github/github-mcp-server) | GitHub MCP integration for repository, issue, and PR operations. |
| [playwright](https://github.com/microsoft/playwright-mcp) | Browser automation and testing through Playwright MCP. |
| [chrome-devtools](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Chrome DevTools MCP for browser inspection and debugging. |
| [pagerduty](https://github.com/PagerDuty/pagerduty-mcp-server) | PagerDuty incident and operations integrations via MCP. |
| [deepwiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp) | DeepWiki MCP for AI-powered repository documentation queries. |
| [notion](https://developers.notion.com/guides/mcp/get-started-with-mcp) | Notion MCP for searching and managing pages and databases. |

To add support for additional MCP tools, update the `mcpServers` object in [.rulesync/mcp.json](.rulesync/mcp.json). See the [rulesync documentation](https://github.com/dyoshikawa/rulesync) for synchronization behavior and target support.

## Supported Agents

| Name | Description |
| --- | --- |
| [GitHub Copilot](https://docs.github.com/en/copilot) | AI coding assistant integrated across GitHub and major IDEs. |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) | Anthropic's CLI-first coding agent for local development workflows. |
| [Codex CLI](https://github.com/openai/codex) | OpenAI's terminal coding agent for repository-aware development tasks. |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | Google's open-source command-line AI agent for coding and automation. |
| [OpenCode](https://opencode.ai/docs) | Open-source AI coding agent with MCP support and provider flexibility. |

To add support for additional agents, configure the `targets` array in [rulesync.jsonc](rulesync.jsonc). See the [rulesync documentation](https://github.com/dyoshikawa/rulesync) for available agent targets and configuration options.

## Configuration

All configuration lives in [rulesync.jsonc](rulesync.jsonc). Edit this file to control which agent formats to generate, which features to enable, and which remote skill repositories to fetch.

For detailed configuration options and syntax, see the [rulesync documentation](https://github.com/dyoshikawa/rulesync).

### Synchronizing

All generated output files are **gitignored** and created automatically during setup. The source of truth lives in [.rulesync/](.rulesync) and [rulesync.jsonc](rulesync.jsonc).

Generated files are created and updated automatically. You should rarely need to run anything manually:

| Trigger | Mechanism | Who benefits |
| --- | --- | --- |
| `npm install` | `postinstall` script runs `rulesync generate` | Everyone |
| `git pull` | `post-merge` git hook runs `rulesync generate` | Everyone |
| Branch switch | `post-checkout` git hook runs `rulesync generate` | Everyone |
| Source file change | devenv task with `execIfModified` | devenv/direnv users |
| Codespaces start | `updateContentCommand` triggers devenv | Codespaces users |

To regenerate manually: `npx rulesync generate`

> **Authentication**: Fetching skills from GitHub-hosted sources may require a `GITHUB_TOKEN` depending on environment and API limits. In Codespaces this is usually provided automatically. For local development, add it to `.env` (loaded by devenv via `dotenv.enable`).
>
> **Recommended scopes**:
> - **Fine-grained PAT (recommended)**: Grant access to required source repositories and set **Contents: Read-only** and **Metadata: Read-only**.
> - **Classic PAT**: Use the minimal read scope needed for your configured sources.

## Getting Started


### Environment Variables

Add the following variables to your `.env` file:

| Variable                   | Description                                 | Documentation |
|----------------------------|---------------------------------------------|---------------|
| `GEMINI_API_KEY`           | API key for Gemini access                   | [Get key](https://aistudio.google.com/api-keys) |
| `GITHUB_TOKEN`             | GitHub token for GitHub-hosted source access (recommended) | [Create token](https://github.com/settings/tokens) |
| `CLOUDFLARE_API_TOKEN`     | Cloudflare API token for Workers/Observability | [API Tokens](https://dash.cloudflare.com/profile/api-tokens) |
| `CLOUDFLARE_ACCOUNT_ID`    | Cloudflare Account ID                       | [Find Account ID](https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/) |
| `PAGERDUTY_USER_API_KEY`   | PagerDuty User API key                      | [Create API Key](https://support.pagerduty.com/docs/generating-api-keys) |

See [.env.example](.env.example) for a documented template.

If you only need core rulesync setup, start with `GITHUB_TOKEN` and add other variables only when using those integrations.

---

### Prerequisites

- [Nix](https://nixos.org/download.html): Declarative package manager for reproducible environments.
- [devenv.sh](https://devenv.sh/): Developer environment manager.
- [direnv](https://direnv.net/): Shell extension to automatically load the environment.

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/LN-Zap/agent-playground.git
   cd agent-playground
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

   This installs dependencies, generates all agent configuration files via `rulesync generate`, and installs git hooks for ongoing synchronization.

3. *(Optional)* Enable automatic environment loading with `direnv`:

   ```bash
   direnv allow
   ```

   devenv provides additional auto-regeneration when source files change. See [devenv.nix](devenv.nix).
   Workflow linting is available via `actionlint` (enabled in `treefmt`).

### Quick validation (recommended)

After setup, run:

```bash
npx rulesync generate
devenv shell -- actionlint .github/workflows/*.yml
```

This confirms rulesync generation and workflow linting on a fresh clone.

### Dev Containers

This repository supports [Dev Containers](https://containers.dev/) via [.devcontainer.json](.devcontainer.json), generated by [devenv](https://devenv.sh/integrations/codespaces-devcontainer/). Use with VS Code or GitHub Codespaces for a preconfigured environment.

### Copilot Coding Agent Environment

GitHub Copilot Coding Agent setup is defined in [.github/workflows/copilot-setup-steps.yml](.github/workflows/copilot-setup-steps.yml) and is aligned with [devenv.nix](devenv.nix):

- **Primary path (fast start)**: use a custom runner image generated by [.github/workflows/devenv-image.yml](.github/workflows/devenv-image.yml) via `snapshot: <repo-name>-devenv`
- **Image-first setup**: copilot setup consumes pre-baked devenv/tooling/artifacts when available and falls back to install-based setup when needed
- **Single source of truth**: environment packages and language tooling remain defined in [devenv.nix](devenv.nix)
- **Simple workflow surface**: public template uses two workflows only: [.github/workflows/devenv-image.yml](.github/workflows/devenv-image.yml) and [.github/workflows/copilot-setup-steps.yml](.github/workflows/copilot-setup-steps.yml)

`devenv` includes Google Cloud tooling by default in all environments (local, container, and image builds).

Recommended for GitHub-hosted source access in CI/Copilot workflows:

- Configure `RULESYNC_GITHUB_TOKEN` with read access to configured source repositories to avoid GitHub API `403`/rate-limit failures during `npm install` (`rulesync install/generate`).

By default, these workflows run on GitHub-hosted runners.

### Copilot workflow operations

Use this sequence when validating or updating the Copilot environment:

1. Run `Devenv Image`.
2. Run `Copilot Setup Steps`.
3. Confirm setup summary reports successful verification.

Recommended secret for stable GitHub API access in CI:

- `RULESYNC_GITHUB_TOKEN` (falls back to `github.token` when absent).

Common issues:

- `rulesync` fetch/rate-limit failures: set `RULESYNC_GITHUB_TOKEN` with read access to configured sources.
- Missing tool verification (`devenv`, `node`, `python3`, `jq`): rerun `Devenv Image`, then rerun `Copilot Setup Steps`.
- Nix/devenv installation failures on hosted runners: rerun once to rule out transient network/cache failures.

## Contributing

Contributions focusing on new provider-agnostic patterns and cross-agent workflows are welcome!
