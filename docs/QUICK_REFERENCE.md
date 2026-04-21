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

**Prototype Mode (always required):**

| Gate | Check |
|------|-------|
| Tests pass | `npm run test` — 0 failures |
| Lint clean | `npm run lint` — 0 warnings |
| All ACs met | Every AC has a passing test |
| Responsive | 320/375/768/1024/1440px |
| Code review | No dead code, hardcoded values, boundary errors |

**Production Mode (adds 5 more):**

| Gate | Check |
|------|-------|
| Performance | Lighthouse > 90 |
| Accessibility | WCAG 2.1 AA |
| Cross-browser | Chrome, Safari, Firefox |
| Build succeeds | `npm run build` — 0 errors |
| Security scan | XSS, injection, secrets in env vars |

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

---

## Tooling

### Skills (Slash Commands)

| Command | When to Use |
|---------|-------------|
| `/spec` | Starting a new feature — creates spec in `docs/specs/` |
| `/test-plan` | After spec is approved — produces test matrix in the spec file |
| `/implement` | After test plan is approved — TDD cycle |
| `/review` | After implementation — runs all quality gates |
| `/ship` | After review passes — commit + PR |
| `/bug` | When a bug is found — root cause + regression test |
| `/mock-data-doc` | When a prototype is done — generates `docs/MOCKED_DATA_STRUCTURE.md` for backend handoff |

Skills live in `.claude/skills/[name]/SKILL.md`.

### Hooks (Automatic)

Configured in `.claude/settings.json` — no action needed:

| Hook | Trigger | What it does |
|------|---------|--------------|
| Auto-lint | Every Write/Edit on `.js/.ts/.tsx` | Runs `eslint --fix` on the file |
| Pre-commit | Every `git commit` | Runs `npm run lint && npm run test` |

### MCP Servers

Configured in `.mcp.json`:

| Server | Purpose | Activation |
|--------|---------|------------|
| `context7` | Live framework/library docs | Add `use context7` to any prompt |
| `playwright` | Browser automation, E2E, responsive | Available automatically |
| `github` | Issues, PRs, code search | Requires `GITHUB_TOKEN` env var |
| `sequential-thinking` | Structured architecture reasoning | Available automatically |
| `memory` | Persistent knowledge across sessions | Available automatically |

### use context7

Add `use context7` to any prompt involving a framework or library:

```
"Build a login form with React Hook Form, use context7"
"Configure Vite for SSR, use context7"
```

### MOP Next.js Foundation

New Next.js projects pull the latest foundation from
`github.com/ministryofprogramming/mop-foundation-nextjs` via `degit` (not
vendored). Workflow files are preserved.

```bash
./scripts/add-mop-foundation.sh         # pull latest main
./scripts/add-mop-foundation.sh v1.2.0  # pin to tag/branch/commit
```

Re-run any time to update.

### Personal Preferences

```bash
cp CLAUDE.local.md.example CLAUDE.local.md
# Edit CLAUDE.local.md — it is gitignored
```
