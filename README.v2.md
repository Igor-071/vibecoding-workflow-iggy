# Vibecoding Workflow 2.0

> **Smart, Adaptive AI-Assisted Development**
> The right amount of process for every change.

## What's New in 2.0

- **Command System** - Simple commands like `/v fix` and `/v feature`
- **Smart Detection** - Claude auto-detects how much ceremony you need
- **Four Tiers** - From 5-minute fixes to multi-day epics
- **Inline Specs** - No separate files for standard features
- **State Tracking** - Always know where you are in the workflow

## Quick Start

### 1. Clone the template

```bash
git clone https://github.com/Igor-071/vibecoding-workflow-iggy.git my-project
cd my-project
./scripts/init-project.sh
```

### 2. Start working with Claude

```bash
# Quick fix
/v fix typo in header

# New feature
/v feature add dark mode toggle

# Major epic
/v epic implement payment processing
```

### 3. Let Claude guide you

Claude detects the right tier and walks you through the process:

```
User: /v feature add user profile editing

Claude: 📊 Detected: STANDARD (new feature)

📋 FEATURE SPEC: User Profile Editing
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GOAL: Allow users to edit their profile info

ACCEPTANCE CRITERIA:
┌─────────────────────────────────────┐
│ AC-1: Access profile page           │
│ GIVEN logged-in user                │
│ WHEN they click "Profile"           │
│ THEN they see edit form             │
└─────────────────────────────────────┘

APPROVE SPEC? "/v approve"

User: /v approve

Claude: ✅ Implementing with TDD...
[progress updates]

✅ FEATURE COMPLETE
AWAITING APPROVAL

User: looks good

Claude: ✅ Approved!
Doc generated: docs/features/user-profile-editing.md
Say "/v commit" when ready.
```

## The Tier System

| Tier | Command | Time | Use For |
|------|---------|------|---------|
| ⚡ Minimal | `/v fix` | ~5 min | Typos, config changes |
| 🔧 Light | `/v fix`, `/v add` | ~30 min | Bug fixes, small additions |
| 📋 Standard | `/v feature` | ~2-4 hrs | New features |
| 📚 Full | `/v epic` | ~1-3 days | Major features |
| 🚨 Emergency | `/v hotfix` | ASAP | Production is down |

### Tier Comparison

```
MINIMAL     Fix → Done (no approval needed)
LIGHT       Fix → Test → Approve → Done
STANDARD    Spec → Approve → TDD → Review → Approve → Docs → Done
FULL        Spec → Approve → Plan → Approve → TDD → Review → Approve → Docs → Done
EMERGENCY   Fix → Deploy → Post-mortem (within 24h)
```

## Essential Commands

### Starting Work

```bash
/v fix <description>       # Quick fixes, typos
/v add <description>       # Small additions
/v feature <description>   # New features
/v epic <description>      # Major features
/v hotfix <description>    # Production emergencies
```

### During Work

```bash
/v status                  # Where am I?
/v approve                 # Move to next phase
/v skip                    # Skip a phase (with reason)
/v pause                   # Save and pause workflow
/v resume                  # Continue paused workflow
```

### Finishing

```bash
/v commit                  # Create git commit
/v ship                    # Approve + commit + push
```

### Override Tier

```bash
/v feature --light "add tooltip"    # Downgrade
/v fix --standard "auth bug"        # Upgrade
```

## Repository Structure

```
.
├── CLAUDE.md                    # AI instructions (start here)
├── README.md                    # You are here
│
├── config/
│   ├── vibe.config.yaml         # Main configuration
│   ├── commands.yaml            # Command definitions
│   ├── tiers.yaml               # Tier process definitions
│   ├── detection.yaml           # Auto-detection rules
│   └── gates.yaml               # Quality gate definitions
│
├── docs/
│   ├── COMMANDS.md              # Command reference
│   ├── UPGRADE_TO_V2.md         # Migration guide
│   ├── METHODOLOGY.md           # Philosophy
│   ├── specs/                   # Full tier specs only
│   ├── features/                # Generated documentation
│   └── bugs/                    # Post-mortems
│
├── .vibe/
│   └── state.yaml               # Workflow state (gitignored)
│
└── scripts/
    └── init-project.sh          # Project setup
```

## Quality Gates

### Prototype Mode (5 gates)

| Gate | Check |
|------|-------|
| Lint | Code passes linting |
| Tests | All tests pass |
| Functionality | Acceptance criteria met |
| Responsive | Works 320px - 1440px |
| UX | Matches design system |

### Production Mode (10 gates)

All prototype gates plus:

| Gate | Check |
|------|-------|
| Performance | Lighthouse > 90 |
| Accessibility | WCAG 2.1 AA |
| Browser | Chrome, Safari, Firefox |
| Integration | APIs work correctly |
| Security | No XSS, injection, etc. |

## Acceptance Criteria Format

Always use Given/When/Then:

```gherkin
AC-1: Successful login
GIVEN a registered user on login page
WHEN they enter valid credentials
AND click "Sign In"
THEN they are redirected to dashboard
AND see welcome message
```

## Examples

### Example 1: Typo Fix (Minimal)

```
User: /v fix typo "recieve" should be "receive" in checkout

Claude: ✅ DONE
Changed: src/components/Checkout.tsx (line 45)
- <p>You will recieve an email</p>
+ <p>You will receive an email</p>
Lint: ✅
"/v commit" when ready.

User: /v commit

Claude: ✅ Committed: fix(checkout): correct typo in confirmation message
```

### Example 2: Bug Fix (Light)

```
User: /v fix the dropdown closes when clicking inside it

Claude: 📊 Detected: LIGHT (bug fix)

Investigating...
Found: Click event bubbling to parent

Implementing fix...

✅ FIX COMPLETE: Dropdown Click Handling

CHANGES:
• Dropdown.tsx - Added e.stopPropagation()
• Added test for click behavior

TESTS: ✅ 12/12 passing
AWAITING APPROVAL

User: /v approve

Claude: ✅ Approved. "/v commit" when ready.
```

### Example 3: New Feature (Standard)

```
User: /v feature add dark mode toggle

Claude: 📊 Detected: STANDARD (new feature)

📋 FEATURE SPEC: Dark Mode Toggle
[spec with acceptance criteria]

APPROVE SPEC? "/v approve"

User: looks good

Claude: ✅ Spec approved. Starting TDD...

[implements AC-1]
[implements AC-2]
[implements AC-3]
[runs quality gates]

✅ FEATURE COMPLETE: Dark Mode Toggle

### Acceptance Criteria
| AC | Description | Status |
|----|-------------|--------|
| 1 | Toggle visible | ✅ |
| 2 | Theme switches | ✅ |
| 3 | Persists | ✅ |

### Quality Gates
✅ All 5 gates passed

AWAITING APPROVAL

User: ship it

Claude: ✅ Approved!
📄 Generated: docs/features/dark-mode-toggle.md
✅ Committed: feat(theme): add dark mode toggle
✅ Pushed to origin
```

## Configuration

### vibe.config.yaml

```yaml
version: "2.0"

project:
  name: "My Project"
  type: web
  approach: prototype  # or production

tiers:
  default: auto        # auto-detect

gates:
  mode: prototype      # 5 gates (or production for 10)

git:
  auto_commit: false
  conventional_commits: true
```

## Adding to Existing Projects

```bash
# Copy workflow files
cp -r config/ your-project/
cp -r docs/COMMANDS.md your-project/docs/
cp CLAUDE.md your-project/
mkdir -p your-project/.vibe

# Update your .gitignore
echo ".vibe/*" >> your-project/.gitignore
echo "!.vibe/.gitkeep" >> your-project/.gitignore
```

## Philosophy

1. **Right-sized ceremony** - Typos don't need specs. Major features do.
2. **Human in control** - Claude proposes, you approve.
3. **Quality built in** - TDD and gates ensure reliability.
4. **Fast feedback** - Minimal overhead for small changes.
5. **Documentation when needed** - Auto-generated, not mandatory busywork.

## Critical Rules

**NEVER:**
- Skip approval at tier stop points
- Auto-commit without user request
- Force full process on trivial changes
- Skip post-mortems for hotfixes

**ALWAYS:**
- Let Claude detect the appropriate tier
- Allow user to override detection
- Use Given/When/Then for acceptance criteria
- Generate docs when features are approved

## Documentation

| Document | Purpose |
|----------|---------|
| [COMMANDS.md](docs/COMMANDS.md) | Command reference |
| [UPGRADE_TO_V2.md](docs/UPGRADE_TO_V2.md) | Migration from v1 |
| [METHODOLOGY.md](docs/METHODOLOGY.md) | Philosophy |

## License

MIT License - See [LICENSE](LICENSE)

---

**Vibecoding 2.0** - *The right amount of process for every change.*
