# Agent Playground

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/LN-Zap/agent-playground?quickstart=1)
[![Copilot Setup Steps](https://github.com/LN-Zap/agent-playground/actions/workflows/copilot-setup-steps.yml/badge.svg)](https://github.com/LN-Zap/agent-playground/actions/workflows/copilot-setup-steps.yml)

A sandbox for experimenting with AI agent workflows and multi-agent environments. This project serves as a reference implementation for building maintainable, provider-agnostic agent ecosystems with fully reproducible development environments.

**Key objectives:**

- **Provider-agnostic agent management**: Centrally define skills, rules, and configurations once, then distribute them across multiple AI coding assistants
- **Reproducible environments**: Ensure consistent development environments across all platforms and contributors
- **Automated workflows**: Leverage git hooks and package scripts for seamless synchronization without manual intervention
- **Real-world patterns**: Demonstrate practical approaches to managing complexity in modern AI-assisted development

## Table of Contents

- [Core Philosophy](#core-philosophy)
- [Key Components](#key-components)
- [Supported Tools](#supported-tools)
- [Supported Agents](#supported-agents)
- [Supported Skills](#supported-skills)
- [Configuration](#configuration)
- [Operations Docs](#operations-docs)
- [Getting Started](#getting-started)
  - [Environment Variables](#environment-variables)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Quick validation (recommended)](#quick-validation-recommended)
  - [Dev Containers](#dev-containers)
  - [Copilot Coding Agent Environment](#copilot-coding-agent-environment)
- [Contributing](#contributing)

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

These MCP tools are **example defaults enabled in this template**. You can update, replace, or extend them with any other MCP servers that fit your workflow.

| Name | Description |
| --- | --- |
| [context7](https://context7.com/docs/resources/all-clients) | Documentation and reference retrieval via Context7 MCP. |
| [github](https://github.com/github/github-mcp-server) | GitHub MCP integration for repository, issue, and PR operations. |
| [playwright](https://github.com/microsoft/playwright-mcp) | Browser automation and testing through Playwright MCP. |
| [chrome-devtools](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Chrome DevTools MCP for browser inspection and debugging. |
| [deepwiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp) | DeepWiki MCP for AI-powered repository documentation queries. |

To add support for additional MCP tools, update the `mcpServers` object in [.rulesync/mcp.json](.rulesync/mcp.json). See the [rulesync documentation](https://github.com/dyoshikawa/rulesync) for synchronization behavior and target support.

## Supported Agents

These agent targets are **example defaults enabled in this template**. You can add, remove, or swap targets based on your preferred tools and delivery model.

| Name | Description |
| --- | --- |
| [GitHub Copilot](https://docs.github.com/en/copilot) | AI coding assistant integrated across GitHub and major IDEs. |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) | Anthropic's CLI-first coding agent for local development workflows. |
| [OpenAI Codex](https://github.com/openai/codex) | Codex support in this template is configured through the Codex CLI target; adapt this to other Codex surfaces as needed. |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | Google's open-source command-line AI agent for coding and automation. |
| [OpenCode](https://opencode.ai/docs) | Open-source AI coding agent with MCP support and provider flexibility. |

To add support for additional agents, configure the `targets` array in [rulesync.jsonc](rulesync.jsonc). See the [rulesync documentation](https://github.com/dyoshikawa/rulesync) for available agent targets and configuration options.

## Supported Skills

These skills are **example defaults bundled in this template**. You can replace these with any public or private skill sources that better match your domain.

| Name | Description |
| --- | --- |
| [frontend-design](https://github.com/anthropics/skills) | General frontend design and UX implementation guidance. |
| [skill-creator](https://github.com/anthropics/skills) | Guidance for creating and refining reusable skills. |
| [crafting-effective-readmes](https://github.com/softaworks/agent-toolkit/tree/main/skills/crafting-effective-readmes) | Workflow and checklists for writing clearer, audience-focused READMEs. |

Skill bundles are configured in the `sources` section of [rulesync.jsonc](rulesync.jsonc).

## Configuration

All configuration lives in [rulesync.jsonc](rulesync.jsonc). Edit this file to control which agent formats to generate, which features to enable, and which remote skill repositories to fetch.

For detailed configuration options and syntax, see the [rulesync documentation](https://github.com/dyoshikawa/rulesync).

## Operations Docs

- [Synchronization model](docs/synchronization-model.md)
- [Copilot fast path](docs/copilot-fast-path.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Formatting and hooks](docs/formatting-and-hooks.md)

### Synchronizing

All generated output files are gitignored and created automatically during setup.

- Automatic (frozen lock): `npm install`, `post-merge`, and `post-checkout`
- Manual deterministic regen: `npx rulesync generate --delete`
- Manual source refresh (updates `rulesync.lock`): `npm run rulesync:update`

> **Authentication**: Fetching skills from GitHub-hosted sources may require a `GITHUB_TOKEN` depending on environment and API limits. In Codespaces this is usually provided automatically. For local development, add it to `.env` (loaded by devenv via `dotenv.enable`).
>
> **Recommended scopes**:
>
> - **Fine-grained PAT (recommended)**: Grant access to required source repositories and set **Contents: Read-only** and **Metadata: Read-only**.
> - **Classic PAT**: Use the minimal read scope needed for your configured sources.

## Getting Started

### Environment Variables

Add the following variables to your `.env` file:

| Variable | Description | Documentation |
|----------------------------|---------------------------------------------|---------------|
| `GITHUB_TOKEN` | GitHub token for GitHub-hosted source access (recommended) | [Create token](https://github.com/settings/tokens) |

See [.env.example](.env.example) for a documented template.

If you only need core rulesync setup, start with `GITHUB_TOKEN` and add other variables only when using those integrations.

______________________________________________________________________

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

1. Install dependencies:

   ```bash
   npm install
   ```

   This installs dependencies, generates all agent configuration files via `rulesync generate`, and installs git hooks for ongoing synchronization.

1. *(Optional)* Enable automatic environment loading with `direnv`:

   ```bash
   direnv allow
   ```

   devenv provides additional auto-regeneration when source files change. See [devenv.nix](devenv.nix).
   Formatting/linting is available via `treefmt` (including `actionlint` and `mdformat`).

### Dev Containers

This repository supports [Dev Containers](https://containers.dev/) via [.devcontainer.json](.devcontainer.json), generated by [devenv](https://devenv.sh/integrations/codespaces-devcontainer/). Use with VS Code or GitHub Codespaces for a preconfigured environment.

### Copilot Coding Agent Environment

Copilot setup supports a prebuilt fast path and a dynamic fallback path.

- Fast path overview: [Copilot fast path](docs/copilot-fast-path.md)
- Common failures and recovery: [Troubleshooting](docs/troubleshooting.md)

## Contributing

Contributions focusing on new provider-agnostic patterns and cross-agent workflows are welcome!

- [Contributing guide](CONTRIBUTING.md)
- [Maintenance guide](MAINTENANCE.md)
- [Security policy](SECURITY.md)
