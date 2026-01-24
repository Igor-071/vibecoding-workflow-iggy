# Quick Reference

Daily cheat sheet for the Vibecoding Workflow.

---

## Workflow Phases

```
Phase 1: SPEC        → Write Given/When/Then spec → Wait for approval
Phase 2: TEST PLAN   → Plan tests for each AC
Phase 3: IMPLEMENT   → TDD: Red-Green-Blue
Phase 4: REVIEW      → All 10 quality gates must pass
Phase 5: USER TEST   → Present → STOP & WAIT → Generate docs on approval
```

---

## Given/When/Then Format

```gherkin
### AC-001: [Brief description]

GIVEN [precondition]
  AND [additional precondition]
WHEN [action]
  AND [additional action]
THEN [expected result]
  AND [additional result]
```

---

## TDD Cycle

```
RED   → Write failing test (test must fail)
GREEN → Write minimum code to pass
BLUE  → Refactor, keep tests passing
```

---

## Quality Gates Checklist

| Gate | Check |
|------|-------|
| Code Quality | Lint passes, no warnings |
| Functionality | All AC met |
| Mobile | 320px, 375px, 768px, 1024px, 1440px |
| Performance | Lighthouse > 90 |
| Accessibility | WCAG 2.1 AA |
| Browser | Chrome, Safari, Firefox |
| Integration | APIs work, errors handled |
| Security | No XSS, no injection |
| UX | Matches design system |
| Documentation | Code commented |

---

## Traceability Matrix

```markdown
| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `file.test.ts` | `test name` | ⏳/✅/❌ |
```

---

## Feature Delivery Format

```markdown
## FEATURE COMPLETE: [Name]

### What Was Built
[Description]

### Acceptance Criteria Status
| Criterion | Status |
|-----------|--------|
| AC-001 | PASSED |

### Quality Gates
All PASSED

### How to Test
1. [Steps]

**AWAITING YOUR APPROVAL**
```

---

## Bug Handling

```
1. STOP     → Don't fix immediately
2. ANALYZE  → 5 Whys
3. DOCUMENT → Post-mortem
4. TEST     → Failing test first
5. FIX      → Minimal fix
6. VERIFY   → Run tests
7. REVIEW   → Quality check
8. CLOSE    → Update post-mortem
```

---

## Commit Format

```
<type>(<scope>): <description>
```

| Type | Use |
|------|-----|
| feat | New feature |
| fix | Bug fix |
| spec | Specification |
| test | Tests |
| docs | Documentation |
| refactor | Refactoring |
| chore | Maintenance |

---

## Approval Triggers

When user says any of these, generate docs and mark complete:
- "Approved"
- "Green light"
- "Looks good"
- "Ship it"

---

## File Locations

| Type | Location |
|------|----------|
| Specs | `docs/specs/[feature].md` |
| Reviews | `docs/reviews/[feature].md` |
| Feature Docs | `docs/features/[feature].md` |
| Bug Post-mortems | `docs/bugs/[bug-id].md` |

---

## Critical Rules

**NEVER:**
- Code without approved spec
- Skip Given/When/Then
- Proceed without approval
- Auto-commit or auto-push
- Skip quality gates

**ALWAYS:**
- Tests before code
- Update traceability
- Stop & Wait for approval
- Generate docs on approval
- Post-mortem for bugs
