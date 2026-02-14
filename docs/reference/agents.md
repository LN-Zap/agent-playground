# Supported Agents

This page lists all the AI coding agents supported in the Agent Playground.

## Available Agents

| Name | Description |
| --- | --- |
| [GitHub Copilot](https://docs.github.com/en/copilot) | AI coding assistant integrated across GitHub and major IDEs. |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) | Anthropic's CLI-first coding agent for local development workflows. |
| [Codex CLI](https://github.com/openai/codex) | OpenAI's terminal coding agent for repository-aware development tasks. |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | Google's open-source command-line AI agent for coding and automation. |
| [OpenCode](https://opencode.ai/docs) | Open-source AI coding agent with MCP support and provider flexibility. |

## Adding New Agents

To add support for additional agents, configure the `targets` array in `rulesync.jsonc`. See the [rulesync documentation](https://github.com/dyoshikawa/rulesync) for available agent targets and configuration options.

!!! tip "Provider-Agnostic Configuration"
    All agent configurations are managed centrally in `.rulesync/` and distributed automatically. This ensures consistency across all supported agents without vendor lock-in.
