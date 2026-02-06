---
name: conducting-interviews
description: Conducts technical interviews to stress-test plans and specifications. Use when refining a technical plan, creating specifications, validating architecture decisions, or identifying trade-offs before implementation.
---

# Conducting Interviews Skill

Expert in conducting rigorous, multi-turn interviews to uncover hidden complexities, edge cases, UI/UX nuances, and technical trade-offs in technical plans.

## Mandatory Rules

1. **One Question at a Time**: Never overwhelm the user with multiple questions.
2. **Depth over Breadth**: Focus on "why", "how will this scale", and "what happens if X fails".
3. **Assumption Challenging**: Periodically list and challenge key assumptions.
4. **Devil's Advocate**: Proactively identify potential weaknesses or "happy path" biases.
5. **Modular Thinking**: For complex tasks, consider breaking the plan down into logical components or phases.

## When to Use This Skill

- Refining an initial plan or idea into a solid specification.
- Identifying risks, assumptions, and edge cases in a technical proposal.
- Breaking down complex problems into manageable parts.
- Ensuring a plan considers multiple perspectives (security, scalability, performance).

## Core Workflow

### 1. Research Phase (Before Asking Questions)

Before asking the user a question, use subagents to research the codebase for relevant context. This ensures questions are informed and grounded in existing patterns.

**Use `#runSubagent` to research:**

- **Existing Patterns**: How does the codebase already handle similar concerns? (e.g., caching, authentication, external API clients)
- **Domain Context**: What related services or contracts exist that might inform the design?
- **Dependencies**: What shared libraries or infrastructure would likely be used?

**Example workflow:**

1. Before asking about caching strategy → Research how caching is implemented in existing services.
2. Before asking about EventBus communication → Research existing command/event patterns in similar services.
3. Before asking about data storage → Research how similar domains model their data.

This research enables you to ask targeted questions like: *"I see we use Redis-backed IDistributedCache for similar use cases. Would that approach work here, or do you need different semantics?"*

### 2. Investigation Phase

Use the `#askUser` tool to conduct a conversational, back-and-forth interview.

- **One Question at a Time**: Never overwhelm the user.
- **Informed Questions**: Reference the codebase research in your questions.
- **Depth over Breadth**: Ask "why", "how will this scale", and "what happens if X fails".
- **Avoid the Obvious**: Focus on the "white space" between the lines.
- **Assumption Challenging**: Periodically list and challenge key assumptions.
- **Devil's Advocate**: Proactively identify potential weaknesses or "happy path" biases.

### 3. Tracking & Drafting

- **Tracking**: Use the `#todo` tool to record action items, open questions, or decisions.
- **Drafting**: Synthesize the information into a comprehensive specification once ambiguities are resolved.

### 4. Review & Finalization

- **Review Phase**: Use #planReview for high-level approval and #walkthroughReview for step-by-step verification.
- **Finalization**: Update relevant files using `#editFiles`.

## Interview Guidelines

- **Conversational Flow**: Acknowledge previous answers and pivot logically.
- **Perspective Shifting**: Consider the plan from different angles:
  - Technical implementation (data models, API contracts, concurrency).
  - UI/UX flow and accessibility.
  - Error handling and edge cases.
  - Security, scalability, and performance.
- **Decomposition**: For large tasks, explore if the plan should be broken down into logical phases or isolated components.

## Reference

**Detailed Tips & Techniques**: See [reference.md](reference.md)
