# Feature Specification Template

Copy this template to `docs/specs/[feature-name].md` when starting a new feature.

---

```markdown
# Specification: [Feature Name]

**Author:** Alex Chen (Tech Lead)
**Date:** [YYYY-MM-DD]
**Status:** Draft | Under Review | Approved | Implemented

---

## 1. Overview

### 1.1 Summary
[One paragraph describing what this feature does and why it's needed]

### 1.2 Goals
- [Goal 1]
- [Goal 2]
- [Goal 3]

### 1.3 Non-Goals
- [What this feature explicitly will NOT do]
- [Out of scope items]

### 1.4 User Story
As a [type of user],
I want [goal/desire],
So that [benefit/value].

---

## 2. Acceptance Criteria

### AC-001: [Brief descriptive title]

GIVEN [precondition or initial context]
  AND [additional precondition if needed]
WHEN [action or event occurs]
  AND [additional action if needed]
THEN [expected outcome]
  AND [additional outcome if needed]

---

### AC-002: [Brief descriptive title]

GIVEN [precondition or initial context]
WHEN [action or event occurs]
THEN [expected outcome]

---

### AC-003: [Brief descriptive title]

GIVEN [precondition or initial context]
WHEN [action or event occurs]
THEN [expected outcome]

---

### AC-004: Error Handling - [Error scenario]

GIVEN [precondition that leads to error]
WHEN [action that triggers error]
THEN [expected error handling behavior]
  AND [user feedback shown]

---

### AC-005: Edge Case - [Edge case description]

GIVEN [edge case precondition]
WHEN [action in edge case]
THEN [expected behavior]

---

## 3. Traceability Matrix

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | | | ⏳ |
| AC-002 | | | ⏳ |
| AC-003 | | | ⏳ |
| AC-004 | | | ⏳ |
| AC-005 | | | ⏳ |

**Status:** ⏳ Pending | ✅ Passed | ❌ Failed

---

## 4. Technical Design

### 4.1 Components/Files to Create or Modify

| File | Action | Description |
|------|--------|-------------|
| `src/components/[Name].tsx` | Create | [Purpose] |
| `src/hooks/use[Name].ts` | Create | [Purpose] |
| `src/[existing].tsx` | Modify | [What changes] |

### 4.2 Data Model

```typescript
// Define any new types/interfaces
interface [Name] {
  id: string;
  // ... fields
}
```

### 4.3 API Endpoints (if applicable)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/[resource]` | [Description] |
| POST | `/api/[resource]` | [Description] |

### 4.4 State Management

[Describe how state will be managed - context, store, local state, etc.]

---

## 5. UI/UX Requirements

### 5.1 Mobile Requirements (320px - 767px)

- [Mobile-specific behavior]
- [Touch interactions]
- [Layout adjustments]

### 5.2 Tablet Requirements (768px - 1023px)

- [Tablet-specific behavior]

### 5.3 Desktop Requirements (1024px+)

- [Desktop-specific behavior]

### 5.4 Interactions

- [Hover states]
- [Click/tap behavior]
- [Animations/transitions]

### 5.5 Accessibility

- [Keyboard navigation]
- [Screen reader considerations]
- [Focus management]

---

## 6. Error Handling

| Error Scenario | User Message | Technical Handling |
|----------------|--------------|-------------------|
| [Scenario 1] | "[User-friendly message]" | [How to handle] |
| [Scenario 2] | "[User-friendly message]" | [How to handle] |

---

## 7. Performance Considerations

- [Loading strategy]
- [Caching approach]
- [Bundle size impact]
- [Lazy loading needs]

---

## 8. Security Considerations

- [Authentication requirements]
- [Authorization checks]
- [Input validation]
- [Data sanitization]

---

## 9. Testing Strategy

### 9.1 Unit Tests
- [What to unit test]

### 9.2 Integration Tests
- [What to integration test]

### 9.3 Manual Testing
- [Manual testing scenarios]

---

## 10. Dependencies

### 10.1 New Dependencies
- [Package name] - [Why needed]

### 10.2 Feature Dependencies
- [Other features this depends on]

---

## 11. Rollout Plan

- [ ] Implementation complete
- [ ] All tests passing
- [ ] Quality gates passed
- [ ] User testing approved
- [ ] Documentation generated
- [ ] Ready for commit

---

## 12. Open Questions

- [ ] [Question 1]
- [ ] [Question 2]

---

## Sign-off

| Role | Name | Date | Approved |
|------|------|------|----------|
| Product Owner | [User] | | [ ] |
| Tech Lead | Alex Chen | | [ ] |
| Quality Lead | Dr. Priya Patel | | [ ] |
```

---

## Usage Notes

1. Copy this template to `docs/specs/[feature-name].md`
2. Fill in all sections
3. Ensure ALL acceptance criteria use Given/When/Then
4. Include at least one error handling AC
5. Include at least one edge case AC
6. Leave traceability matrix status as ⏳
7. Present to user for approval before coding
