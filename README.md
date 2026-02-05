# Agent Playground

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/LN-Zap/agent-playground)

A robust sandbox for experimenting with AI agent workflows and multi-agent environments. This project serves as a reference for building and maintaining consistent, provider-agnostic agent ecosystems.

## Core Philosophy

The agent ecosystem is young and fragmented, with competing standards for how tools store skills and rules. This repo exists as a boilerplate example for dealing with that complexity, keeping flexibility across agent harnesses, avoiding lock-in to any single provider, and resisting proprietary formats for each platform.


- **Define Once, Support Everywhere**: Rules and capabilities are defined in a centralized, provider-agnostic manner.
- **Provider Agnostic**: Skills and instructions are managed independently of any specific AI platform (GitHub Copilot, Claude Code, Gemini, etc.).
- **Automated Synchronization**: Uses [skills cli](https://skills.sh/) and [rulesync cli](https://github.com/dyoshikawa/rulesync) to automatically propagate definitions to all supported agent interfaces.
- **Experimentation First**: A flexible space for prototyping new agent patterns without being tied to a single tool.

## Key Components

- **Skills System**: High-level capabilities managed via the `skills` CLI. These modular units pack logic, constraints, and instructions that any agent can consume, regardless of the provider.
- **Rule Synchronization**: Uses `rulesync` CLI to maintain consistency across the workspace. It ensures that whenever a core rule changes, the corresponding agent-specific configurations are updated automatically.
- **MCP Integration**: Native support for Model Context Protocol (MCP) servers, allowing agents to interact with external tools and data sources in a standardized way.

## Supported Agents

The playground currently synchronizes rules and skills for the following platforms:

- **GitHub Copilot**
- **Claude Code**
- **Gemini CLI**
- **OpenCode**
- **Codex**
- **Antigravity**

## Extending Support

To add support for a new AI agent or platform:

### Agent skills

Agent skills are the portable capability bundles that get installed and synchronized across agents via the skills CLI.

1. **Adding**: Add the new agent to the `agents` list in [devenv.nix](devenv.nix) so skills are targeted to it.
1. **Configuring**: Update the skills tasks in [devenv.nix](devenv.nix).
1. **Synchronizing**: Use `skills:add` to resync all skills, or `skills:add:[skill-group]` to sync a single skill group (for example, `skills:add:figma`).

### Rules

Rules are the provider-agnostic instruction sets that get generated and distributed with rulesync. Agent-specific instruction files and ignore files are generated automatically from [.rulesync](.rulesync) (for example, ignore patterns in [.rulesync/.aiignore](.rulesync/.aiignore)).

1. **Adding**: Add the new provider to the `targets` list in [rulesync.jsonc](rulesync.jsonc).
1. **Configuring**: Update rule definitions in [.rulesync](.rulesync) as needed for the new agent.
1. **Synchronizing**: Re-enter the environment or run `npx rulesync generate` to create the new configuration files.

### MCP servers

MCP servers are external integrations defined in [.rulesync/mcp.json](.rulesync/mcp.json) and synchronized by rulesync.

1. **Adding**: Add the server definition to [.rulesync/mcp.json](.rulesync/mcp.json).
1. **Configuring**: Adjust the server command or URL in [.rulesync/mcp.json](.rulesync/mcp.json).
1. **Synchronizing**: Re-enter the environment or run `npx rulesync generate` to sync MCP settings.

| MCP server | Description |
| --- | --- |
| context7 | Library and documentation context retrieval. |
| figma-desktop | Figma desktop design context and asset access. |
| github | GitHub repository and workflow access. |
| playwright | Browser automation via Playwright MCP. |
| chrome-devtools | Chrome DevTools automation via MCP. |

## Getting Started

### Prerequisites

- [Nix](https://nixos.org/download.html): Declarative package manager for reproducible environments.
- [devenv.sh](https://devenv.sh/): Developer environment manager.
- [direnv](https://direnv.net/): Shell extension to automatically load the environment.

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/LN-Zap/agent-playground.git
   ```

1. Navigate to the project directory:

   ```bash
   cd agent-playground
   ```

1. (Optional but Recommended) Enable automatic environment loading with `direnv`:
   Run this once to allow `direnv` to load in this workspace:

   ```bash
   direnv allow
   ```

   After that, the environment will automatically activate every time you `cd` into the directory.

1. (Alternative) Enter the environment manually:

   ```bash
   devenv shell
   ```

   *Note: Upon entering the environment, `devenv` automatically executes `rulesync` (see [devenv.nix](devenv.nix)) to generate and synchronize agent-specific instructions. No manual synchronization is required for the initial setup. For more information on how this works, refer to the [devenv documentation](https://devenv.sh/tasks/).*


### Dev Containers

This repository supports [Dev Containers](https://containers.dev/) via [.devcontainer.json](.devcontainer.json), which is generated automatically by [devenv](https://devenv.sh/integrations/codespaces-devcontainer/). Dev Containers are an open standard supported by tools like VS Code and GitHub Codespaces, and they provide a reproducible, preconfigured environment with the right tools and extensions, which is useful if you want consistent setup across machines or prefer working in a containerized workspace.

## Contributing

Contributions focusing on new provider-agnostic patterns and cross-agent workflows are welcome!

______________________________________________________________________

Happy experimenting!
