---
root: false
targets: ["*"]
description: "When you add or change features, must follow these guidelines."
---

# Guidelines for Adding or Modifying Features

## General

- Keep `README.md` synchronized with implemented functionality.

## Supported Tools (MCP)

- Keep the `Supported Tools` section in `README.md` synchronized with `.rulesync/mcp.json`.
- Keep MCP entries as human-friendly links.
- Prefer links in this order: official MCP/product documentation page, then official repository page.
- Avoid raw MCP transport endpoint links (for example, `.../mcp`) unless no public docs/repo page exists.
- Verify links resolve and are useful for setup/usage (installation, configuration, or tool reference), not just homepages.

## Supported Agents

- Keep the `Supported Agents` section in `README.md` as a table with `Name` and `Description` columns.
- Make each agent name a human-friendly link to the most useful setup/usage page.
- Prefer links in this order: official product documentation page, then official repository page.
- Verify links resolve and are useful for setup/usage (installation, configuration, or tool reference), not just homepages.
