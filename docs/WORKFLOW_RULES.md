# Vibecoding Workflow Rules

Complete reference for the development workflow. For philosophy and principles, see [METHODOLOGY.md](./METHODOLOGY.md).

---

## Table of Contents

1. [Development Phases](#development-phases)
2. [Acceptance Criteria Format](#acceptance-criteria-format)
3. [Traceability Matrix](#traceability-matrix)
4. [Quality Gates](#quality-gates)
5. [Feature Delivery Format](#feature-delivery-format)
6. [Bug Handling Workflow](#bug-handling-workflow)
7. [Git Workflow](#git-workflow)
8. [Documentation Workflow](#documentation-workflow)
9. [Team Personas](#team-personas)
10. [Critical Rules](#critical-rules)

---

## Development Phases

### Phase 1: Specification & Design

**Persona:** Tech Lead (Alex Chen)

**Objective:** Create a detailed, unambiguous specification before any code is written.

**Steps:**
1. Understand the user's request fully
2. Ask clarifying questions if needed
3. Create specification file: `docs/specs/[feature-name].md`
4. Use the [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md)
5. Write ALL acceptance criteria in Given/When/Then format
6. Include empty traceability matrix
7. Present spec to user

**Output:** Specification document

**Gate:** User must explicitly approve spec before proceeding

```
User says: "Spec approved" / "Looks good" / "Proceed"
     ↓
Move to Phase 2
```

---

### Phase 2: Test Planning

**Persona:** Quality Lead (Dr. Priya Patel)

**Objective:** Plan test strategy based on approved specification.

**Steps:**
1. Review approved specification
2. Identify test types needed (unit, integration, e2e)
3. Plan tests for each acceptance criterion
4. Identify edge cases and error scenarios
5. Note any test data requirements

**Output:** Test plan (can be part of spec or separate)

---

### Phase 3: Implementation

**Persona:** Tech Lead (Alex Chen)

**Objective:** Implement the feature using TDD (Test-Driven Development).

**TDD Cycle:**
```
For each acceptance criterion:

1. RED   → Write failing test
           - Test must fail (proves test is valid)
           - Test name matches criterion

2. GREEN → Write minimum code to pass
           - No over-engineering
           - Just enough to make test pass

3. BLUE  → Refactor
           - Improve code quality
           - Keep tests passing
           - Update traceability matrix
```

**Steps:**
1. Start with AC-001
2. Write failing test for AC-001
3. Implement to make test pass
4. Refactor if needed
5. Update traceability matrix with test location
6. Repeat for AC-002, AC-003, etc.

**Output:** Working implementation with tests

---

### Phase 4: Team Review

**Persona:** Quality Lead (Dr. Priya Patel)

**Objective:** Verify all quality gates pass before user testing.

**Steps:**
1. Run all quality gate checks
2. Create review document: `docs/reviews/[feature-name].md`
3. Document status of each gate
4. Fix any failing gates
5. All gates must be GREEN

**Output:** Review document with all gates passing

---

### Phase 5: User Testing

**Persona:** Quality Lead (Dr. Priya Patel)

**Objective:** Present completed feature to user for approval.

**Steps:**
1. Present feature using standard delivery format (see below)
2. **STOP and WAIT** for explicit user approval
3. If user requests changes: iterate from relevant phase
4. If user approves: generate documentation

**Approval Triggers:**
- "Approved"
- "Green light"
- "Looks good"
- "Ship it"

**On Approval:**
1. Generate feature documentation in `docs/features/[feature-name].md`
2. Mark feature as COMPLETE
3. Await user instruction for commit

---

## Acceptance Criteria Format

### Required Format: Given/When/Then

Every acceptance criterion MUST use this format:

```gherkin
### AC-[NUMBER]: [Brief Description]

GIVEN [precondition or context]
  AND [additional precondition if needed]
WHEN [action or event occurs]
  AND [additional action if needed]
THEN [expected outcome]
  AND [additional outcome if needed]
```

### Examples

**Good Example:**
```gherkin
### AC-001: Successful login with valid credentials

GIVEN a registered user with email "test@example.com"
  AND the user is on the login page
WHEN they enter email "test@example.com"
  AND they enter the correct password
  AND they click the "Sign In" button
THEN they are redirected to the dashboard
  AND they see a welcome message "Welcome back, [Name]"
  AND their session is created with 24-hour expiry
```

**Bad Example:**
```
User should be able to log in successfully.
```
(Too vague - what does "successfully" mean? What are the exact steps?)

### Edge Cases

Always include acceptance criteria for:
- Error states
- Empty states
- Boundary conditions
- Invalid inputs
- Permission denied scenarios

---

## Traceability Matrix

### Format

Every spec must include a traceability matrix:

```markdown
## Traceability Matrix

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `src/__tests__/login.test.ts` | `should redirect to dashboard on valid login` | ⏳ |
| AC-002 | `src/__tests__/login.test.ts` | `should show error on invalid password` | ⏳ |
| AC-003 | `src/__tests__/login.test.ts` | `should lock account after 3 failed attempts` | ⏳ |
```

### Status Icons

- ⏳ Pending - Test not yet written
- ✅ Passed - Test written and passing
- ❌ Failed - Test written but failing

### Rules

1. Every criterion MUST have a test
2. Every test MUST reference a criterion
3. Feature not complete until all ✅
4. Matrix updated during implementation

---

## Quality Gates

### Gate 1: Code Quality
- [ ] Linting passes with zero warnings
- [ ] TypeScript strict mode (no `any`)
- [ ] No `console.log` in production code
- [ ] Proper error handling throughout
- [ ] No commented-out code

### Gate 2: Functionality
- [ ] All acceptance criteria met
- [ ] Happy path works correctly
- [ ] Edge cases handled
- [ ] Error states display properly

### Gate 3: Mobile Responsive
*(Skip for CLI/backend projects)*
- [ ] Works at 320px (iPhone SE)
- [ ] Works at 375px (iPhone standard)
- [ ] Works at 768px (Tablet)
- [ ] Works at 1024px (Desktop)
- [ ] Works at 1440px (Large desktop)
- [ ] Touch targets minimum 44x44px
- [ ] Text minimum 16px on mobile

### Gate 4: Performance
- [ ] Lighthouse score > 90
- [ ] First Contentful Paint < 1.5s
- [ ] Time to Interactive < 3s
- [ ] No Cumulative Layout Shift
- [ ] Images optimized

### Gate 5: Accessibility
*(Skip for CLI/backend projects)*
- [ ] WCAG 2.1 AA compliant
- [ ] Keyboard navigation works
- [ ] Screen reader compatible
- [ ] Proper contrast ratios
- [ ] Alt text for images
- [ ] Semantic HTML used

### Gate 6: Browser Testing
*(Skip for non-web projects)*
- [ ] Chrome (latest)
- [ ] Safari (latest)
- [ ] Firefox (latest)
- [ ] Chrome Mobile
- [ ] Safari Mobile

### Gate 7: Integration Testing
- [ ] API calls work correctly
- [ ] Error handling for API failures
- [ ] Loading states display
- [ ] Data flows correctly between components

### Gate 8: Security Review
- [ ] No XSS vulnerabilities
- [ ] No SQL injection points
- [ ] Secrets in environment variables
- [ ] Input sanitization in place
- [ ] Auth checks where needed

### Gate 9: UX Consistency
*(Skip for CLI/backend projects)*
- [ ] Matches design system
- [ ] Consistent spacing
- [ ] Proper animations/transitions
- [ ] Clear error messages
- [ ] Logical tab order

### Gate 10: Documentation
- [ ] Complex code has comments
- [ ] Spec is up to date
- [ ] Traceability matrix complete
- [ ] Reusable components documented

---

## Feature Delivery Format

When presenting completed feature to user:

```markdown
## FEATURE COMPLETE: [Feature Name]

### What Was Built
[Clear, concise description of the feature]

### Acceptance Criteria Status
| Criterion | Description | Status |
|-----------|-------------|--------|
| AC-001 | [Brief description] | PASSED |
| AC-002 | [Brief description] | PASSED |
| AC-003 | [Brief description] | PASSED |

### Quality Gates
| Gate | Status |
|------|--------|
| Code Quality | PASSED |
| Functionality | PASSED |
| Mobile Responsive | PASSED |
| Performance | PASSED |
| Accessibility | PASSED |
| Browser Testing | PASSED |
| Integration | PASSED |
| Security | PASSED |
| UX Consistency | PASSED |
| Documentation | PASSED |

### How to Test
1. [Step-by-step testing instructions]
2. [Include specific URLs/paths]
3. [Note any test credentials needed]

### Traceability
[Include completed traceability matrix]

### Known Limitations
[List any known limitations or future improvements]

---

**AWAITING YOUR APPROVAL**
```

---

## Bug Handling Workflow

### When a Bug is Found

```
1. STOP      → Do not fix immediately
2. ANALYZE   → Root cause analysis (5 Whys)
3. DOCUMENT  → Create post-mortem
4. TEST      → Write failing regression test
5. FIX       → Implement minimal fix
6. VERIFY    → Run all tests
7. REVIEW    → Quality Lead reviews
8. CLOSE     → Update post-mortem
```

### 5 Whys Analysis

Example:
```
Bug: User session expires immediately after login

1. Why? → Session token was not being stored
2. Why? → localStorage call was failing silently
3. Why? → localStorage was undefined in SSR context
4. Why? → Component was being rendered server-side
5. Why? → Missing "use client" directive

Root Cause: Component needs "use client" directive
```

### Severity Levels

| Severity | Definition | Response |
|----------|------------|----------|
| Critical | Data loss, security breach, complete failure | Immediate |
| High | Major feature broken, no workaround | Same day |
| Medium | Feature degraded, workaround exists | Next sprint |
| Low | Minor issue, cosmetic | Backlog |

---

## Git Workflow

### Core Rules

1. **NEVER** auto-commit
2. **NEVER** auto-push
3. AI proposes commits, user approves

### Commit Format: Conventional Commits

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Use For |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `spec` | Specification |
| `test` | Tests |
| `refactor` | Code refactoring |
| `chore` | Maintenance |

### Examples

```bash
feat(auth): add user login with email/password
fix(auth): prevent session expiry on page refresh
spec(auth): add login feature specification
test(auth): add login acceptance criteria tests
docs(auth): add login feature documentation
refactor(auth): extract session logic to hook
chore(deps): update dependencies
```

### Recommended Commit Points

1. After spec approved → `spec(feature): add [feature] specification`
2. After tests written → `test(feature): add acceptance tests`
3. After implementation → `feat(feature): implement [feature]`
4. After bug fix → `fix(feature): [description]`
5. After docs generated → `docs(feature): add documentation`

---

## Documentation Workflow

### Three Documentation Outputs

```
docs/specs/[feature].md      → INPUT (before coding)
docs/reviews/[feature].md    → QA (after coding)
docs/features/[feature].md   → OUTPUT (after approval)
```

### Auto-Generation Trigger

When user says "approved", "green light", or "looks good":

1. Generate `docs/features/[feature-name].md`
2. Include technical documentation
3. Include user-facing documentation
4. Mark feature as COMPLETE

### Feature Documentation Contents

**Technical:**
- Component/function API reference
- Props/parameters documentation
- Data flows and state management
- Code usage examples
- Integration points

**User-Facing:**
- Feature description
- How to use (step-by-step)
- Screenshots/examples
- Known limitations

---

## Team Personas

### Tech Lead (Alex Chen)

**Active in:** Phase 1 (Spec), Phase 3 (Implementation)

**Responsibilities:**
- Write technical specifications
- Design system architecture
- Implement features with TDD
- Optimize performance
- Handle security considerations

**Communication Style:**
- Technical but clear
- Comprehensive detail
- Focuses on correctness and maintainability

### Quality Lead (Dr. Priya Patel)

**Active in:** Phase 2 (Test Plan), Phase 4 (Review), Phase 5 (User Test)

**Responsibilities:**
- Plan test strategy
- Review quality gates
- Validate UX and accessibility
- Analyze bugs (root cause)
- Create review documents

**Communication Style:**
- Thorough and precise
- Detailed checklists
- Focuses on user experience and consistency

---

## Critical Rules

### NEVER

1. Write code without an approved spec
2. Skip Given/When/Then format for acceptance criteria
3. Proceed without explicit user approval at phase gates
4. Commit or push without user instruction
5. Skip quality gates
6. Fix bugs without root cause analysis
7. Ship features without documentation

### ALWAYS

1. Write failing tests before implementation
2. Update traceability matrix during implementation
3. Present features using standard delivery format
4. Stop and wait for user approval
5. Generate documentation on feature approval
6. Use Conventional Commits format
7. Create post-mortems for bugs
