# Skill: Test Planning

Activate when: User says "plan tests", "/test-plan", or after a spec is approved and before implementation begins.

Purpose: Between an approved spec and the first RED test, produce a test matrix so TDD cycles don't thrash. One pass of thinking up front saves many test rewrites later.

## Process

### Step 1: Load the approved spec

Read `docs/specs/[feature-name].md`. Confirm it is approved (look for an "APPROVED" marker or ask the user if unclear). If the spec has no ACs, stop and ask for ACs before planning tests.

### Step 2: For each AC, decide the test shape

For every AC-NNN in the spec, decide:

- **Test level**: unit | integration | E2E
- **Test file**: where it will live (`src/**/*.test.ts`, `tests/e2e/*.spec.ts`, etc.)
- **Test name**: a Given/When/Then phrase matching the AC
- **Fixtures needed**: mock data, stubs, test DB seed
- **Edge cases**: at least one negative path per AC

### Step 3: Call out cross-cutting tests

Some tests aren't tied to a single AC — call them out separately:
- Responsive breakpoint tests (if UI)
- Accessibility smoke test (if UI + production mode)
- Error-path tests that span multiple ACs

### Step 4: Write the test plan

Append a `## Test Plan` section to `docs/specs/[feature-name].md`:

```markdown
## Test Plan

| AC | Level | File | Test Name | Fixtures | Edge Cases |
|----|-------|------|-----------|----------|------------|
| AC-001 | unit | `src/auth/login.test.ts` | `redirects on valid credentials` | mock user | wrong password, locked account |
| AC-002 | integration | `tests/api/session.test.ts` | `stores session token` | in-memory db | expired token |

**Cross-cutting:**
- Responsive: `tests/responsive/login.spec.ts` (320/768/1440)
- A11y smoke: `tests/a11y/login.spec.ts` (keyboard + axe)
```

### Step 5: Stop & Wait

Report:

```
TEST PLAN READY

File: docs/specs/[feature-name].md (Test Plan section appended)
Total tests planned: N
Levels: X unit, Y integration, Z E2E

Next: approve this plan, then /implement to start the TDD cycle.

AWAITING YOUR APPROVAL
```

## Rules

- One test per AC minimum. Fewer = AC is too vague, push back.
- Don't write the test code here — just the matrix.
- Prefer unit > integration > E2E. Only go higher when the AC demands it.
- If the spec has no ACs, stop and ask for ACs before planning tests.
