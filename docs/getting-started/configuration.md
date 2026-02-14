# Configuration

All configuration lives in `rulesync.jsonc`. Edit this file to control which agent formats to generate, which features to enable, and which remote skill repositories to fetch.

For detailed configuration options and syntax, see the [rulesync documentation](https://github.com/dyoshikawa/rulesync).

## Synchronizing

All generated output files are **gitignored** and created automatically during setup. The source of truth lives in `.rulesync/` and `rulesync.jsonc`.

Generated files are created and updated automatically. You should rarely need to run anything manually:

| Trigger | Mechanism | Who benefits |
| --- | --- | --- |
| `npm install` | `postinstall` script runs `rulesync generate` | Everyone |
| `git pull` | `post-merge` git hook runs `rulesync generate` | Everyone |
| Branch switch | `post-checkout` git hook runs `rulesync generate` | Everyone |
| Source file change | devenv task with `execIfModified` | devenv/direnv users |
| Codespaces start | `updateContentCommand` triggers devenv | Codespaces users |

To regenerate manually: 

```bash
npx rulesync generate
```

## Configuration Files

### rulesync.jsonc

The main configuration file that declares:

- Remote skill repositories to fetch
- Agent targets to generate configurations for
- MCP server configurations to synchronize

### .rulesync/mcp.json

External tool integrations (MCP servers) that are synchronized across all agents. See [Supported Tools](../reference/tools.md) for the full list.

### .rulesync/rules/

Provider-agnostic instructions that are generated into each agent's native format. These rules apply to all agents and define common workflows and guidelines.

### .rulesync/subagents/

Specific agent configurations for specialized tasks like code review, security review, etc. See [Agents](../agents/code-reviewer.md) for details.
