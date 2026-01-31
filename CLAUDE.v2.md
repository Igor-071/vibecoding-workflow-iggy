# CLAUDE.md - Vibecoding Workflow 2.0

> **Smart, Adaptive AI-Assisted Development**
> The right amount of ceremony for every change.

---

## Quick Start

```
/v fix typo in header          → MINIMAL (5 min, just do it)
/v fix login button broken     → LIGHT (30 min, 1 approval)
/v feature add dark mode       → STANDARD (2-4 hrs, 2 approvals)
/v epic payment system         → FULL (1-3 days, 3+ approvals)
/v hotfix prod is down         → EMERGENCY (ASAP, fix first)
```

---

## Project Configuration

**Project:** [PROJECT_NAME]
**Mode:** [prototype | production]
**Type:** [web | mobile | backend | fullstack | cli]
**Stack:** [TECH_STACK]

---

## 1. COMMAND SYSTEM

### 1.1 Change Commands

| Command | Alias | Default Tier | Use For |
|---------|-------|--------------|---------|
| `/vibe fix` | `/v fix` | Minimal | Typos, small corrections |
| `/vibe tweak` | `/v tweak` | Minimal | Styling adjustments |
| `/vibe update` | `/v update` | Light | Update existing feature |
| `/vibe add` | `/v add` | Light | Small component/function |
| `/vibe refactor` | `/v refac` | Light | Code cleanup |
| `/vibe feature` | `/v feat` | Standard | New feature |
| `/vibe epic` | `/v epic` | Full | Major feature |
| `/vibe hotfix` | `/v hot` | Emergency | Production fix |

### 1.2 Control Commands

| Command | Purpose |
|---------|---------|
| `/v status` | Show current workflow state |
| `/v approve` | Approve current phase |
| `/v reject` | Request changes |
| `/v skip` | Skip a phase (with confirmation) |
| `/v pause` | Pause workflow |
| `/v resume` | Resume paused workflow |
| `/v commit` | Request git commit |
| `/v ship` | Approve + commit + push |
| `/v gates` | Show quality gates status |
| `/v help` | Show all commands |

### 1.3 Tier Overrides

```
/v feature --light "add tooltip"     # Force light tier
/v fix --standard "auth bug"         # Force standard tier
/v add --with-spec "payment form"    # Add spec to light tier
```

### 1.4 Natural Language

Also recognize these phrases:
- **Approval:** "looks good", "approved", "ship it", "proceed"
- **Rejection:** "needs changes", "not yet", "wait"
- **Upgrade:** "let's do this properly", "full process"
- **Downgrade:** "keep it simple", "just do it quick"

---

## 2. TIER SYSTEM

### 2.1 Overview

```
TIER        TIME      STOPS   GATES   DOCS
─────────   ───────   ─────   ─────   ────
⚡ Minimal   ~5 min    0       1       Commit msg
🔧 Light     ~30 min   1       3       Commit msg
📋 Standard  ~2-4 hrs  2       5/10    Spec + Feature doc
📚 Full      ~1-3 days 3+      All     Full documentation
🚨 Emergency ASAP      1       Critical Post-mortem
```

### 2.2 MINIMAL TIER ⚡

**When:** Typos, copy changes, simple CSS tweaks, config changes

**Process:**
```
Request → Make Change → Lint → Done
```

**Example:**
```
User: /v fix typo "Welcom" should be "Welcome"

Claude: ✅ DONE
Changed: src/components/Header.tsx (line 12)
- <h1>Welcom to Our App</h1>
+ <h1>Welcome to Our App</h1>
Lint: ✅ Passed
Say "/v commit" when ready.
```

**Gates:** Lint only
**Docs:** Commit message only

### 2.3 LIGHT TIER 🔧

**When:** Bug fixes, small additions, refactoring (1-3 files, <100 lines)

**Process:**
```
Request → Explain Approach → Implement + Test → Verify → Present
                                                           ↓
                                                    [STOP: Approval]
```

**Example:**
```
User: /v fix dropdown not closing when clicking outside

Claude: 📊 Detected: LIGHT
[Implements fix with tests]

✅ FIX COMPLETE: Dropdown Close on Outside Click

CHANGES:
• DropdownMenu.tsx - Added useClickOutside hook
• Added test for close behavior

TESTS: ✅ All passing (8/8)
LINT: ✅ Passed

AWAITING APPROVAL - "/v approve"
```

**Gates:** Lint, Tests, Functionality
**Docs:** Detailed commit message

### 2.4 STANDARD TIER 📋

**When:** New features, API changes, database changes (3-10 files)

**Process:**
```
Request → Create Inline Spec → [STOP 1: Approve Spec]
                                       ↓
               TDD Implementation → Quality Gates → Present
                                                      ↓
                                              [STOP 2: Final Approval]
                                                      ↓
                                              Generate Docs → Done
```

**Inline Spec Format:**
```
📋 FEATURE SPEC: [Title]
━━━━━━━━━━━━━━━━━━━━━━━━

GOAL: [One sentence]

ACCEPTANCE CRITERIA:
┌─────────────────────────────────────────┐
│ AC-1: [Title]                           │
│ GIVEN [context]                         │
│ WHEN [action]                           │
│ THEN [result]                           │
├─────────────────────────────────────────┤
│ AC-2: [Title]                           │
│ ...                                     │
└─────────────────────────────────────────┘

TECHNICAL APPROACH:
• [Key technical decisions]

━━━━━━━━━━━━━━━━━━━━━━━━
APPROVE SPEC? "/v approve"
```

**Gates:**
- Prototype: Lint, Tests, Functionality, Responsive, UX (5)
- Production: All 10 gates

**Docs:** Inline spec + Feature documentation

### 2.5 FULL TIER 📚

**When:** Major features, architecture changes, security-critical (10+ files)

**Process:**
```
Request → Full Spec Doc → [STOP 1: Approve Spec]
                                   ↓
                          Test Plan → [STOP 2: Approve Tests]
                                            ↓
                     TDD Implementation (with progress updates)
                                            ↓
                            All Gates + Review Doc → [STOP 3: Final Review]
                                                            ↓
                                                  Full Documentation → Done
```

**Gates:** All gates + Architecture Review + Security Review (if applicable)
**Docs:** Spec file + Review file + Feature doc + ADR (if architectural)

### 2.6 EMERGENCY TIER 🚨

**When:** Production down, security vulnerability, data loss risk

**Process:**
```
"/v hotfix" → Rapid Investigation → Minimal Fix → Critical Tests
                                                        ↓
                                                [STOP: Deploy?]
                                                        ↓
                                           Deploy → POST-MORTEM (24h)
```

**Example:**
```
User: /v hotfix users can't login getting 500 error

Claude: 🚨 EMERGENCY WORKFLOW

Investigating...
Found: DB connection pool exhausted

✅ HOTFIX READY
Fix: Added connection.release() in finally block
Critical Test: ✅ Login works

⚠️ Post-mortem required within 24h

DEPLOY NOW? "/v approve"
```

---

## 3. AUTO-DETECTION

### 3.1 How Detection Works

Claude analyzes your request for:
- **Keywords:** "typo", "fix", "feature", "epic", etc.
- **Patterns:** "change X to Y", "add new feature", etc.
- **Scope indicators:** File count, line estimate, API/DB changes

### 3.2 Detection Output

```
📊 CHANGE ANALYSIS
─────────────────
Request: "Fix the login button not working on mobile"

Detected Tier: LIGHT 🔧
Confidence: 85%

Reasoning:
  • "fix" + "not working" (bug indicators)
  • Single component scope
  • Platform-specific issue

Proposed Process:
  1. Investigate
  2. Implement fix
  3. Test
  4. Present for approval

[Proceed?] or "/v --standard" to upgrade
```

### 3.3 Override Detection

You can always override:
```
/v --minimal    # Force minimal
/v --light      # Force light
/v --standard   # Force standard
/v --full       # Force full
```

---

## 4. QUALITY GATES

### 4.1 Gate Summary

| # | Gate | Minimal | Light | Standard | Full |
|---|------|---------|-------|----------|------|
| 1 | Lint | ✅ | ✅ | ✅ | ✅ |
| 2 | Tests | - | ✅ | ✅ | ✅ |
| 3 | Functionality | - | ✅ | ✅ | ✅ |
| 4 | Responsive | - | opt | ✅ | ✅ |
| 5 | UX | - | opt | ✅ | ✅ |
| 6 | Performance | - | - | prod | ✅ |
| 7 | Accessibility | - | - | prod | ✅ |
| 8 | Browser | - | - | prod | ✅ |
| 9 | Integration | - | - | prod | ✅ |
| 10 | Security | - | - | prod | ✅ |

*opt = optional, prod = production mode only*

### 4.2 Gate Details

See `config/gates.yaml` for full gate definitions including:
- Specific checks for each gate
- Commands to run
- Tools to use
- Pass/fail criteria

---

## 5. WORKFLOW STATE

### 5.1 Status Command

```
/v status

📊 WORKFLOW STATUS
══════════════════════════════════════════

Feature: Dark Mode Toggle
Tier: STANDARD 📋
Started: 1 hour ago

PROGRESS:
┌──────────────────────────────────────────┐
│ ✅ Spec          │ Approved               │
│ 🔄 Implementation │ AC-2 of 4 (50%)       │
│ ⏳ Review         │ Waiting                │
│ ⏳ Approval       │ Waiting                │
└──────────────────────────────────────────┘

ACCEPTANCE CRITERIA:
  ✅ AC-1: Toggle visible in header
  🔄 AC-2: Theme switching works
  ⏳ AC-3: Preference persists
  ⏳ AC-4: System preference default

NEXT ACTION: Complete AC-2 implementation
══════════════════════════════════════════
```

### 5.2 Pause & Resume

```
/v pause          # Save state, work on something else
/v resume         # Continue where you left off
```

---

## 6. GIT WORKFLOW

### 6.1 Rules

- **NEVER** auto-commit or auto-push
- Wait for explicit `/v commit` or `/v ship`
- Use Conventional Commits format

### 6.2 Commit Format

```
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `docs`, `spec`, `test`, `refactor`, `chore`

### 6.3 Commands

```
/v commit         # Create commit (Claude proposes message)
/v push           # Push to remote
/v ship           # Approve + Commit + Push
```

---

## 7. OUTPUT FORMATS

### 7.1 Minimal Complete

```
✅ DONE

Changed: {file} (line {n})
{diff}

Lint: ✅ Passed

Say "/v commit" when ready.
```

### 7.2 Light Complete

```
✅ FIX COMPLETE: {title}

WHAT WAS FIXED:
{description}

CHANGES:
• {file1} - {change}
• {file2} - {change}

TESTS: ✅ {pass}/{total}
LINT: ✅ Passed

AWAITING APPROVAL - "/v approve"
```

### 7.3 Standard Complete

```
## ✅ FEATURE COMPLETE: {title}

### What Was Built
{description}

### Acceptance Criteria
| AC | Description | Status |
|----|-------------|--------|
| 1  | {desc}      | ✅     |
| 2  | {desc}      | ✅     |

### Quality Gates
✅ Lint  ✅ Tests  ✅ Func  ✅ Mobile  ✅ UX

### How to Test
1. {step}
2. {step}

### Traceability
| AC | Test File | Test Name | Status |
|----|-----------|-----------|--------|
| 1  | {file}    | {name}    | ✅     |

**AWAITING APPROVAL** - "/v approve"
```

---

## 8. ACCEPTANCE CRITERIA FORMAT

Always use Given/When/Then:

```gherkin
AC-1: [Brief title]
GIVEN [precondition]
WHEN [action]
THEN [expected result]
```

Example:
```gherkin
AC-1: Successful login
GIVEN a registered user on the login page
WHEN they enter valid credentials
AND click "Sign In"
THEN they are redirected to dashboard
AND see welcome message
```

---

## 9. BUG HANDLING

### 9.1 Regular Bugs (Light/Standard)

1. Analyze root cause
2. Write failing test
3. Fix minimally
4. Verify all tests pass

### 9.2 Emergency Bugs (Hotfix)

1. Fix immediately
2. Deploy
3. **Post-mortem required within 24 hours**

### 9.3 Post-Mortem (5 Whys)

```
Bug: User session expires immediately

1. Why? → Token not stored
2. Why? → localStorage failed
3. Why? → localStorage undefined
4. Why? → Running on server
5. Why? → Missing "use client"

Root Cause: Component needs "use client"
Prevention: Add SSR check to auth utils
```

---

## 10. KEY FILES

| File | Purpose |
|------|---------|
| `config/vibe.config.yaml` | Main configuration |
| `config/commands.yaml` | Command definitions |
| `config/tiers.yaml` | Tier process definitions |
| `config/detection.yaml` | Auto-detection rules |
| `config/gates.yaml` | Quality gate definitions |
| `.vibe/state.yaml` | Current workflow state |

---

## 11. COMMANDS REFERENCE

### Build & Test
```bash
npm run dev              # Start dev server
npm run test             # Run tests
npm run test:coverage    # With coverage
npm run lint             # Run linter
npm run lint:fix         # Auto-fix lint issues
npm run typecheck        # TypeScript check
npm run build            # Production build
```

---

## 12. RULES

### NEVER
1. Write code without appropriate tier process
2. Skip user approval at stop points
3. Commit/push without explicit request
4. Skip required quality gates
5. Fix emergency bugs without post-mortem

### ALWAYS
1. Detect and confirm tier before starting
2. Use Given/When/Then for acceptance criteria
3. Run TDD for Light tier and above
4. Show clear status and next actions
5. Let user override tier detection

---

## 13. DECISION TREE

```
User makes request
        │
        ▼
┌───────────────────┐
│ Explicit command? │
│ (/v fix, /v feat) │
└────────┬──────────┘
         │
    ┌────┴────┐
   YES        NO
    │          │
    ▼          ▼
Use command   Analyze request
default tier  for indicators
    │          │
    ▼          ▼
┌───────────────────┐
│ Show detection    │
│ with reasoning    │
└────────┬──────────┘
         │
         ▼
┌───────────────────┐
│ User confirms or  │
│ overrides tier    │
└────────┬──────────┘
         │
         ▼
┌───────────────────┐
│ Execute tier      │
│ process           │
└───────────────────┘
```

---

## 14. EXAMPLES

### Example 1: Minimal
```
User: /v fix typo in footer - "Copywrite" should be "Copyright"

Claude: ✅ DONE
Changed: src/components/Footer.tsx (line 8)
- <p>Copywrite 2024</p>
+ <p>Copyright 2024</p>
Lint: ✅
"/v commit" when ready.
```

### Example 2: Light
```
User: The search input doesn't clear after submitting

Claude: 📊 Detected: LIGHT (bug fix)
[Investigates, fixes, tests]

✅ FIX COMPLETE: Search Input Clear
• Added setQuery('') after submit
• Test added for clear behavior
AWAITING APPROVAL

User: /v approve

Claude: ✅ Approved. "/v commit" when ready.
```

### Example 3: Standard
```
User: /v feature add user profile editing

Claude: 📊 Detected: STANDARD

📋 FEATURE SPEC: User Profile Editing
...
APPROVE SPEC? "/v approve"

User: /v approve

Claude: ✅ Spec approved. Starting implementation...
[TDD implementation]
[Quality gates]

✅ FEATURE COMPLETE
[Full presentation]
AWAITING APPROVAL

User: looks good

Claude: ✅ Feature approved!
Documentation generated: docs/features/user-profile-editing.md
"/v commit" when ready.
```

### Example 4: Emergency
```
User: /v hotfix payments are failing in production!

Claude: 🚨 EMERGENCY WORKFLOW

Investigating payment flow...
Found: Stripe API key expired

✅ HOTFIX READY
Updated: .env.production (API key)
Test: ✅ Payment processes

DEPLOY? "/v approve"

User: /v ship

Claude: ✅ Deployed
⚠️ POST-MORTEM required within 24h
Run "/v postmortem" to start.
```

---

*Vibecoding Workflow 2.0 - The right process for every change.*
