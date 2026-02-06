# Interview Architect Reference

## Refinement Techniques

### Assumption Challenging

Always keep a running list of what you are assuming about the system, the user, or the environment.

- "I'm assuming we don't need to support offline mode. Is that correct?"
- "If we assume the database is the bottleneck, how does that change the caching strategy?"

### Devil's Advocate

Take the opposite position to find flaws.

- "What if this feature is never used? Is the complexity worth it?"
- "If a malicious actor wanted to exploit this flow, where would they start?"

### Perspective Shifting

Explicitly switch "hats" during the interview:

- **Security Hat**: "How are we protecting this PII?"
- **Scalability Hat**: "What happens when we have 100x the current load?"
- **UX Hat**: "Is this flow intuitive for a first-time user?"

## Project Structuring Strategies

Depending on the scope, consider recommending a structured approach.

### Example: Phased Implementation

For multi-faceted projects, you might guide the user to define:

1. **Phase 1 (MVP)**: Core functionality, minimal dependencies.
2. **Phase 2 (Optimization)**: Performance, advanced features.
3. **Phase 3 (Scale)**: High availability, multi-region support.

## Finalization

When saving the plan to a markdown file, tailor the sections to the specific project needs.

### Example: Comprehensive Checklist

- [ ] Clear Objective
- [ ] Technical Architecture
- [ ] Data Models / API Contracts
- [ ] UI/UX Flow (if applicable)
- [ ] Security & Privacy Considerations
- [ ] Proposed Timeline or Phasing (if appropriate)
- [ ] Progress Trackers (using `- [ ]` syntax)
