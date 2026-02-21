# Agent Playground

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/LN-Zap/agent-playground?quickstart=1)

A reference template for **portable, vendor-agnostic agent environments**.

If you’ve ever tried to roll out “AI coding agents” to a team, you’ve probably felt the trap:

- Every vendor wants its *own* config format
- Rules, skills, tools (MCP), and hooks get duplicated across files
- One small change turns into five PRs and a lot of drift

This repo is a pragmatic escape hatch: **a collection of patterns** that lets you define your agent environment once, keep it reproducible, and run it across multiple agent runtimes (Copilot, Claude Code, Gemini CLI, etc.) without betting the farm on any single provider.

**Jump to:** [Quick Start](#quick-start-time-to-first-hello-agent) · [5 Patterns](#the-portable-agent-playbook-5-patterns) · [Tools](#supported-tools) · [Agents](#supported-agents) · [Skills](#supported-skills) · [Docs](#operations-docs)

## What You Get

- **Portability (no lock-in)**: Define skills, rules, MCP configs, commands, subagents, and hooks once, then run them anywhere.
- **Instant cloud agents**: Fast startup via dynamic prebuilds (Copilot runner images / Codespaces).
- **Fast onboarding**: A bootstrapped dev environment that “just shows up” for new contributors.
- **Incremental adoption**: Adopt one pattern at a time. Keep what helps; delete what doesn’t.

## The Portable-Agent Playbook (5 Patterns)

These patterns are the heart of the template. Everything else is implementation detail.

### 1) Centralized config (with rulesync)

Instead of maintaining a pile of `CLAUDE.md` / `GEMINI.md` / tool-specific config files, keep a single source of truth and generate outputs.

- Source of truth: [.rulesync](.rulesync) and [rulesync.jsonc](rulesync.jsonc)
- Generator: [rulesync](https://github.com/dyoshikawa/rulesync)
- Result: tool-specific outputs (for example `.claude/`, `.gemini/`, `.opencode/`) are generated and gitignored

This makes the project advocate for open, vendor-agnostic standards (for example `AGENTS.md`) rather than a growing pile of proprietary equivalents.

### 2) Pinned skills via lockfiles (security + reproducibility)

Skills are powerful, but “pull from `main`” is a supply-chain footgun.

- Skill sources are declared in [rulesync.jsonc](rulesync.jsonc)
- Resolved versions are pinned via `rulesync.lock`
- Default behavior is deterministic (`--frozen`) so local dev and CI match

### 3) Unified MCP (tool access defined once)

Tool access is part of the environment, not an afterthought.

- MCP servers are defined once in [.rulesync/mcp.json](.rulesync/mcp.json)
- rulesync distributes them to each supported agent format

### 4) Reproducibility (devenv + direnv)

Onboarding succeeds when “works on my machine” stops being a thing.

- Toolchain is defined in `devenv.nix`
- `direnv` can auto-load the environment on `cd`

### 5) Prebuilt cloud agents (devenv-actions)

Waiting for environment bootstrapping on every run is the quiet productivity killer.

- GitHub Actions can prebuild runner snapshots for faster Copilot setup
- There’s also a dynamic fallback path if the snapshot isn’t present

See [Copilot fast path](docs/copilot-fast-path.md).

## Quick Start (Time To First “Hello, Agent”)

### Fastest path: Codespaces

Click the badge at the top of this README. It opens a fully bootstrapped environment.

### Local path

Prereqs:

- [Nix](https://nixos.org/download.html)
- [devenv.sh](https://devenv.sh/)
- [direnv](https://direnv.net/)

Then:

```bash
git clone https://github.com/LN-Zap/agent-playground.git
cd agent-playground
npm install
```

Optional (recommended):

```bash
direnv allow
```

## Where To Change Things

The goal is to make changes *once*, then let automation do the boring part.

- **Rules, MCP, subagents metadata**: [.rulesync/](.rulesync)
- **Targets, features, skill sources**: [rulesync.jsonc](rulesync.jsonc)
- **Environment / toolchain**: `devenv.nix` + `devenv.yaml`

For the detailed mechanics, see [Synchronization model](docs/synchronization-model.md).

## Common Commands

- Regenerate all agent outputs (deterministic): `npx rulesync generate --delete`
- Intentionally refresh pinned sources (updates `rulesync.lock`): `npm run rulesync:update`

## Supported Tools

These MCP tools are **example defaults enabled in this template**. You can update, replace, or extend them with any other MCP servers that fit your workflow.

| Name | Description |
| --- | --- |
| [context7](https://context7.com/docs/resources/all-clients) | Documentation and reference retrieval via Context7 MCP. |
| [github](https://github.com/github/github-mcp-server) | GitHub MCP integration for repository, issue, and PR operations. |
| [playwright](https://github.com/microsoft/playwright-mcp) | Browser automation and testing through Playwright MCP. |
| [chrome-devtools](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Chrome DevTools MCP for browser inspection and debugging. |
| [deepwiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp) | DeepWiki MCP for AI-powered repository documentation queries. |

To add support for additional MCP tools, update the `mcpServers` object in [.rulesync/mcp.json](.rulesync/mcp.json).

## Supported Agents

These agent targets are **example defaults enabled in this template**. You can add, remove, or swap targets based on your preferred tools and delivery model.

| Name | Description |
| --- | --- |
| [Copilot](https://docs.github.com/en/copilot) | AI coding assistant integrated across GitHub and major IDEs. |
| [Claude](https://docs.anthropic.com/en/docs/claude-code/overview) | Anthropic's CLI-first coding agent for local development workflows. |
| [Codex](https://github.com/openai/codex) | AI model and ecosystem support for code generation and reasoning. |
| [Gemini](https://github.com/google-gemini/gemini-cli) | Google's open-source command-line AI agent for coding and automation. |
| [OpenCode](https://opencode.ai/docs) | Open-source AI coding agent with support for flexible model providers. |
| [Generic](https://github.com/dyoshikawa/rulesync) | Broad compatibility with agents supporting open instruction standards. |

To add support for additional agents, configure the `targets` array in [rulesync.jsonc](rulesync.jsonc).

## Supported Skills

These skills are **example defaults bundled in this template**. You can replace these with any public or private skill sources that better match your domain.

| Name | Description |
| --- | --- |
| [skill-creator](https://github.com/anthropics/skills) | Guidance for creating and refining reusable skills. |
| [rulesync](https://github.com/dyoshikawa/rulesync) | Unified cross-agent rules and skills synchronization tooling. |

Skill bundles are configured in the `sources` section of [rulesync.jsonc](rulesync.jsonc).

## Operations Docs

- [Synchronization model](docs/synchronization-model.md)
- [Copilot fast path](docs/copilot-fast-path.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Formatting and hooks](docs/formatting-and-hooks.md)

## Environment Variables

Some setups may need GitHub auth for fetching skills.

- `GITHUB_TOKEN`: recommended for local development when using GitHub-hosted sources (see [.env.example](.env.example))

## Contributing

Contributions focusing on new provider-agnostic patterns and cross-agent workflows are welcome!

- [Contributing guide](CONTRIBUTING.md)
- [Maintenance guide](MAINTENANCE.md)
- [Security policy](SECURITY.md)
