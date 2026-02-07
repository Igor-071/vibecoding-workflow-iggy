# Vibecoding Workflow v2

A lean, tool-enforced AI development workflow. Built for speed and quality.

## Philosophy

> Documentation tells Claude what to do. Hooks **make** it happen.

v1 relied on a 200-line CLAUDE.md that Claude would partially follow. v2 uses:

- **30-line CLAUDE.md** — Only rules Claude must always know
- **Skills** — Methodology loaded on-demand, not ignored in bulk
- **Hooks** — Deterministic enforcement (lint, test) with zero human effort
- **MCP Servers** — Real-time docs, GitHub integration, browser testing

## Quick Start

```bash
git clone <this-repo> my-project
cd my-project/v2
./scripts/setup.sh
claude
```

## Architecture

```
v2/
├── CLAUDE.md                      # 30 lines. Commands + critical rules.
├── .mcp.json                      # MCP server configuration
├── .claude/
│   ├── settings.json              # Hooks + permissions
│   └── skills/
│       ├── spec/SKILL.md          # How to write specs (on-demand)
│       ├── implement/SKILL.md     # TDD methodology (on-demand)
│       ├── review/SKILL.md        # Quality gates (on-demand)
│       ├── bug/SKILL.md           # Bug analysis (on-demand)
│       └── ship/SKILL.md          # Commit/PR/deploy (on-demand)
├── docs/
│   ├── specs/                     # Feature specifications
│   ├── reviews/                   # Quality reviews
│   ├── features/                  # Auto-generated feature docs
│   └── bugs/                      # Bug post-mortems
├── .github/
│   └── PULL_REQUEST_TEMPLATE.md   # PR checklist
└── scripts/
    └── setup.sh                   # One-command project init
```

## How It Works

### You say: "Build me a login page"

**Step 1: Spec** (skill: `spec/`)
Claude creates `docs/specs/login-page.md` with Given/When/Then acceptance criteria. Stops. Waits for your approval.

**Step 2: Implement** (skill: `implement/`)
After you approve, Claude follows TDD — failing test first, minimal code to pass, refactor. For each acceptance criterion. Uses `context7` for current framework docs.

**Step 3: Review** (skill: `review/`)
Claude runs all quality gates (tests, lint, responsive, code review). Reports pass/fail.

**Step 4: Ship** (skill: `ship/`)
When you say "commit" or "create PR", Claude uses conventional commits and creates a PR with full checklist.

**Throughout:** Hooks auto-lint every file write. Tests run before every commit. No manual enforcement needed.

## MCP Servers

| Server | What It Does | Why |
|--------|-------------|-----|
| **Context7** | Injects current framework/library docs | No more hallucinated APIs |
| **GitHub** | Issues, PRs, code search, Actions | No more copy-pasting URLs |
| **Playwright** | Browser automation + screenshots | Real responsive testing |
| **Sequential Thinking** | Structured reasoning chains | Better architecture decisions |
| **Memory** | Persistent knowledge graph | Claude remembers across sessions |

### Setup

Context7, Playwright, Sequential Thinking, and Memory work out of the box.

For GitHub MCP, set your token:
```bash
export GITHUB_TOKEN=ghp_your_token_here
```

## Hooks

Configured in `.claude/settings.json`. These are **deterministic** — they run automatically, not by suggestion.

| Hook | Trigger | Action |
|------|---------|--------|
| PostToolUse | Every file write/edit | Auto-lint JS/TS files |
| PreCommit | Every commit attempt | Run lint + full test suite |

## v1 vs v2 Comparison

| Aspect | v1 | v2 |
|--------|----|----|
| CLAUDE.md | 200 lines | 30 lines |
| Enforcement | Documentation (advisory) | Hooks (deterministic) |
| Framework docs | Training data (stale) | Context7 (real-time) |
| Methodology | Always loaded (ignored) | Skills (on-demand) |
| Personas | Alex + Priya (roleplay) | Behaviors encoded directly |
| Git integration | Manual `gh` commands | GitHub MCP |
| Responsive testing | Self-reported | Playwright MCP |
| Init script | 200-line interactive bash | 60-line focused setup |
| Quality gates | Checklist in docs | Hooks + skills |

## Parallel Development

For maximum speed, run multiple Claude sessions on different features:

```bash
# Create worktrees for parallel work
git worktree add ../login-feature -b feat/login
git worktree add ../dashboard-feature -b feat/dashboard

# Run Claude in each (separate terminals)
cd ../login-feature && claude
cd ../dashboard-feature && claude

# Each session has its own branch, its own context
```

## Customization

### Change mode
Edit `CLAUDE.md` line 5: `prototype` or `production`

### Add MCP servers
Edit `.mcp.json` — add any server from [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers)

### Add hooks
Edit `.claude/settings.json` — add PostToolUse, PreCommit, or other hook types

### Add skills
Create `.claude/skills/[name]/SKILL.md` — Claude discovers and loads them automatically

## License

MIT
