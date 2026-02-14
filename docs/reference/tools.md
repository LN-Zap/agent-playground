# Supported Tools

This page lists all the MCP (Model Context Protocol) tools supported in the Agent Playground.

## Available Tools

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

## Adding New Tools

To add support for additional MCP tools, update the `mcpServers` object in `.rulesync/mcp.json`. See the [rulesync documentation](https://github.com/dyoshikawa/rulesync) for synchronization behavior and target support.

!!! tip "Configuration"
    All MCP tool configurations are defined in `.rulesync/mcp.json` and synchronized across all supported agents automatically.
