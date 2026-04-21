# Vibecoding Workflow 2.0 - Command Reference

> Quick reference for all workflow commands

---

## Command Prefix

All commands use `/vibe` or `/v` (shorthand):

```
/vibe <command> [options] <description>
/v <command> [options] <description>
```

---

## Change Commands

Start work with implied ceremony level:

| Command | Alias | Tier | Description |
|---------|-------|------|-------------|
| `/vibe fix` | `/v fix` | ⚡ Minimal | Typos, small corrections |
| `/vibe tweak` | `/v tweak` | ⚡ Minimal | Styling adjustments |
| `/vibe update` | `/v update` | 🔧 Light | Update existing feature |
| `/vibe add` | `/v add` | 🔧 Light | Add small component |
| `/vibe refactor` | `/v refac` | 🔧 Light | Code cleanup |
| `/vibe feature` | `/v feat` | 📋 Standard | New feature |
| `/vibe epic` | `/v epic` | 📚 Full | Major feature |
| `/vibe hotfix` | `/v hot` | 🚨 Emergency | Production fix |

### Examples

```bash
/v fix typo in header                    # Minimal - just do it
/v fix login button broken               # Light - investigate & fix
/v add loading spinner to submit button  # Light - small addition
/v feature user profile editing          # Standard - full process
/v epic payment processing system        # Full - comprehensive process
/v hotfix users can't login              # Emergency - fix now, document later
```

---

## Tier Override Flags

Override auto-detected tier:

| Flag | Short | Effect |
|------|-------|--------|
| `--minimal` | `-m` | Force minimal tier |
| `--light` | `-l` | Force light tier |
| `--standard` | `-s` | Force standard tier |
| `--full` | `-f` | Force full tier |

### Examples

```bash
/v feature --light "add tooltip"      # Downgrade: feature but keep it light
/v fix --standard "auth session bug"  # Upgrade: bug needs full process
/v add --with-spec "payment form"     # Add spec even for light tier
```

---

## Workflow Control

| Command | Alias | Description |
|---------|-------|-------------|
| `/vibe status` | `/v status` | Show current workflow state |
| `/vibe approve` | `/v approve` | Approve current phase |
| `/vibe reject` | `/v reject` | Request changes |
| `/vibe skip` | `/v skip` | Skip a phase (needs confirmation) |
| `/vibe pause` | `/v pause` | Pause workflow, save state |
| `/vibe resume` | `/v resume` | Resume paused workflow |
| `/vibe abort` | `/v abort` | Abandon current workflow |
| `/vibe restart` | `/v restart` | Restart current phase |

### Approval Shortcuts

These natural phrases also trigger approval:
- "looks good"
- "approved"
- "green light"
- "ship it"
- "proceed"
- "lgtm"

### Rejection Shortcuts

These phrases trigger rejection/revision request:
- "needs changes"
- "not yet"
- "wait"
- "actually..."

---

## Git Commands

| Command | Alias | Description |
|---------|-------|-------------|
| `/vibe commit` | `/v commit` | Create git commit |
| `/vibe push` | `/v push` | Push to remote |
| `/vibe ship` | `/v ship` | Approve + Commit + Push |

### Examples

```bash
/v commit                    # Claude proposes commit message
/v push                      # Push current commits
/v ship                      # All-in-one: approve, commit, push
```

---

## Query Commands

| Command | Alias | Description |
|---------|-------|-------------|
| `/vibe help` | `/v help` | Show all commands |
| `/vibe gates` | `/v gates` | Show quality gates status |
| `/vibe trace` | `/v trace` | Show traceability matrix |
| `/vibe history` | `/v history` | Show completed workflows |
| `/vibe config` | `/v config` | Show current configuration |

---

## Documentation Commands

| Command | Alias | Description |
|---------|-------|-------------|
| `/vibe spec` | `/v spec` | Show or create specification |
| `/vibe review` | `/v review` | Show or create review doc |
| `/vibe postmortem` | `/v postmortem` | Create bug post-mortem |

### Examples

```bash
/v spec                      # Show current spec
/v spec user-auth            # Show specific spec
/v postmortem                # Start post-mortem for last hotfix
```

---

## Tier Reference

| Tier | Emoji | Time | Stops | Use For |
|------|-------|------|-------|---------|
| Minimal | ⚡ | ~5 min | 0 | Typos, config, simple CSS |
| Light | 🔧 | ~30 min | 1 | Bug fixes, small additions |
| Standard | 📋 | ~2-4 hrs | 2 | New features, API changes |
| Full | 📚 | ~1-3 days | 3+ | Major features, architecture |
| Emergency | 🚨 | ASAP | 1 | Production is broken |

---

## Quick Workflows

### Typo Fix (Minimal)
```
/v fix typo "teh" should be "the" in Header.tsx
→ Claude fixes immediately
→ "/v commit" when ready
```

### Bug Fix (Light)
```
/v fix button doesn't work on mobile
→ Claude investigates, fixes, tests
→ Presents fix for approval
→ "/v approve"
→ "/v commit"
```

### New Feature (Standard)
```
/v feature add dark mode
→ Claude creates spec
→ "/v approve" (spec)
→ Claude implements with TDD
→ Claude runs quality gates
→ "/v approve" (final)
→ Claude generates docs
→ "/v commit"
```

### Emergency Fix (Hotfix)
```
/v hotfix login broken
→ Claude investigates rapidly
→ Claude implements minimal fix
→ "/v approve" to deploy
→ Post-mortem due in 24h
```

---

## Command Cheatsheet

```
STARTING WORK
─────────────
/v fix <desc>       Quick fix
/v add <desc>       Small addition
/v feat <desc>      New feature
/v hot <desc>       Emergency

DURING WORK
───────────
/v status           Where am I?
/v approve          Move forward
/v reject           Request changes
/v pause            Take a break

FINISHING
─────────
/v commit           Save work
/v ship             All done!

HELP
────
/v help             This reference
/v gates            Quality status
```

---

## Tips

1. **Let Claude detect the tier** - It's usually right
2. **Override when needed** - Use `--light` or `--standard` flags
3. **Use natural language** - "looks good" works like `/v approve`
4. **Check status often** - `/v status` shows where you are
5. **Don't skip post-mortems** - They prevent future emergencies

---

*For full documentation, see [CLAUDE.md](../CLAUDE.md)*
