# Vibecoding Methodology

## Core Philosophy

> **"Precision through specification. Quality through discipline. Control through process."**

This methodology is designed for AI-assisted development where the human remains in complete control while leveraging AI capabilities for maximum productivity and quality.

---

## First Decision: Prototype or Production?

Before starting any project, you must decide: **Are you building a prototype or a production app?**

This is the most important decision because it determines the entire workflow rigor.

### Prototype Mode

**When to use:** MVPs, demos, concept validation, exploring ideas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ PROTOTYPE MODE                                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│ Focus:        Frontend-only                                                 │
│ Backend:      Mock data, local storage, or simple API mocks                 │
│ Iteration:    Fast - get visual feedback quickly                            │
│ Quality Gates: 5 essential gates only                                       │
│                                                                             │
│ Gates Used:                                                                 │
│   ✓ Tests pass        - npm run test (0 failures)                          │
│   ✓ Lint clean        - npm run lint (0 warnings)                          │
│   ✓ All ACs met       - Every AC has a passing test                        │
│   ✓ Responsive        - Works at 320/375/768/1024/1440px                   │
│   ✓ Code review       - Diff reviewed, no dead code or boundary issues     │
│                                                                             │
│ Gates Skipped:                                                              │
│   ○ Performance       - Lighthouse > 90, FCP < 1.5s                        │
│   ○ Accessibility     - WCAG 2.1 AA                                        │
│   ○ Cross-browser     - Chrome, Safari, Firefox                            │
│   ○ Build succeeds    - npm run build (0 errors)                           │
│   ○ Security scan     - XSS, injection, secrets check                      │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Why skip gates in prototype mode?**
- Speed matters more than perfection
- You're validating ideas, not shipping to users
- Many gates don't apply to frontend-only work
- You can always add rigor later when moving to production

### Production Mode

**When to use:** Production apps, client deliverables, anything users will rely on

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ PRODUCTION MODE                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│ Focus:        Full-stack, complete solution                                 │
│ Backend:      Real database, authentication, APIs                           │
│ Iteration:    Thorough - get it right the first time                       │
│ Quality Gates: All 10 gates mandatory                                       │
│                                                                             │
│ All Gates Required:                                                         │
│   ✓ Tests pass        - npm run test (0 failures)                          │
│   ✓ Lint clean        - npm run lint (0 warnings)                          │
│   ✓ All ACs met       - Every AC has a passing test                        │
│   ✓ Responsive        - Works at 320/375/768/1024/1440px                   │
│   ✓ Code review       - Diff reviewed, no dead code or boundary issues     │
│   ✓ Performance       - Lighthouse > 90, FCP < 1.5s                        │
│   ✓ Accessibility     - WCAG 2.1 AA                                        │
│   ✓ Cross-browser     - Chrome, Safari, Firefox                            │
│   ✓ Build succeeds    - npm run build (0 errors)                           │
│   ✓ Security scan     - XSS, injection, secrets check                      │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Transitioning from Prototype to Production

#### When to Transition

You're ready to move to production when:
- [ ] Prototype has been validated with users/stakeholders
- [ ] Core user flows are working
- [ ] You have approval (and budget) for full development
- [ ] You understand what needs to be built

#### How to Transition

**Option 1: Run the upgrade script (recommended for simple prototypes)**

```bash
./scripts/upgrade-to-production.sh
```

This will:
1. Update approach from "prototype" to "production"
2. Optionally set up backend framework and database
3. Create a transition checklist at `docs/specs/PRODUCTION-UPGRADE-CHECKLIST.md`

**Option 2: Rebuild from scratch (recommended for complex apps)**

If your prototype was exploratory and the code is messy:
1. Create a new project with `approach: "production"`
2. Use the prototype as a reference
3. Rebuild each feature with full specs and all 10 gates

#### What Changes

| Aspect | Prototype | Production |
|--------|-----------|------------|
| Quality Gates | 5 | 10 |
| Backend | Mock/local | Real APIs |
| Testing | Basic | Full coverage |
| Performance | Not measured | Lighthouse > 90 |
| Accessibility | Skipped | WCAG 2.1 AA |
| Security | Basic | Full audit |

#### The 5 New Gates to Address

When upgrading, you'll need to satisfy these additional gates:

1. **Performance**
   - Run Lighthouse audit
   - Optimize images, implement code splitting
   - Target: FCP < 1.5s, TTI < 3s

2. **Accessibility**
   - Add keyboard navigation
   - Add ARIA labels
   - Test with screen reader
   - Check color contrast

3. **Cross-browser**
   - Test Chrome, Safari, Firefox
   - Test mobile browsers

4. **Build succeeds**
   - `npm run build` exits 0
   - Replace mock data with real APIs as part of this transition
   - Ensure error handling and loading states are in place

5. **Security scan**
   - Move secrets to env vars
   - Sanitize all inputs
   - Add authentication/authorization

---

## Prototype-First Development

### The MOP Next.js Foundation

Every new Next.js project starts from the same opinionated foundation at
[`ministryofprogramming/mop-foundation-nextjs`](https://github.com/ministryofprogramming/mop-foundation-nextjs).

**Why pull, not copy?**

If you copy the foundation once, your project drifts from improvements over
time. Pulling fresh via `degit` means every new project gets the latest
routing conventions, config, tooling, and components — without merge conflicts,
because your code lives on top of it.

```bash
./scripts/add-mop-foundation.sh   # run once at setup
./scripts/add-mop-foundation.sh   # re-run any time to pull updates
```

Your workflow files (CLAUDE.md, .claude/, config/, docs/, scripts/) are
**never overwritten**. Only foundation code (app/, components/, package.json,
tsconfig.json, next.config.*) is updated.

`init-project.sh` will prompt you to scaffold automatically when you select
Next.js as your frontend framework.

### Working with Mock Data

Vibecoding prototypes are **frontend-only by design**. Real backend APIs are
replaced with:

- In-memory arrays and objects
- Mock functions (`getUsers`, `createOrder`, etc.)
- MSW (Mock Service Worker) handlers
- `localStorage` for simulated persistence

This lets the entire UI be built and validated before a single API endpoint
exists. Speed is the point — backend work happens only after the prototype
is approved.

### Backend Handoff with `/mock-data-doc`

When a prototype is approved, the backend team needs to know **exactly** what
to build. They shouldn't have to read through component files to reverse-engineer
the data model.

Run `/mock-data-doc` (or say **"generate mock data doc"**) in Claude Code.
Claude:

1. Scans all mock data sources in the codebase
2. Extracts entity shapes, operations, relationships, and constraints
3. Identifies prototype-only assumptions (no auth, hardcoded admins, etc.)
4. Writes `docs/MOCKED_DATA_STRUCTURE.md` — a complete handoff document

The backend team gets a clear spec for every entity, every endpoint, every
relationship, and every assumption they must replace in production.

Commit the file to `docs/` before handing off.

---

## The "Why" Behind Our Approach

### Why Spec-Driven Development?

**Problem:** AI can write code fast, but often writes the *wrong* code because requirements are unclear or ambiguous.

**Solution:** Write detailed specifications BEFORE any code. The spec becomes the single source of truth that both human and AI agree on.

**Benefits:**
- No ambiguity about what to build
- AI has clear, testable requirements
- Changes are made in spec first (cheap) not in code (expensive)
- Documentation exists before the feature is built

### Why Given/When/Then Format?

**Problem:** Natural language requirements like "make login secure" are interpreted differently by everyone.

**Solution:** Use BDD-style Given/When/Then format that describes exact behavior:

```gherkin
GIVEN a user who has failed login 3 times
WHEN they attempt a 4th login
THEN the account is locked for 15 minutes
AND they see message "Account locked. Try again in 15 minutes."
```

**Benefits:**
- Zero ambiguity - each criterion is testable
- AI knows EXACTLY what to implement
- Tests can be generated directly from criteria
- Edge cases are explicitly defined

### Why Test-Driven Development (TDD)?

**Problem:** Code written without tests often has hidden bugs. Retrofitting tests misses edge cases.

**Solution:** Write the test FIRST, watch it fail, then write code to make it pass:

```
RED    → Write failing test (proves test works)
GREEN  → Write minimum code to pass (no over-engineering)
BLUE   → Refactor while keeping tests green (safe improvement)
```

**Benefits:**
- Every line of code has a reason to exist
- Tests document expected behavior
- Refactoring is safe
- Bugs are caught immediately

### Why Spec-to-Test Traceability?

**Problem:** Requirements and tests drift apart. Features ship without full test coverage.

**Solution:** Every acceptance criterion maps to a specific test:

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `login.test.ts` | `should lock after 3 failures` | PASSED |

**Benefits:**
- Nothing falls through the cracks
- Easy to verify completeness
- Clear audit trail
- Confidence in test coverage

### Why Stop & Wait Protocol?

**Problem:** AI can run ahead, making changes you didn't approve or going in wrong direction.

**Solution:** AI must STOP and WAIT for explicit approval at key points:
- After spec is written
- After implementation is complete
- Before any commit or push

**Benefits:**
- Human remains in control
- Mistakes caught early
- Clear approval trail
- No surprise changes

### Why Manual Git Control?

**Problem:** Automatic commits create messy history and can commit broken code.

**Solution:** Human explicitly requests commits and pushes. AI suggests commit messages but never acts without instruction.

**Benefits:**
- Clean commit history
- Atomic, meaningful commits
- No accidental pushes
- Full control over version history

### Why Quality Gates?

**Problem:** "It works on my machine" syndrome. Features ship with hidden issues.

**Solution:** 10 mandatory quality gates that MUST pass before user testing:

1. Tests pass
2. Lint clean
3. All ACs met
4. Responsive
5. Code review
6. Performance
7. Accessibility
8. Cross-browser
9. Build succeeds
10. Security scan

(Authoritative definition: `.claude/skills/review/SKILL.md`.)

**Benefits:**
- Consistent quality standard
- Nothing shipped without verification
- Issues caught before user sees them
- Professional-grade output

### Why Bug Post-Mortems?

**Problem:** Same bugs keep happening. No learning from mistakes.

**Solution:** Every bug gets a post-mortem with:
- Root cause analysis (5 Whys)
- Regression test added
- Prevention measures documented

**Benefits:**
- Learn from every bug
- Prevent repeat occurrences
- Build institutional knowledge
- Improve quality gates

### Why Auto-Generated Documentation?

**Problem:** Documentation is often skipped or outdated.

**Solution:** When user approves a feature, documentation is automatically generated:
- Technical docs (API, props, data flows)
- User-facing docs (how-to, descriptions)

**Benefits:**
- Documentation always exists
- Always up-to-date
- No extra effort required
- Professional deliverables

---

## Guiding Principles

### 1. Precision Over Speed

It's better to build the RIGHT thing slowly than the WRONG thing quickly.

- Take time to write detailed specs
- Use exact language in acceptance criteria
- Verify understanding before coding

### 2. Quality Is Non-Negotiable

Every feature must pass ALL quality gates. No exceptions. No "we'll fix it later."

- All gates must show GREEN
- Bugs are fixed before new features
- Technical debt is addressed, not accumulated

### 3. Human Control

The human is always in control. AI is a powerful tool, but the human makes decisions.

- AI proposes, human approves
- No automatic commits or pushes
- Clear approval points in workflow

### 4. Documentation as Deliverable

Documentation is part of the feature, not an afterthought.

- Spec before code
- Review after code
- Feature docs on approval

### 5. Learn From Every Bug

Bugs are opportunities to improve the system, not just problems to fix.

- Root cause analysis required
- Prevention measures documented
- Quality gates updated if needed

### 6. Simple Before Complex

Start with the simplest solution that could work. Add complexity only when needed.

- No premature optimization
- No over-engineering
- YAGNI (You Aren't Gonna Need It)

---

## The Complete Flow

```
[User Request]
     ↓
[Phase 1: SPEC] → Write detailed spec with Given/When/Then
     ↓
[User Approval] → "Spec approved"
     ↓
[Phase 2: TEST PLAN] → Plan tests for each criterion
     ↓
[Phase 3: IMPLEMENT] → TDD: Red-Green-Blue cycle
     ↓
[Phase 4: REVIEW] → All 10 quality gates must pass
     ↓
[Phase 5: USER TEST] → Present to user, STOP & WAIT
     ↓
[User Approval] → "Approved" / "Green light"
     ↓
[Auto-Generate Docs] → Feature documentation created
     ↓
[User Request] → "Commit" (if ready)
     ↓
[COMPLETE]
```

---

## When to Deviate

This methodology is designed for building features with quality. Some situations may call for deviation:

| Situation | Approach |
|-----------|----------|
| **Quick experiment** | Skip formal spec, but document learnings |
| **Critical hotfix** | Fix first, post-mortem after |
| **Trivial change** | Simplified spec, same quality gates |
| **Learning/exploration** | Informal, but capture insights |

Even when deviating, maintain:
- User control (Stop & Wait)
- Manual git
- Basic quality checks

---

## Success Metrics

You're using this methodology well when:

- [ ] Every feature has a spec BEFORE code
- [ ] All acceptance criteria use Given/When/Then
- [ ] Tests exist for every criterion
- [ ] Quality gates pass before user sees features
- [ ] Documentation is generated automatically
- [ ] Bugs have post-mortems
- [ ] Commit history is clean and meaningful
- [ ] No surprises - user always knows what's happening
