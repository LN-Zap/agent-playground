# Agent Playground

A robust sandbox for experimenting with AI agent workflows and multi-agent environments. This project serves as a reference for building and maintaining consistent, provider-agnostic agent ecosystems.

## Core Philosophy

- **Define Once, Support Everywhere**: Rules and capabilities are defined in a centralized, provider-agnostic manner.
- **Provider Agnostic**: Skills and instructions are managed independently of any specific AI platform (GitHub Copilot, Claude Code, Gemini, etc.).
- **Automated Synchronization**: Uses [skills cli](https://github.com/LN-Zap/skills) and [rulesync cli](https://github.com/dyoshikawa/rulesync) to automatically propagate definitions to all supported agent interfaces.
- **Experimentation First**: A flexible space for prototyping new agent patterns without being tied to a single tool.

## Key Components

- **Skills System**: High-level capabilities managed via the [skills](https://github.com/LN-Zap/skills) CLI. These modular units pack logic, constraints, and instructions that any agent can consume, regardless of the provider.
- **Rule Synchronization**: Uses [rulesync](https://github.com/dyoshikawa/rulesync) to maintain consistency across the workspace. It ensures that whenever a core rule or skill changes, the corresponding agent-specific configurations are updated automatically.
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

1. **Update Rule targets**: Add the new provider to the `targets` list in [rulesync.jsonc](rulesync.jsonc).
2. **Configure Skills**: If the agent requires specific formatting for skills, update the `agents` list in [devenv.nix](devenv.nix) to ensure they are synchronized correctly during the `skills:sync` task.
3. **Trigger Sync**: Re-enter the environment or run `npx rulesync generate` to create the new configuration files.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (Project dependency and script runner)
- [Nix](https://nixos.org/download.html) (Declarative package manager for reproducible environments)
- [devenv.sh](https://devenv.sh/) (Developer environment manager. See the [documentation](https://devenv.sh/getting-started/) for installation.)
- [direnv](https://direnv.net/) (Shell extension to automatically load the environment)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/LN-Zap/agent-playground.git
   ```

2. Navigate to the project directory:
   ```bash
   cd agent-playground
   ```

3. (Optional but Recommended) Initialize the development environment:
   If you have `direnv` installed, run:
   ```bash
   direnv allow
   ```
   The environment will now automatically activate every time you `cd` into the directory. 

   If you don't use `direnv`, you can enter the environment manually:
   ```bash
   devenv shell
   ```

   *Note: Upon entering the environment, `devenv` automatically executes `rulesync` (see [devenv.nix](devenv.nix)) to generate and synchronize agent-specific instructions. No manual synchronization is required for the initial setup. For more information on how this works, refer to the [devenv documentation](https://devenv.sh/tasks/).*

## Contributing

Contributions focusing on new provider-agnostic patterns and cross-agent workflows are welcome!

---

Happy experimenting!
