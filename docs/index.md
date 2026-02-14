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

- **Define Once, Support Everywhere**: Rules and capabilities are defined centrally in `.rulesync` and distributed to all supported agents.
- **Provider Agnostic**: Skills and instructions are managed independently of any specific AI platform.
- **Automated Synchronization**: rulesync propagates rules, skills, and configurations to all agent interfaces. Generated files are gitignored and created automatically. Nothing to commit.
- **Declarative Sources**: Remote skill repositories are declared in `rulesync.jsonc` and fetched automatically with lockfile-based determinism.

## Key Components

- **Skills**: A curated collection of reusable capability modules useful across the Zap ecosystem. Skills are declared in `rulesync.jsonc`, fetched from remote GitHub repositories, and distributed to all agents.
- **Rules**: Provider-agnostic instructions defined in `.rulesync/rules` and generated into each agent's native format.
- **MCP Servers**: External tool integrations defined in `.rulesync/mcp.json` and synchronized across agents.

## Next Steps

- [Get started with setup](getting-started/setup.md)
- [Learn about configuration](getting-started/configuration.md)
- [Explore supported tools](reference/tools.md)
- [Explore supported agents](reference/agents.md)
