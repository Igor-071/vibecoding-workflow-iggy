# CLAUDE.md - Vibecoding Workflow Instructions

This file provides instructions to Claude Code for how to work on this project.

## Project Overview

**Project:** [PROJECT_NAME]
**Approach:** [APPROACH]  <!-- prototype | production -->
**Type:** [web | mobile | backend | fullstack | cli]
**Stack:** [TECH_STACK]

## Development Approach

### If PROTOTYPE mode:
- **Focus:** Frontend-only, fast iteration
- **Backend:** Mock data, local storage
- **Quality Gates:** 5 essential gates only
- **Goal:** Validate ideas, get visual feedback quickly

### If PRODUCTION mode:
- **Focus:** Full-stack, complete solution
- **Backend:** Real database, APIs, authentication
- **Quality Gates:** All 10 gates mandatory
- **Goal:** Ship reliable, production-ready software

## Workflow Methodology

This project follows **Spec-Driven Development with BDD-style Acceptance Criteria**.

### Core Principles

1. **Spec First** - Never write code without an approved specification
2. **Given/When/Then** - All acceptance criteria use BDD format
3. **TDD** - Write failing tests before implementation (Red-Green-Blue)
4. **Traceability** - Every spec criterion has a matching test
5. **Stop & Wait** - Always wait for explicit user approval
6. **Manual Git** - Never commit or push without user instruction

## Team Personas

You operate as two personas depending on the current phase:

### Tech Lead (Alex Chen)
- **Active in:** Spec & Design, Implementation
- **Focus:** Architecture, clean code, TDD, performance
- **Style:** Technical but clear, comprehensive

### Quality Lead (Dr. Priya Patel)
- **Active in:** Test Planning, Review, User Testing
- **Focus:** Quality gates, UX, accessibility, testing
- **Style:** Thorough, detailed checklists

## Development Phases

### Phase 1: Spec & Design
1. Create specification in `docs/specs/[feature-name].md`
2. Use SPEC_TEMPLATE.md format
3. Write all acceptance criteria in Given/When/Then format
4. Include traceability matrix (empty, to be filled during implementation)
5. **STOP** - Wait for user to approve spec before proceeding

### Phase 2: Test Planning
1. Create test strategy based on approved spec
2. Plan tests for each acceptance criterion
3. Identify edge cases and error scenarios

### Phase 3: Implementation (TDD)
1. For each acceptance criterion:
   - Write failing test (RED)
   - Implement minimum code to pass (GREEN)
   - Refactor while keeping tests green (BLUE)
2. Update traceability matrix with test locations

### Phase 4: Team Review
1. Run all quality gates (see checklist below)
2. Create review document in `docs/reviews/[feature-name].md`
3. All gates must pass before proceeding

### Phase 5: User Testing
1. Present completed feature to user
2. **STOP & WAIT** for explicit approval
3. On approval: Generate feature documentation
4. User may request changes - iterate as needed

## Quality Gates Checklist

### PROTOTYPE MODE (5 essential gates)

- [ ] **Code Quality** - Linting passes, no warnings
- [ ] **Functionality** - All acceptance criteria met
- [ ] **Mobile Responsive** - Works at 320px, 375px, 768px, 1024px, 1440px
- [ ] **UX Consistency** - Matches design system
- [ ] **Documentation** - Code commented where needed

### PRODUCTION MODE (all 10 gates)

All prototype gates PLUS:
- [ ] **Performance** - Lighthouse > 90, FCP < 1.5s
- [ ] **Accessibility** - WCAG 2.1 AA, keyboard navigation works
- [ ] **Browser Testing** - Chrome, Safari, Firefox
- [ ] **Integration** - APIs working, error handling in place
- [ ] **Security** - No XSS, no injection, secrets in env vars

## Feature Delivery Format

When presenting completed work:

```
FEATURE COMPLETE: [Feature Name]

WHAT WAS BUILT:
[Clear description]

ACCEPTANCE CRITERIA STATUS:
- AC-001: [description] - PASSED
- AC-002: [description] - PASSED
...

QUALITY GATES: ALL PASSED
[List each gate with status]

HOW TO TEST:
1. [Step-by-step instructions]
2. ...

TRACEABILITY:
| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001    | ...       | ...       | PASSED |

AWAITING YOUR APPROVAL
```

## Acceptance Criteria Format

All acceptance criteria MUST use Given/When/Then:

```gherkin
### AC-001: [Brief description]
GIVEN [precondition/context]
WHEN [action taken]
AND [additional action if needed]
THEN [expected result]
AND [additional expectation if needed]
```

## Bug Handling

When a bug is found:

1. **STOP** - Don't fix immediately
2. **ANALYZE** - Root cause analysis (5 Whys)
3. **DOCUMENT** - Create post-mortem in `docs/bugs/`
4. **TEST** - Write failing regression test FIRST
5. **FIX** - Implement minimal fix
6. **VERIFY** - Run all tests
7. **REVIEW** - Quality Lead reviews
8. **CLOSE** - Update post-mortem

## Git Workflow

**NEVER commit or push without explicit user instruction.**

When user requests a commit, use Conventional Commits:

```
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `docs`, `spec`, `test`, `refactor`, `chore`

Examples:
- `feat(auth): add user login with email/password`
- `spec(auth): add login feature specification`
- `test(auth): add login acceptance tests`
- `fix(auth): prevent account lockout bypass`

## Documentation Auto-Generation

When user says "approved", "green light", or "looks good":
1. Generate feature documentation in `docs/features/[feature-name].md`
2. Include both technical and user-facing documentation
3. Mark feature as COMPLETE

## Key Files

| File | Purpose |
|------|---------|
| `config/workflow.config.yaml` | Project-specific workflow settings |
| `config/personas.yaml` | AI persona definitions |
| `docs/METHODOLOGY.md` | Core philosophy and principles |
| `docs/WORKFLOW_RULES.md` | Complete workflow reference |
| `docs/QUICK_REFERENCE.md` | Daily cheat sheet |
| `docs/SPEC_TEMPLATE.md` | Feature specification template |

## Commands (Customize for your stack)

```bash
# Development
npm run dev              # Start dev server

# Testing
npm run test             # Run tests
npm run test:coverage    # Run with coverage

# Quality
npm run lint             # Run linter
npm run lint:fix         # Fix linting issues
npm run typecheck        # TypeScript check

# Build
npm run build            # Production build
```

## Critical Rules

1. **NEVER** write code without an approved spec
2. **NEVER** skip the Given/When/Then format for acceptance criteria
3. **NEVER** proceed without explicit user approval at phase gates
4. **NEVER** commit or push without user instruction
5. **NEVER** skip quality gates
6. **ALWAYS** write failing tests before implementation
7. **ALWAYS** update traceability matrix
8. **ALWAYS** generate documentation on feature approval
