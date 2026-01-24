# Feature Documentation Template

This template is used to auto-generate documentation when a feature is approved.

---

```markdown
# Feature: [Feature Name]

**Version:** 1.0.0
**Date:** [YYYY-MM-DD]
**Status:** Released

---

## Overview

[Brief description of what this feature does and its purpose]

---

## User Guide

### What This Feature Does

[Clear, non-technical description for end users]

### How to Use

#### Step 1: [First Step Title]
[Description of first step]

#### Step 2: [Second Step Title]
[Description of second step]

#### Step 3: [Third Step Title]
[Description of third step]

### Tips
- [Helpful tip 1]
- [Helpful tip 2]

### Known Limitations
- [Limitation 1]
- [Limitation 2]

---

## Technical Documentation

### Components

#### [ComponentName]

**Location:** `src/components/[ComponentName].tsx`

**Description:** [What this component does]

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| `prop1` | `string` | Yes | - | [Description] |
| `prop2` | `boolean` | No | `false` | [Description] |
| `onAction` | `() => void` | No | - | [Description] |

**Usage Example:**

```tsx
import { ComponentName } from '@/components/ComponentName';

function Example() {
  return (
    <ComponentName
      prop1="value"
      prop2={true}
      onAction={() => console.log('Action')}
    />
  );
}
```

---

### Hooks

#### use[HookName]

**Location:** `src/hooks/use[HookName].ts`

**Description:** [What this hook does]

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `param1` | `string` | Yes | [Description] |

**Returns:**

| Property | Type | Description |
|----------|------|-------------|
| `data` | `Type` | [Description] |
| `isLoading` | `boolean` | [Description] |
| `error` | `Error \| null` | [Description] |

**Usage Example:**

```tsx
import { useHookName } from '@/hooks/useHookName';

function Example() {
  const { data, isLoading, error } = useHookName('param');

  if (isLoading) return <Loading />;
  if (error) return <Error message={error.message} />;

  return <Display data={data} />;
}
```

---

### API Endpoints

#### [Method] [Endpoint]

**Description:** [What this endpoint does]

**Request:**

```typescript
// Request body type
interface RequestBody {
  field1: string;
  field2: number;
}
```

**Response:**

```typescript
// Response type
interface Response {
  success: boolean;
  data: {
    id: string;
    // ...
  };
}
```

**Example:**

```typescript
const response = await fetch('/api/endpoint', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ field1: 'value', field2: 123 }),
});
```

---

### Data Flow

```
[User Action]
     ↓
[Component] → calls → [Hook/API]
     ↓
[State Update]
     ↓
[UI Re-render]
```

### State Management

[Description of how state is managed for this feature]

**State Shape:**

```typescript
interface FeatureState {
  // ...
}
```

---

### Error Handling

| Error | Cause | User Message | Recovery |
|-------|-------|--------------|----------|
| [Error type] | [What causes it] | [What user sees] | [How to recover] |

---

## Testing

### Test Files

| File | Type | Coverage |
|------|------|----------|
| `[feature].test.ts` | Unit | [X]% |
| `[feature].integration.test.ts` | Integration | [X]% |

### Running Tests

```bash
# Run all tests for this feature
npm run test -- --grep "[feature]"

# Run with coverage
npm run test:coverage -- --grep "[feature]"
```

---

## Related Documentation

- [Specification](../specs/[feature-name].md)
- [Quality Review](../reviews/[feature-name].md)

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | [DATE] | Initial release |
```

---

## Auto-Generation Notes

When generating this documentation:

1. Extract component information from source code
2. Extract hook signatures and return types
3. Include API endpoint documentation if applicable
4. Reference the spec for acceptance criteria
5. Include test coverage information
6. Keep technical and user-facing sections separate
