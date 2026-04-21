# Skill: Specification Writing

Activate when: User asks to build a feature, add functionality, or create something new.

## Process

1. Create `docs/specs/[feature-name].md` using the format below
2. Present the spec to the user
3. **STOP. Wait for explicit approval before writing any code.**

## Spec Format

```markdown
# [Feature Name]

## Goal
One sentence. What does this feature do and why.

## Non-Goals
What this feature explicitly does NOT do.

## Acceptance Criteria

### AC-001: [Short description]
GIVEN [precondition]
WHEN [user action]
THEN [expected outcome]

### AC-002: [Short description]
GIVEN [precondition]
WHEN [user action]
THEN [expected outcome]

(continue for each criterion)

## Edge Cases
- [What happens when X]
- [What happens when Y]

## Error Scenarios
- [Invalid input] → [Expected behavior]
- [Network failure] → [Expected behavior]

## Traceability Matrix

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001    |           |           |        |
| AC-002    |           |           |        |

## Technical Notes
Architecture decisions, component structure, data flow — only if non-obvious.
```

## Rules
- Every criterion MUST use Given/When/Then. No exceptions.
- Keep specs short. If a spec exceeds 100 lines, the feature is too big — split it.
- Non-goals are mandatory. They prevent scope creep.
- The traceability matrix starts empty. It gets filled during implementation.
