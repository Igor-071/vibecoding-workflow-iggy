# Upgrading to Vibecoding Workflow 2.0

## What's New in v2

### 1. Command System
Instead of following rigid phases for every change, v2 uses commands:

```bash
# OLD (v1): Every change followed the same 5-phase process

# NEW (v2): Commands signal intent and ceremony level
/v fix typo in header          # Minimal - just do it
/v feature add dark mode       # Standard - full process
```

### 2. Smart Tier Detection
Claude automatically detects how much ceremony is needed:

```
User: Fix the login button
Claude: 📊 Detected: LIGHT (bug fix)
        Reasoning: "fix" keyword, single component

        [Proceed?] or override with "/v --standard"
```

### 3. Four Ceremony Tiers

| Tier | When | Time | Process |
|------|------|------|---------|
| ⚡ Minimal | Typos, tweaks | ~5 min | Fix → Done |
| 🔧 Light | Bug fixes | ~30 min | Fix → Test → Approve |
| 📋 Standard | New features | ~2-4 hrs | Spec → TDD → Review → Approve |
| 📚 Full | Major features | ~1-3 days | Full 5-phase with all docs |

### 4. Inline Specs (Standard Tier)
No more separate spec files for standard features:

```
📋 FEATURE SPEC: Dark Mode Toggle
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GOAL: Allow theme switching

ACCEPTANCE CRITERIA:
┌─────────────────────────────────┐
│ AC-1: Toggle visible in header  │
│ GIVEN user is on any page       │
│ WHEN page loads                 │
│ THEN toggle is visible          │
└─────────────────────────────────┘

APPROVE? "/v approve"
```

### 5. Workflow State Tracking
See where you are at any time:

```
/v status

📊 WORKFLOW STATUS
Feature: Dark Mode
Tier: STANDARD
Progress: AC-2 of 4 (50%)
Next: Complete implementation
```

### 6. Natural Language Approval
No need to remember exact commands:

```
# All of these work:
/v approve
"looks good"
"approved"
"ship it"
"lgtm"
```

---

## Migration Guide

### Step 1: Update Files

Replace your current config with v2 structure:

```
config/
├── vibe.config.yaml      # Renamed from workflow.config.yaml
├── commands.yaml         # NEW
├── tiers.yaml            # NEW
├── detection.yaml        # NEW
└── gates.yaml            # NEW (extracted from workflow.config.yaml)
```

### Step 2: Replace CLAUDE.md

1. Backup your current CLAUDE.md
2. Copy CLAUDE.v2.md to CLAUDE.md
3. Update project-specific settings at the top

### Step 3: Create State Directory

```bash
mkdir -p .vibe
touch .vibe/.gitkeep
```

### Step 4: Update .gitignore

Add:
```
# Workflow state
.vibe/*
!.vibe/.gitkeep
```

### Step 5: Learn the Commands

Start with these essential commands:
```
/v fix <desc>       # Quick fixes
/v feat <desc>      # New features
/v status           # Where am I?
/v approve          # Move forward
/v commit           # Save work
```

---

## Behavior Changes

### v1 → v2 Differences

| Scenario | v1 Behavior | v2 Behavior |
|----------|-------------|-------------|
| Typo fix | Full 5-phase process | Direct fix, lint, done |
| Bug fix | Full 5-phase process | Light: fix, test, approve |
| New feature | Full 5-phase process | Standard: spec, TDD, approve |
| Major epic | Full 5-phase process | Full: same as v1 |

### What Stays the Same

- Given/When/Then acceptance criteria
- TDD (Red/Green/Blue) for Standard+ tiers
- Quality gates (same 10 gates)
- Manual git control
- Conventional commits
- Post-mortems for emergencies

---

## FAQ

### Q: Can I still use the full process for everything?
Yes! Use `/v --full` or `/v epic` to get the complete 5-phase process.

### Q: What if Claude detects the wrong tier?
Override it: `/v --standard` or `/v --light`

### Q: Do I need to memorize all commands?
No. Natural language works too. "Fix the typo" and "/v fix the typo" behave the same.

### Q: Where are the personas (Alex Chen, Dr. Priya)?
They're still there in `config/personas.yaml` but less prominent. Claude switches roles automatically based on phase.

### Q: Can I customize the tiers?
Yes! Edit `config/tiers.yaml` to adjust processes, gates, and thresholds.

---

## Quick Reference

```
QUICK FIXES
───────────
/v fix <desc>           Typo, config change
/v tweak <desc>         Styling adjustment

BUG FIXES
─────────
/v fix <desc>           Auto-detects as Light
/v update <desc>        Update existing code

FEATURES
────────
/v feat <desc>          Standard feature
/v add <desc>           Small addition
/v epic <desc>          Major feature

CONTROL
───────
/v status               Where am I?
/v approve              Proceed
/v pause/resume         Take a break
/v commit               Save to git
/v ship                 Approve + commit + push

HELP
────
/v help                 Command reference
/v gates                Quality gate status
```

---

## Need Help?

- **Commands:** See `docs/COMMANDS.md`
- **Tiers:** See `config/tiers.yaml`
- **Gates:** See `config/gates.yaml`
- **Full Reference:** See `CLAUDE.md`
