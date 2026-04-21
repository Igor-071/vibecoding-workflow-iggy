# Vibecoding Workflow Template

A structured, AI-assisted development workflow for building high-quality software with precision.

## What is Vibecoding?

Vibecoding is a **Spec-Driven Development** methodology designed for AI-assisted development. It combines:

- **Spec-First Development** - Write detailed specifications before any code
- **BDD-style Acceptance Criteria** - Given/When/Then format for precision
- **Test-Driven Development** - Red-Green-Blue cycle for quality
- **Quality Gates** - 10 mandatory checks before delivery
- **Stop & Wait Protocol** - Human remains in control

## Quick Start

### 1. Clone this template

```bash
git clone https://github.com/Igor-071/vibecoding-workflow-iggy.git my-project
cd my-project
```

### 2. Run the initialization script

```bash
./scripts/init-project.sh
```

This will:
- Configure the project name and type
- Set up the tech stack
- Enable/disable relevant quality gates
- Prepare the CI workflow

### 3. Scaffold Next.js (if using Next.js)

```bash
./scripts/add-mop-foundation.sh
npm install
npm run dev
```

This pulls the latest [MOP Next.js foundation](https://github.com/ministryofprogramming/mop-foundation-nextjs)
into your project. Your workflow files (CLAUDE.md, .claude/, docs/, scripts/)
are never touched. Re-run any time to pull foundation updates.

> `init-project.sh` will offer this automatically when you select Next.js.

### 4. Start coding with Claude

Open the project in your IDE with Claude Code and start your first feature:

```
/spec
```

Type `/spec` to create a specification, `/implement` after it's approved,
`/review` when done. See the [Slash Commands](#slash-commands-skills) table below.

### 5. Upgrade to Production (when ready)

When your prototype is validated and you're ready for production:

```bash
./scripts/upgrade-to-production.sh
```

This will:
- Switch from 5 to 10 quality gates
- Optionally set up backend and database
- Create a transition checklist

## Adding to Existing Projects

Already have a project? You can adopt this workflow without starting over.

### What to Copy

```bash
# Copy workflow files to your existing project
cp -r config/ your-project/
cp -r docs/ your-project/
cp -r .github/ your-project/
cp CLAUDE.md your-project/
```

### Customize for Your Project

1. Edit `config/workflow.config.yaml` - Set your tech stack and project type
2. Edit `CLAUDE.md` - Update with your project's build/test commands
3. Review `.github/` templates - Adjust to match your workflow

### Adoption Strategy: New Features First

**Don't retrofit everything.** Instead:

- **New features** → Full workflow (spec → tests → implementation → review)
- **Bug fixes in old code** → Add spec + regression test for the fix only
- **Major changes to old code** → Write spec for the changed parts

This lets you prove the workflow's value before asking for full codebase adoption. Over time, more code gets covered naturally.

See [METHODOLOGY.md](docs/METHODOLOGY.md) for the philosophy behind this approach.

## Repository Structure

```
.
├── CLAUDE.md                    # AI instructions (Claude Code reads this)
├── README.md                    # You are here
├── LICENSE
├── .gitignore
│
├── config/
│   ├── workflow.config.yaml     # Project-specific settings
│   └── personas.yaml            # AI team personas
│
├── docs/
│   ├── README.md                # Documentation hub
│   ├── METHODOLOGY.md           # Philosophy & principles
│   ├── WORKFLOW_RULES.md        # Complete workflow reference
│   ├── QUICK_REFERENCE.md       # Daily cheat sheet
│   ├── SPEC_TEMPLATE.md         # Feature specification template
│   │
│   ├── specs/                   # Feature specifications
│   ├── reviews/                 # Quality reviews
│   ├── features/                # Feature documentation
│   └── bugs/                    # Bug post-mortems
│
├── .github/
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md # PR template with quality gates
│   └── workflows/               # CI/CD workflows
│
├── .claude/
│   ├── settings.json            # Hooks (auto-lint + pre-commit)
│   └── skills/                  # Slash commands (spec, test-plan, implement, review, ship, bug, mock-data-doc)
│
└── scripts/
    ├── init-project.sh          # Project initialization
    ├── add-mop-foundation.sh    # Pull latest MOP Next.js foundation
    └── upgrade-to-production.sh # Prototype → Production upgrade
```

## Development Workflow

### Phase 1: Specification

```
User: "Add user authentication"
     ↓
AI: Creates docs/specs/user-authentication.md
     ↓
AI: Presents spec with Given/When/Then criteria
     ↓
User: "Spec approved"
```

### Phase 2: Test Planning

```
User: "Spec approved"
     ↓
AI (/test-plan): Produces test matrix per AC — level, file, fixtures, edge cases
     ↓
User: approves test plan
```

### Phase 3: Implementation

```
AI (/implement): TDD cycle (Red → Green → Blue)
     ↓
AI: Updates traceability matrix
```

### Phase 4: Review

```
AI: Runs all 10 quality gates
     ↓
AI: Creates docs/reviews/user-authentication.md
     ↓
AI: All gates must pass GREEN
```

### Phase 5: User Testing

```
AI: Presents completed feature
     ↓
AI: STOPS and WAITS for approval
     ↓
User: "Approved"
     ↓
AI: Auto-generates docs/features/user-authentication.md
     ↓
User: "Commit" (when ready)
```

## Key Features

### Slash Commands (Skills)

Everything Claude does is driven by slash commands. Type them in Claude Code:

| Command | Phase | What it does |
|---------|-------|--------------|
| `/spec` | 1 — Specification | Creates spec in `docs/specs/` with Given/When/Then ACs |
| `/test-plan` | 2 — Test Planning | Produces test matrix appended to the spec file |
| `/implement` | 3 — Implementation | TDD cycle: Red → Green → Blue |
| `/review` | 4 — Review | Runs all quality gates, reports pass/fail |
| `/ship` | 5 — Ship | Creates commit + PR with conventional commit message |
| `/bug` | Any | Root cause analysis (5 Whys) + regression test |
| `/mock-data-doc` | Handoff | Generates `docs/MOCKED_DATA_STRUCTURE.md` for backend team |

Skills live in `.claude/skills/[name]/SKILL.md`.

---

### Given/When/Then Acceptance Criteria

```gherkin
### AC-001: Successful login

GIVEN a registered user on the login page
WHEN they enter valid email and password
AND click "Sign In"
THEN they are redirected to dashboard
AND see welcome message with their name
```

### Spec-to-Test Traceability

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `login.test.ts` | `should redirect on valid login` | ✅ |
| AC-002 | `login.test.ts` | `should show error on invalid password` | ✅ |

### 10 Quality Gates

**Prototype Mode (5 essential):**
1. **Tests pass** — `npm run test`, 0 failures
2. **Lint clean** — `npm run lint`, 0 warnings
3. **All ACs met** — every AC has a passing test
4. **Responsive** — 320px → 1440px
5. **Code review** — diff reviewed, no dead code / boundary issues

**Production Mode (adds 5):**
6. **Performance** — Lighthouse > 90
7. **Accessibility** — WCAG 2.1 AA
8. **Cross-browser** — Chrome, Safari, Firefox
9. **Build succeeds** — `npm run build`, 0 errors
10. **Security scan** — no XSS, injection, or exposed secrets

Authoritative definition: `.claude/skills/review/SKILL.md`.

### MOP Next.js Foundation

New Next.js projects pull the latest starter from
[`ministryofprogramming/mop-foundation-nextjs`](https://github.com/ministryofprogramming/mop-foundation-nextjs)
via `degit` — not a copy, always the latest:

```bash
./scripts/add-mop-foundation.sh         # pull latest main
./scripts/add-mop-foundation.sh v1.2.0  # pin to a specific release
```

Your workflow files (CLAUDE.md, .claude/, config/, docs/, scripts/) are
preserved. Foundation files are overlaid. `.gitignore` is merged. Re-run any
time to update.

`init-project.sh` offers to scaffold automatically when you select Next.js.

---

### Prototype → Backend Handoff

When a prototype is approved and real backend work begins, run:

```
/mock-data-doc
```

or say **"generate mock data doc"** in Claude Code.

Claude scans the entire codebase for mock data — `mocks/`, `fixtures/`, MSW
handlers, hardcoded arrays, `localStorage` writes — and writes
`docs/MOCKED_DATA_STRUCTURE.md`. The document covers:

- Every mocked entity with TypeScript shape and real example values
- All simulated operations (list, get, create, update, delete) with suggested real endpoints
- Relationships between entities (foreign keys, nested refs)
- Implied constraints (unique fields, enums, required fields)
- Prototype-only assumptions the backend must **not** carry forward (hardcoded admins, no auth, no pagination)
- Handoff checklist for the backend team

Commit the file to `docs/` so the backend team has it alongside the code.

---

### Bug Post-Mortems with 5 Whys

```
1. Why? → Session token not stored
2. Why? → localStorage call failed silently
3. Why? → localStorage undefined in SSR
4. Why? → Component rendered server-side
5. Why? → Missing "use client" directive

Root Cause: Component needs "use client" directive
```

## Configuration

### workflow.config.yaml

```yaml
project:
  name: "My Project"
  type: "web"  # web | mobile | backend | fullstack | cli

tech_stack:
  frontend:
    framework: "react"
    language: "typescript"
  testing:
    unit: "vitest"

quality_gates:
  mobile_responsive:
    enabled: true  # false for CLI/backend
  accessibility:
    enabled: true  # false for CLI/backend
```

> **Note:** `workflow.config.yaml` is **documentation only** — Claude does not
> read YAML. The authoritative configuration is `CLAUDE.md` (mode, quality gates)
> and `.claude/settings.json` (hooks).

### Conventional Commits

```bash
feat(auth): add user login with email/password
fix(auth): prevent session expiry on refresh
spec(auth): add login feature specification
test(auth): add acceptance tests for login
docs(auth): add login feature documentation
```

## Documentation

| Document | Purpose |
|----------|---------|
| [METHODOLOGY.md](docs/METHODOLOGY.md) | Core philosophy (the "why") |
| [WORKFLOW_RULES.md](docs/WORKFLOW_RULES.md) | Complete reference (the "how") |
| [QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) | Daily cheat sheet |
| [SPEC_TEMPLATE.md](docs/SPEC_TEMPLATE.md) | Feature spec template |

## Critical Rules

**NEVER:**
- Write code without approved spec
- Skip Given/When/Then format
- Proceed without user approval
- Auto-commit or auto-push
- Skip quality gates

**ALWAYS:**
- Spec before code
- Tests before implementation
- Stop & Wait for approval
- Generate docs on approval
- Post-mortem for bugs

## License

MIT License - See [LICENSE](LICENSE)
