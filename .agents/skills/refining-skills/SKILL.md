---
name: refining-skills
description: Stress-tests and optimizes agent skills through autonomous sub-agent delegation. Use when evaluating reliability of an existing skill, identifying friction points and missing context, performing quality assurance on new or updated skills, or systematically grading skill effectiveness before release. Domain-agnostic protocol applicable to any skill type.
---

# Iterative Skill Evaluation & Refinement

Stress-tests and optimizes agent skills through autonomous sub-agent delegation.

## Protocol: Three Phases

### Phase 1: Test Vector Architecture

1. **Capability Mapping**: Read target skill, extract every discrete action it claims to enable
2. **Scenario Generation**: For each capability, define Happy Path, Edge Case, and Stress Test missions

### Phase 2: Agentic Execution Loop

For EVERY sub-agent mission:

1. **State Hygiene**: Document current state OR reset to clean slate before dispatching

   | Skill Domain       | State to Check                             |
   | ------------------ | ------------------------------------------ |
   | File operations    | Relevant files exist/don't exist           |
   | Service management | Running processes, ports, containers       |
   | Database           | Schema state, test data presence           |
   | API integration    | Endpoint availability, auth state          |
   | Documentation      | File structure, format validity            |
   | Code generation    | Target directory structure, existing files |

2. **Sub-Agent Dispatch** using this prompt template:

```
## MISSION [N]: [Name] ([Type])

**Your Role**: [Persona from skill's target audience]
**Your Equipment**: ONLY the following skill documentation.

---
[Paste relevant sections of target skill]
---

**Environment State**: [State from hygiene check]
**Objective**: [Clear objective]
**Definition of Done**: [Measurable criteria]

**CRITICAL EVALUATION**:
- Does the skill tell you how to accomplish this?
- What information is missing?

Execute and report results + friction points.
```

3. **Observe**: Log friction points, missing context, tool gaps, ambiguities, success/failure
4. **RCA**: Categorize failures (Ambiguity, Missing Context, Tool Gap, Outdated Info, Incomplete Flow)

### Phase 3: Synthesis & Refinement

1. **Grade**: `Score = (Successful Missions / Total) × 100` (A: 90+, B: 75-89, C: 50-74, F: <50)
2. **Prioritize**: Consolidate friction points into P0 (blocker), P1 (significant), P2 (polish)
3. **Rewrite**: Apply fixes following skill best practices

## Mandatory Rules

1. **State Integrity**: Document state OR reset before EVERY mission
2. **Sub-Agent Blindness**: Sub-agent relies ONLY on provided skill documentation
3. **Radical Candor**: Document all failures honestly
4. **Evaluation First**: Create evaluations before extensive documentation

## Reference

- **RCA methodology**: [reference.md](reference.md)
- **Example evaluation**: [examples.md](examples.md)
