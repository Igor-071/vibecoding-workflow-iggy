# Vibecoding v2

## Project
- **Name:** PROJECT_NAME
- **Stack:** TECH_STACK
- **Mode:** prototype

## Commands
```bash
npm run dev          # Dev server
npm run test         # Tests
npm run lint         # Lint
npm run lint:fix     # Auto-fix
npm run build        # Production build
npm run test:cover   # Coverage
```

## IMPORTANT: Workflow Rules

1. **Spec first.** Before writing ANY code, create a spec in `docs/specs/`. Use Given/When/Then. STOP and wait for user approval.
2. **TDD always.** Failing test first (RED), minimal code to pass (GREEN), refactor (BLUE). No exceptions.
3. **Never commit or push without explicit user instruction.**
4. **After implementation, STOP and present results. Wait for approval.**
5. **Add "use context7" when using any framework/library** to get current docs.

## Code Style
- Conventional commits: `feat|fix|docs|test|refactor(scope): description`
- Keep functions small. One purpose per function.
- Name things clearly. No abbreviations.
- Handle errors at system boundaries only. Trust internal code.

## When Stuck
- Check docs/specs/ for the approved spec
- Run tests to see what's failing
- Ask the user — don't guess at requirements
