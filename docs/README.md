# Documentation Hub

Welcome to the project documentation. This folder contains all workflow documentation and templates.

---

## Quick Links

| Document | Purpose |
|----------|---------|
| [METHODOLOGY.md](./METHODOLOGY.md) | Core philosophy and principles (the "why") |
| [WORKFLOW_RULES.md](./WORKFLOW_RULES.md) | Complete workflow reference (the "how") |
| [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) | Daily cheat sheet |

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

## Getting Started

1. **New Feature?**
   - Copy [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) to `specs/[feature-name].md`
   - Fill in all sections
   - Get user approval before coding

2. **Implementation Done?**
   - Copy [reviews/REVIEW_TEMPLATE.md](./reviews/REVIEW_TEMPLATE.md) to `reviews/[feature-name].md`
   - Verify all quality gates
   - Present to user

3. **Bug Found?**
   - Copy [bugs/BUG_POSTMORTEM_TEMPLATE.md](./bugs/BUG_POSTMORTEM_TEMPLATE.md) to `bugs/BUG-[ID]-[name].md`
   - Complete 5 Whys analysis
   - Write test before fixing

---

## Need Help?

- **Philosophy questions:** See [METHODOLOGY.md](./METHODOLOGY.md)
- **Process questions:** See [WORKFLOW_RULES.md](./WORKFLOW_RULES.md)
- **Quick lookup:** See [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
