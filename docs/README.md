# Documentation Hub

Welcome to the project documentation. This folder contains all workflow documentation and templates.

---

## Quick Links

| Document | Purpose |
|----------|---------|
| [METHODOLOGY.md](./METHODOLOGY.md) | Core philosophy and principles (the "why") |
| [WORKFLOW_RULES.md](./WORKFLOW_RULES.md) | Complete workflow reference (the "how") |
| [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) | Daily cheat sheet — skills, gates, commit format |

---

## Templates

| Template | Location | When to Use |
|----------|----------|-------------|
| Feature Spec | [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) | Before starting any new feature |
| Quality Review | [reviews/REVIEW_TEMPLATE.md](./reviews/REVIEW_TEMPLATE.md) | After implementation, before user testing |
| Feature Docs | [features/FEATURE_DOC_TEMPLATE.md](./features/FEATURE_DOC_TEMPLATE.md) | Auto-generated on feature approval |
| Bug Post-Mortem | [bugs/BUG_POSTMORTEM_TEMPLATE.md](./bugs/BUG_POSTMORTEM_TEMPLATE.md) | When analyzing any bug |

---

## Folder Structure

```
docs/
├── README.md              ← You are here
├── METHODOLOGY.md         ← Philosophy & principles
├── WORKFLOW_RULES.md      ← Complete workflow reference
├── QUICK_REFERENCE.md     ← Daily cheat sheet
├── SPEC_TEMPLATE.md       ← Feature specification template
│
├── specs/                 ← Feature specifications (INPUT)
│   └── [feature-name].md
│
├── reviews/               ← Quality reviews (QA)
│   ├── REVIEW_TEMPLATE.md
│   └── [feature-name].md
│
├── features/              ← Feature documentation (OUTPUT)
│   ├── FEATURE_DOC_TEMPLATE.md
│   └── [feature-name].md
│
└── bugs/                  ← Bug post-mortems
    ├── BUG_POSTMORTEM_TEMPLATE.md
    └── BUG-[ID]-[name].md
```

---

## Documentation Flow

```
1. SPEC (Input)
   docs/specs/[feature].md
   ↓
   Created BEFORE coding
   User approval required

2. REVIEW (QA)
   docs/reviews/[feature].md
   ↓
   Created AFTER implementation
   All quality gates must pass

3. FEATURE DOCS (Output)
   docs/features/[feature].md
   ↓
   AUTO-GENERATED on user approval
   Both technical and user-facing docs
```

---

## For Bugs

```
Bug Found
   ↓
docs/bugs/BUG-[ID]-[name].md
   ↓
- 5 Whys analysis
- Regression test first
- Fix and verify
- Prevention measures
```

---

## Skills (Slash Commands)

Type these in Claude Code — no manual file copying needed:

| Command | When |
|---------|------|
| `/spec` | Starting a new feature |
| `/test-plan` | After spec is approved |
| `/implement` | After test plan is approved |
| `/review` | After implementation |
| `/ship` | After review passes |
| `/bug` | When a bug is found |
| `/mock-data-doc` | When prototype is done — generates backend handoff doc |

---

## MOP Next.js Foundation

```bash
./scripts/add-mop-foundation.sh         # pull latest
./scripts/add-mop-foundation.sh v1.2.0  # pin to release
```

Pulls the latest [MOP Next.js foundation](https://github.com/ministryofprogramming/mop-foundation-nextjs)
without touching your workflow files. Re-run any time to update.

---

## Getting Started

1. **New Feature?**
   - Type `/spec` in Claude Code — it creates `specs/[feature-name].md` for you
   - Get approval, then `/test-plan`, then `/implement`

2. **Implementation Done?**
   - Type `/review` — Claude runs all quality gates and creates `reviews/[feature-name].md`

3. **Bug Found?**
   - Type `/bug` — Claude runs 5 Whys and creates `bugs/BUG-[ID]-[name].md`

4. **Prototype approved, handing off to backend?**
   - Type `/mock-data-doc` — Claude writes `MOCKED_DATA_STRUCTURE.md` for the backend team

---

## Need Help?

- **Philosophy questions:** See [METHODOLOGY.md](./METHODOLOGY.md)
- **Process questions:** See [WORKFLOW_RULES.md](./WORKFLOW_RULES.md)
- **Quick lookup:** See [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
