# Skill: Mock Data Structure Documentation

Activate when: User says "generate mock data doc", "document mocks", "/mock-data-doc", or is handing off a prototype to a backend team.

Purpose: Prototypes run on mock data. When the prototype is approved and real backend work begins, the backend team needs to know exactly what data shapes, relationships, and behaviors they must implement. This skill produces `docs/MOCKED_DATA_STRUCTURE.md` — a complete handoff document.

## Process

### Step 1: Discover all mock data

Search the codebase for mock data in all common locations:

```
- mocks/, __mocks__/, fixtures/, stubs/, seed/, seeds/
- data/, mock-data/, test-data/
- Files named: mock*.ts, *.mock.ts, fixtures.ts, seed.ts, mockData.*
- Hardcoded arrays/objects inside components, stores, hooks
- MSW handlers (mswjs), Storybook mocks
- localStorage / sessionStorage writes with structured data
- API mocks in: api/mocks/, lib/mocks/, services/mocks/
```

Use Grep and Glob broadly — do not stop at the first match. Prototypes scatter mock data.

### Step 2: Analyze each mock

For each mock file or inline mock, extract:

- **Entity name** (User, Product, Order, etc.)
- **Data shape** (fields, types, optionality, nested structures)
- **Example values** (real-looking samples from the mock)
- **Where it's consumed** (which components/hooks/routes use it)
- **What operations are simulated** (GET list, GET by id, POST, PUT, DELETE)
- **Relationships** (foreign keys, nested references, joins implied by shape)
- **Constraints implied by the mock** (unique fields, required fields, enums, ranges)
- **State management** (is the mock mutated at runtime? persisted to localStorage? reset on reload?)

### Step 3: Infer the real API contract

For each mocked operation, describe what the real backend must implement:

- HTTP method + path (inferred or suggested)
- Request shape (query params, body)
- Response shape (single entity, paginated list, error envelope)
- Auth requirements (if mock checks for a user/token)
- Side effects (what else changes when this endpoint fires)

### Step 4: Write `docs/MOCKED_DATA_STRUCTURE.md`

Use this structure:

```markdown
# Mocked Data Structure

This document describes every mock data source in the prototype and specifies what the real backend must implement to replace it. Generated on [DATE] by `/mock-data-doc`.

## Summary

- **Total entities mocked:** N
- **Total endpoints to implement:** N
- **Persistence strategy in prototype:** [in-memory | localStorage | sessionStorage | mixed]
- **Auth model in prototype:** [none | hardcoded user | mock JWT | other]

## Entities

### [EntityName]

**Shape:**
```typescript
interface EntityName {
  id: string;           // UUID in mock, backend should use UUID v4
  name: string;         // required, max length appears to be ~50
  email: string;        // required, unique (mock enforces uniqueness)
  role: 'admin' | 'user' | 'guest';  // enum
  createdAt: string;    // ISO 8601 in mock
  profile?: {           // nested, optional
    bio: string;
    avatarUrl: string;
  };
}
```

**Source files:**
- `src/mocks/users.ts` — seed data (5 users)
- `src/hooks/useUser.ts` — consumes mock via `getUserById`

**Consumed by:**
- `src/components/UserCard.tsx`
- `src/app/profile/page.tsx`

**Mocked operations:**
| Operation | Mock function | Real endpoint (suggested) | Notes |
|-----------|--------------|---------------------------|-------|
| List users | `getUsers()` | `GET /api/users` | Prototype has no pagination; real API should paginate |
| Get by id | `getUserById(id)` | `GET /api/users/:id` | Returns 404 if missing in mock |
| Create | `createUser(data)` | `POST /api/users` | Mock assigns id via `crypto.randomUUID()` |
| Update | `updateUser(id, patch)` | `PATCH /api/users/:id` | Mock does partial update |

**Relationships:**
- Has many `Order` via `order.userId`
- Belongs to `Team` via `user.teamId` (optional)

**Implied constraints:**
- `email` is unique across all users
- `role` defaults to `'user'` on create
- `createdAt` is set server-side (mock generates at create time)

**Prototype-only behavior:**
- User list is reset to seed on page reload (no persistence)
- Admin role is hardcoded for `email === "admin@demo.com"`

---

### [Next entity...]

(repeat structure for each entity)

---

## API Endpoints Summary

Every endpoint the backend team must implement:

| Method | Path | Entity | Purpose |
|--------|------|--------|---------|
| GET | /api/users | User | List all |
| GET | /api/users/:id | User | Get one |
| POST | /api/users | User | Create |
| ...    | ...  | ...    | ...     |

## Data Relationships Diagram

```
User ──< Order >── Product
  │
  └── Team (optional)
```

## Mock-Specific Assumptions to Revisit

Things the prototype assumes that may not be true in production:

- No rate limiting
- No pagination (all lists return all records)
- No soft deletes (deletes remove from in-memory array)
- No optimistic locking / version fields
- Timestamps are client-generated in create mutations
- [other assumptions found]

## Handoff Checklist for Backend Team

- [ ] Schema designed for every entity above
- [ ] All endpoints in the summary table implemented
- [ ] Auth/authz strategy decided and implemented
- [ ] Pagination added where prototype returned full lists
- [ ] Validation rules match implied constraints
- [ ] Error shape standardized (prototype may have inconsistent errors)
- [ ] Migration path: how will prototype consumers switch to real API?

---

**Generated from prototype state at commit `[SHORT_SHA]`. If mock files change, regenerate this doc.**
```

### Step 5: Report

Tell the user:

```
MOCK DATA DOC GENERATED

File: docs/MOCKED_DATA_STRUCTURE.md
Entities documented: N
Endpoints to implement: N
Source files analyzed: N

Next steps:
- Review the doc for any entities you'd rename before handoff
- Commit the doc so the backend team can read it
```

## Rules

- **Do not invent data shapes.** If the mock doesn't make a field's type obvious, say "type unclear — backend team decide".
- **Include example values** from the actual mock data. Backend devs want to see what real data looks like, not just types.
- **Be explicit about prototype-only assumptions.** Anything the mock does that production must NOT do (hardcoded admin, no auth, etc.) must be called out.
- **Cite file paths** for every entity and operation. The backend team will want to read the mocks themselves.
- **Keep it scannable.** Backend devs should be able to read the Summary + Endpoints table and know the scope in 60 seconds.
- **One entity per section.** Do not group entities to save space.

## After Generating

The doc is a handoff artifact. Suggest the user:
1. Review it for accuracy
2. Add any business context the mock doesn't capture (e.g., "orders can only be placed M-F")
3. Commit it to `docs/` so the backend team has it
