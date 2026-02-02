---
name: performing-self-reflection
description: Analyzes completed tasks to identify friction, errors, and improvement opportunities. Use after completing complex tasks, correcting architectural violations, encountering recurring issues, or when a task took longer than expected due to missing context.
---

# Performing Self-Reflection Skill

Analyze the development process to identify improvements in automation, documentation, and architectural compliance.

## Mandatory Rules

1. **Honesty**: Acknowledge your own mistakes to improve future performance.
2. **Automation Focus**: Prefer updates that prevent errors automatically over manual checks.
3. **Actionable Outcomes**: Every reflection MUST ideally result in at least one update to the workspace's knowledge base.
4. **Hierarchy Respect**: Follow the project's established patterns for skills and instructions.

## When to Use This Skill

- After completing a multi-step feature or refactoring task.
- Immediately after correcting a significant architectural error or guideline violation.
- When you encounter recurring friction or ambiguity in the project's instructions.
- When a task took significantly longer than expected due to missing context.

## Workflow: The Reflection Process

### 1. Review the Session

Look back at the conversation history and tool outputs. Identify:

- **Successes**: What went well? Which tools/skills were most effective?
- **Friction Points**: Where did you get stuck? Did you have to ask the user for clarification?
- **Errors**: Did you violate any project standards? Why did it happen?

### 2. Identify Root Causes

For every friction point or error, ask:

- Was a specific instruction missing?
- Was an existing instruction ambiguous or outdated?
- Did I duplicate information that is already available globally (e.g., `AGENTS.md`)?
- Did a skill provide incorrect or incomplete guidance?
- Could a new tool or script have automated a manual step?

### 3. Propose Improvements

Categorize your findings into actionable updates:

- **Instructions**: Updates to `.github/copilot-instructions.md` or `*.instructions.md`.
- **Skills**: New skills or updates to existing ones in `.github/skills/`.
- **Prompts**: Improvements to how you (the agent) should approach specific tasks.
- **Tooling**: Suggestions for new scripts in `tools/` or workspace configurations.

### 4. Execute Updates

Don't just reflect—apply the changes. Use the appropriate tools to update the workspace's knowledge base.

## Reflection Template

Use this structure when performing a self-reflection:

- **Task Summary**: Brief overview of what was accomplished.
- **Pitfalls Encountered**: Specific technical or architectural hurdles.
- **Guideline Gaps**: Instructions that failed to prevent errors or provide necessary context.
- **Action Taken**: What was updated (files, skills, instructions) to prevent this in the future.
- **Future Recommendations**: Long-term improvements or new tools needed.

## Core Rules

- **Be Brutally Honest**: Acknowledge your own mistakes to improve future performance.
- **Focus on Automation**: Prefer updates that prevent errors automatically (e.g., better instructions) over manual checks.
- **Keep it Actionable**: Every reflection should ideally result in at least one update to the workspace's knowledge base.
- **Respect the Hierarchy**: Follow the project's established patterns for skills and instructions.

