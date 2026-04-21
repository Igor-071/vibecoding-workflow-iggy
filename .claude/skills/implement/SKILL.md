# Skill: TDD Implementation

Activate when: User approves a spec and you're ready to write code.

## Process

For EACH acceptance criterion in the approved spec:

### Step 0: Resolve the API (if using a framework or library)
Before writing any test, fetch current documentation:
```
Add 'use context7' to your next prompt, or invoke the context7 MCP tool.
Do this BEFORE writing the test — stale API docs mean a broken test from the start.
Skip this step only if you are writing pure logic with no third-party imports.
```

### Step 1: RED — Write a failing test
```
Write a test that asserts the expected behavior from the AC.
Run it. It MUST fail. If it passes, the test is wrong.
```

### Step 2: GREEN — Write minimum code
```
Write the simplest code that makes the test pass.
No optimization. No cleverness. Just make it green.
Run ALL tests — not just the new one.
```

### Step 3: BLUE — Refactor
```
Clean up while all tests stay green.
Extract duplication. Improve names. Simplify logic.
Run ALL tests after refactoring.
```

### Step 4: Update traceability
```
Fill in the test file and test name in the spec's traceability matrix.
```

Then move to the next AC.

## Rules

- One AC at a time. Don't batch.
- Run tests after EVERY change. Not just at the end.
- If a test is hard to write, the design is wrong. Refactor first.
- Context7 is Step 0, not a footnote — do it before writing the test.
- Keep test files next to source files or in a parallel `__tests__/` directory — match the project convention.

## After All ACs Are Done

1. Run full test suite: `npm run test`
2. Run lint: `npm run lint`
3. Present results to user in this format:

```
IMPLEMENTATION COMPLETE: [Feature Name]

Acceptance Criteria:
- AC-001: [description] — PASSED
- AC-002: [description] — PASSED

Tests: X passing, 0 failing
Lint: Clean

Traceability:
| Criterion | Test File        | Test Name              | Status |
|-----------|------------------|------------------------|--------|
| AC-001    | auth.test.ts:15  | handles valid login    | PASS   |

AWAITING YOUR APPROVAL
```

4. **STOP. Wait for user approval.**
