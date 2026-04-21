# Vibecoding Workflow 2.0 - Improvement Plan

## Executive Summary

Transform the current workflow into a **smart, adaptive system** that automatically scales ceremony based on change complexity. Users interact through simple commands, and Claude intelligently applies the right level of process.

---

## Part 1: Command System Design

### 1.1 Command Prefix Structure

All workflow commands use the `/vibe` prefix (or just `/v` for short):

```
/vibe <action> [options] <description>
/v <action> [options] <description>
```

### 1.2 Core Commands

| Command | Alias | Purpose | Ceremony Level |
|---------|-------|---------|----------------|
| `/vibe fix` | `/v fix` | Bug fixes, small corrections | Minimal |
| `/vibe tweak` | `/v tweak` | Minor adjustments, styling | Minimal |
| `/vibe update` | `/v update` | Update existing feature | Light |
| `/vibe add` | `/v add` | Add small feature/component | Light |
| `/vibe feature` | `/v feat` | New feature development | Standard |
| `/vibe epic` | `/v epic` | Large/complex feature | Full |
| `/vibe refactor` | `/v refac` | Code refactoring | Light |
| `/vibe hotfix` | `/v hot` | Emergency production fix | Emergency |

### 1.3 Modifier Flags

Users can override auto-detection:

```
/vibe feature --full "user authentication"    # Force full ceremony
/vibe feature --light "add tooltip"           # Force light ceremony
/vibe fix --skip-test "typo in label"         # Skip test requirement
/vibe add --with-spec "payment integration"   # Request spec even for small add
```

### 1.4 Workflow Control Commands

| Command | Purpose |
|---------|---------|
| `/vibe status` | Show current workflow state, active feature, phase |
| `/vibe skip <phase>` | Skip a phase (with confirmation) |
| `/vibe pause` | Pause current workflow, save state |
| `/vibe resume` | Resume paused workflow |
| `/vibe abort` | Abandon current workflow |
| `/vibe approve` | Approve current phase, proceed |
| `/vibe reject` | Reject, request changes |
| `/vibe commit` | Request git commit |
| `/vibe ship` | Approve + commit + push |

### 1.5 Query Commands

| Command | Purpose |
|---------|---------|
| `/vibe help` | Show all commands |
| `/vibe gates` | Show quality gates status |
| `/vibe trace` | Show traceability matrix |
| `/vibe history` | Show completed features |

---

## Part 2: Change Classification Tiers

### 2.1 Four-Tier System

```
┌─────────────────────────────────────────────────────────────────┐
│  TIER 1: MINIMAL          (~5 min)                              │
│  ─────────────────                                              │
│  • Typo fixes, copy changes                                     │
│  • Simple styling tweaks                                        │
│  • Config value changes                                         │
│  • Comment updates                                              │
│                                                                 │
│  Process: Fix → Verify → Done                                   │
│  Gates: Lint only                                               │
│  Docs: Commit message only                                      │
├─────────────────────────────────────────────────────────────────┤
│  TIER 2: LIGHT            (~30 min)                             │
│  ─────────────────                                              │
│  • Bug fixes (non-critical)                                     │
│  • Small component additions                                    │
│  • Minor feature enhancements                                   │
│  • Refactoring (no behavior change)                             │
│                                                                 │
│  Process: Describe → Implement → Test → Done                    │
│  Gates: Lint + Tests + Basic functionality                      │
│  Docs: Brief summary in commit                                  │
├─────────────────────────────────────────────────────────────────┤
│  TIER 3: STANDARD         (~2-4 hours)                          │
│  ─────────────────                                              │
│  • New features (moderate complexity)                           │
│  • Significant bug fixes                                        │
│  • API additions/changes                                        │
│  • Database schema changes                                      │
│                                                                 │
│  Process: Spec → Approve → TDD → Review → Approve → Done        │
│  Gates: All 5 (prototype) or All 10 (production)                │
│  Docs: Spec + Feature doc                                       │
├─────────────────────────────────────────────────────────────────┤
│  TIER 4: FULL             (~1-3 days)                           │
│  ─────────────────                                              │
│  • Major features / epics                                       │
│  • Architecture changes                                         │
│  • Security-critical features                                   │
│  • Features spanning multiple systems                           │
│                                                                 │
│  Process: Full 5-phase with all stops                           │
│  Gates: All gates + security review + architecture review       │
│  Docs: Full spec + review + feature doc + ADR                   │
└─────────────────────────────────────────────────────────────────┘

SPECIAL: EMERGENCY (Hotfix)
──────────────────────────
• Production is broken
• Security vulnerability
• Data loss risk

Process: Fix → Test → Deploy → Post-mortem (after)
Gates: Critical path only
Docs: Post-mortem required within 24h
```

### 2.2 Tier Comparison Matrix

| Aspect | Minimal | Light | Standard | Full |
|--------|---------|-------|----------|------|
| Spec required | No | No | Yes (brief) | Yes (full) |
| Acceptance criteria | No | Informal | Given/When/Then | Given/When/Then |
| TDD required | No | Recommended | Yes | Yes |
| Traceability matrix | No | No | Yes | Yes |
| Quality gates | 1 | 3 | 5 or 10 | All + extras |
| User approval points | 0 | 1 (end) | 2 | 3+ |
| Review document | No | No | Brief | Full |
| Feature documentation | No | No | Yes | Yes + ADR |
| Estimated time | 5 min | 30 min | 2-4 hrs | 1-3 days |

---

## Part 3: Smart Auto-Detection Rules

### 3.1 Detection Algorithm

Claude analyzes the request and auto-classifies based on signals:

```yaml
# Auto-detection scoring system
signals:
  minimal_indicators:
    - keywords: [typo, spelling, copy, text, label, wording, comment]
    - keywords: [color, padding, margin, spacing, font, size]
    - keywords: [config, env, constant, value]
    - patterns: ["change X to Y", "rename", "update text"]
    - file_scope: single_file
    - estimated_lines: < 10

  light_indicators:
    - keywords: [fix, bug, broken, not working, error]
    - keywords: [add, include, show, display, hide]
    - keywords: [refactor, clean, improve, optimize]
    - keywords: [component, button, input, form field]
    - file_scope: 1-3 files
    - estimated_lines: 10-100

  standard_indicators:
    - keywords: [feature, functionality, implement, create]
    - keywords: [api, endpoint, database, schema, migration]
    - keywords: [authentication, authorization, payment]
    - keywords: [integration, third-party, external]
    - file_scope: 3-10 files
    - estimated_lines: 100-500
    - has_api_changes: true
    - has_db_changes: true

  full_indicators:
    - keywords: [epic, major, architecture, system, redesign]
    - keywords: [security, encryption, compliance, audit]
    - keywords: [migration, breaking change, v2]
    - file_scope: 10+ files
    - estimated_lines: 500+
    - crosses_system_boundaries: true
    - breaking_change: true

  emergency_indicators:
    - keywords: [urgent, emergency, production down, critical]
    - keywords: [security vulnerability, data breach, exploit]
    - keywords: [hotfix, asap, immediately]
```

### 3.2 Detection Output

When Claude detects the tier, it confirms with the user:

```
📊 CHANGE ANALYSIS
─────────────────
Request: "Fix the login button not working on mobile"

Detected Tier: LIGHT
Reasoning:
  • Contains "fix" + "not working" (bug indicators)
  • Single component scope (login button)
  • Platform-specific issue (mobile)
  • Estimated: 1-2 files, ~20-50 lines

Proposed Process:
  1. Investigate issue
  2. Implement fix
  3. Test on mobile viewports
  4. Quick review

Time estimate: ~30 minutes

[Proceed with LIGHT process?] or say "/v --standard" to upgrade
```

### 3.3 User Override

User can always override:

```
User: /v fix the login button not working
Claude: Detected as LIGHT tier...

User: /v --standard
Claude: Upgraded to STANDARD. Creating specification...
```

---

## Part 4: Streamlined Processes by Tier

### 4.1 MINIMAL Process

```
┌─────────────────────────────────────────┐
│           MINIMAL WORKFLOW              │
│                                         │
│   User Request                          │
│        ↓                                │
│   [Claude confirms understanding]       │
│        ↓                                │
│   Make Change                           │
│        ↓                                │
│   Run Linter                            │
│        ↓                                │
│   Show Diff to User                     │
│        ↓                                │
│   DONE (user can request commit)        │
│                                         │
│   Total stops: 0                        │
│   Total time: ~5 min                    │
└─────────────────────────────────────────┘
```

**Output Format (Minimal):**
```
✅ CHANGE COMPLETE

Changed: src/components/Button.tsx (line 42)
- label="Sumbit"
+ label="Submit"

Lint: ✅ Passed

Ready to commit? Say "/v commit" or continue working.
```

### 4.2 LIGHT Process

```
┌─────────────────────────────────────────┐
│            LIGHT WORKFLOW               │
│                                         │
│   User Request                          │
│        ↓                                │
│   [Claude explains approach]            │
│        ↓                                │
│   Implement (with basic tests)          │
│        ↓                                │
│   Run Tests + Lint                      │
│        ↓                                │
│   Quick Functionality Check             │
│        ↓                                │
│   Present Summary                       │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP: User Approval   ║            │
│   ══════════════════════════            │
│        ↓                                │
│   DONE                                  │
│                                         │
│   Total stops: 1                        │
│   Total time: ~30 min                   │
└─────────────────────────────────────────┘
```

**Output Format (Light):**
```
✅ FIX COMPLETE: Mobile Login Button

WHAT WAS FIXED:
Login button was not responding to touch events on iOS Safari
due to missing touch-action CSS property.

CHANGES MADE:
• src/components/LoginButton.tsx - Added touch-action: manipulation
• src/styles/buttons.css - Added mobile touch styles

TESTS:
• ✅ Existing tests pass (12/12)
• ✅ Added: LoginButton responds to touch events

VERIFIED:
• ✅ Lint passed
• ✅ Works on 375px viewport
• ✅ Works on 768px viewport

AWAITING APPROVAL - Say "/v approve" to proceed
```

### 4.3 STANDARD Process

```
┌─────────────────────────────────────────┐
│          STANDARD WORKFLOW              │
│                                         │
│   User Request                          │
│        ↓                                │
│   Create Brief Spec                     │
│   (Inline, not separate file)           │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP 1: Approve Spec  ║            │
│   ══════════════════════════            │
│        ↓                                │
│   TDD Implementation                    │
│   (Red → Green → Blue)                  │
│        ↓                                │
│   Run All Quality Gates                 │
│        ↓                                │
│   Present Feature                       │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP 2: Final Approval║            │
│   ══════════════════════════            │
│        ↓                                │
│   Generate Brief Docs                   │
│        ↓                                │
│   DONE                                  │
│                                         │
│   Total stops: 2                        │
│   Total time: 2-4 hours                 │
└─────────────────────────────────────────┘
```

**Inline Spec Format (Standard):**
```
📋 FEATURE SPEC: Add Password Reset

GOAL: Allow users to reset forgotten passwords via email

ACCEPTANCE CRITERIA:
┌────────────────────────────────────────────────────────┐
│ AC-1: Request Reset                                    │
│ GIVEN user is on login page                            │
│ WHEN they click "Forgot Password"                      │
│ AND enter their email                                  │
│ THEN they see confirmation message                     │
│ AND receive email within 2 minutes                     │
├────────────────────────────────────────────────────────┤
│ AC-2: Reset Link                                       │
│ GIVEN user received reset email                        │
│ WHEN they click the reset link                         │
│ THEN they see password reset form                      │
│ AND link expires after 1 hour                          │
├────────────────────────────────────────────────────────┤
│ AC-3: Set New Password                                 │
│ GIVEN user is on reset form                            │
│ WHEN they enter valid new password (2x)                │
│ THEN password is updated                               │
│ AND they are redirected to login                       │
│ AND old sessions are invalidated                       │
└────────────────────────────────────────────────────────┘

TECHNICAL APPROACH:
• New API endpoint: POST /api/auth/reset-password
• Token stored in Redis with 1hr TTL
• Email sent via existing SendGrid integration

APPROVE SPEC? Say "/v approve" to proceed with implementation
```

### 4.4 FULL Process

```
┌─────────────────────────────────────────┐
│            FULL WORKFLOW                │
│                                         │
│   User Request                          │
│        ↓                                │
│   Create Full Spec Document             │
│   (Saved to docs/specs/)                │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP 1: Approve Spec  ║            │
│   ══════════════════════════            │
│        ↓                                │
│   Create Test Plan                      │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP 2: Approve Tests ║            │
│   ══════════════════════════            │
│        ↓                                │
│   TDD Implementation                    │
│   (With progress updates)               │
│        ↓                                │
│   Run ALL Quality Gates                 │
│        ↓                                │
│   Create Review Document                │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP 3: Final Review  ║            │
│   ══════════════════════════            │
│        ↓                                │
│   Generate Full Documentation           │
│        ↓                                │
│   DONE                                  │
│                                         │
│   Total stops: 3                        │
│   Total time: 1-3 days                  │
└─────────────────────────────────────────┘
```

### 4.5 EMERGENCY Process

```
┌─────────────────────────────────────────┐
│         EMERGENCY WORKFLOW              │
│                                         │
│   "/v hotfix <description>"             │
│        ↓                                │
│   [Claude acknowledges emergency]       │
│        ↓                                │
│   Rapid Investigation                   │
│        ↓                                │
│   Implement Minimal Fix                 │
│        ↓                                │
│   Critical Tests Only                   │
│        ↓                                │
│   Show Fix + Verify                     │
│        ↓                                │
│   ══════════════════════════            │
│   ║  STOP: Deploy Approval ║            │
│   ══════════════════════════            │
│        ↓                                │
│   DEPLOYED                              │
│        ↓                                │
│   ⚠️  POST-MORTEM SCHEDULED             │
│   (Required within 24 hours)            │
│                                         │
│   Total stops: 1                        │
│   Total time: ASAP                      │
└─────────────────────────────────────────┘
```

---

## Part 5: Workflow State Tracking

### 5.1 State File Structure

Create `.vibe/state.yaml` to track current workflow:

```yaml
# .vibe/state.yaml - Auto-generated, do not edit manually

current_workflow:
  id: "wf-2024-001"
  started: "2024-01-15T10:30:00Z"
  tier: "standard"
  command: "/v feature add password reset"
  phase: "implementation"

  spec:
    status: "approved"
    approved_at: "2024-01-15T10:45:00Z"
    criteria_count: 3

  implementation:
    status: "in_progress"
    criteria_completed: 1
    criteria_total: 3
    current_criterion: "AC-2"

  tests:
    written: 5
    passing: 4
    failing: 1

  gates:
    lint: "passed"
    tests: "pending"
    functionality: "pending"
    responsive: "not_started"
    ux: "not_started"

history:
  - id: "wf-2024-000"
    feature: "User login"
    tier: "standard"
    completed: "2024-01-14T16:00:00Z"
    commit: "abc123"

paused_workflows: []
```

### 5.2 Status Display

When user says `/v status`:

```
📊 WORKFLOW STATUS
══════════════════════════════════════════════════

Feature: Password Reset
Tier: STANDARD
Started: 2 hours ago

PROGRESS:
┌──────────────────────────────────────────────┐
│ ✅ Spec          │ Approved                  │
│ 🔄 Implementation │ AC-2 of 3 (67%)          │
│ ⏳ Review         │ Waiting                   │
│ ⏳ Approval       │ Waiting                   │
└──────────────────────────────────────────────┘

ACCEPTANCE CRITERIA:
  ✅ AC-1: Request Reset - IMPLEMENTED + TESTED
  🔄 AC-2: Reset Link - IN PROGRESS
  ⏳ AC-3: Set New Password - PENDING

QUALITY GATES:
  ✅ Lint        ⏳ Tests       ⏳ Functionality
  ⏳ Responsive  ⏳ UX

NEXT ACTION: Complete AC-2 implementation

══════════════════════════════════════════════════
```

---

## Part 6: Improved File Structure

### 6.1 New Directory Structure

```
project/
├── .vibe/                          # NEW: Workflow state (gitignored)
│   ├── state.yaml                  # Current workflow state
│   ├── history.yaml                # Completed workflows
│   └── .gitkeep
│
├── CLAUDE.md                       # Simplified, links to config
│
├── config/
│   ├── vibe.config.yaml            # RENAMED: Main config
│   ├── commands.yaml               # NEW: Command definitions
│   ├── tiers.yaml                  # NEW: Tier definitions
│   ├── detection.yaml              # NEW: Auto-detection rules
│   └── gates.yaml                  # NEW: Quality gate definitions
│
├── docs/
│   ├── README.md                   # Documentation hub
│   ├── COMMANDS.md                 # NEW: Command reference
│   ├── specs/                      # Only for FULL tier
│   ├── reviews/                    # Only for FULL tier
│   ├── features/                   # Generated docs
│   └── bugs/                       # Post-mortems
│
└── scripts/
    ├── init-vibe.sh                # RENAMED: Project init
    └── vibe-doctor.sh              # NEW: Diagnose workflow issues
```

### 6.2 Simplified Config Files

**config/vibe.config.yaml** (simplified main config):
```yaml
# Vibecoding Workflow Configuration
version: "2.0"

project:
  name: "My Project"
  type: web                         # web | mobile | backend | fullstack | cli
  approach: prototype               # prototype | production

# Tier behavior (can customize thresholds)
tiers:
  default: auto                     # auto | minimal | light | standard | full
  allow_override: true

# Quality gates
gates:
  mode: prototype                   # prototype (5 gates) | production (10 gates)

# Git
git:
  auto_commit: false
  auto_push: false
  conventional_commits: true

# See config/tiers.yaml for tier customization
# See config/gates.yaml for gate customization
# See config/commands.yaml for command customization
```

---

## Part 7: Improved CLAUDE.md

### 7.1 New CLAUDE.md Structure

The new CLAUDE.md should be:
1. **Shorter** - Link to config files instead of duplicating
2. **Command-focused** - Emphasize the command interface
3. **Smart** - Include detection logic inline

See next section for full CLAUDE.md rewrite.

---

## Part 8: Implementation Phases

### Phase 1: Core Command System (Priority: HIGH)
- [ ] Define all commands in `config/commands.yaml`
- [ ] Rewrite CLAUDE.md with command recognition
- [ ] Implement tier detection logic
- [ ] Create state tracking system

### Phase 2: Tier Workflows (Priority: HIGH)
- [ ] Define each tier's process in `config/tiers.yaml`
- [ ] Create output templates for each tier
- [ ] Implement phase transitions

### Phase 3: Quality Gates (Priority: MEDIUM)
- [ ] Refactor gates into `config/gates.yaml`
- [ ] Create CI workflow examples
- [ ] Add gate automation suggestions

### Phase 4: User Experience (Priority: MEDIUM)
- [ ] Create `/v help` output
- [ ] Create `/v status` display
- [ ] Add progress indicators
- [ ] Improve approval prompts

### Phase 5: Documentation (Priority: LOW)
- [ ] Rewrite docs/COMMANDS.md
- [ ] Update README.md
- [ ] Create migration guide from v1

---

## Part 9: Example User Sessions

### Example 1: Minimal Change

```
User: /v fix typo in the header - "Welcom" should be "Welcome"

Claude: 📊 Detected: MINIMAL (typo fix)

Making change...

✅ DONE

Changed: src/components/Header.tsx (line 12)
- <h1>Welcom to Our App</h1>
+ <h1>Welcome to Our App</h1>

Lint: ✅ Passed

Say "/v commit" when ready.
```

### Example 2: Light Fix

```
User: /v fix the dropdown menu not closing when clicking outside

Claude: 📊 Detected: LIGHT (bug fix)

Investigating...
Found: DropdownMenu.tsx missing click-outside handler.

Implementing fix with test...

✅ FIX COMPLETE

CHANGES:
• src/components/DropdownMenu.tsx - Added useClickOutside hook
• src/hooks/useClickOutside.ts - Created new hook
• src/__tests__/DropdownMenu.test.tsx - Added close-on-outside test

TESTS: ✅ All passing (8/8)
LINT: ✅ Passed

AWAITING APPROVAL - "/v approve"
```

### Example 3: Standard Feature

```
User: /v feature add dark mode toggle

Claude: 📊 Detected: STANDARD (new feature)

Creating specification...

📋 FEATURE SPEC: Dark Mode Toggle
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GOAL: Allow users to switch between light and dark themes

ACCEPTANCE CRITERIA:

AC-1: Toggle Visibility
GIVEN user is on any page
WHEN page loads
THEN they see a theme toggle in the header

AC-2: Theme Switching
GIVEN user clicks the toggle
WHEN current theme is light
THEN theme changes to dark
AND preference is saved to localStorage

AC-3: Persistence
GIVEN user has set dark mode
WHEN they refresh or revisit
THEN dark mode is still active

AC-4: System Preference
GIVEN user has not set preference
WHEN their OS prefers dark mode
THEN app defaults to dark mode

TECHNICAL APPROACH:
• React Context for theme state
• CSS custom properties for colors
• localStorage for persistence
• prefers-color-scheme media query

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
APPROVE SPEC? "/v approve" to proceed

User: /v approve

Claude: ✅ Spec approved. Starting TDD implementation...

[Implementation proceeds...]
```

### Example 4: Emergency Hotfix

```
User: /v hotfix users can't login - getting 500 error

Claude: 🚨 EMERGENCY WORKFLOW ACTIVATED

Investigating immediately...

Found: Database connection pool exhausted.
Cause: Connection leak in UserService.findById()

Implementing minimal fix...

✅ HOTFIX READY

FIX: Added connection.release() in finally block
FILE: src/services/UserService.ts (line 45)

CRITICAL TEST: ✅ Login flow works

⚠️  This is a minimal fix. Full investigation required.

DEPLOY NOW? "/v approve" to deploy

[After deployment]

⚠️  POST-MORTEM REQUIRED
Please run "/v postmortem" within 24 hours to document:
• Root cause analysis
• Prevention measures
• Monitoring improvements
```

---

## Summary

The improved workflow provides:

1. **Simple Commands** - `/v fix`, `/v feature`, `/v approve`
2. **Smart Detection** - Auto-classifies changes by complexity
3. **Scaled Ceremony** - 4 tiers from minimal (5 min) to full (days)
4. **Clear Feedback** - Always shows tier, progress, next action
5. **User Control** - Override detection, skip phases, pause/resume
6. **State Tracking** - Know where you are, what's next
7. **Faster Flow** - Small changes don't need full process

The goal: **Make the right thing the easy thing.**
