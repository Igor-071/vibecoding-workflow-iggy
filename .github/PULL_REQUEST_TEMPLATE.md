## Summary

<!-- Brief description of changes (2-3 sentences) -->

## Related Issues

<!-- Link to related issues -->
- Closes #
- Related to #

## Type of Change

- [ ] **feat**: New feature (has spec: `docs/specs/[name].md`)
- [ ] **fix**: Bug fix (has post-mortem: `docs/bugs/BUG-[ID].md`)
- [ ] **docs**: Documentation only
- [ ] **spec**: Specification added/updated
- [ ] **test**: Tests added/updated
- [ ] **refactor**: Code refactoring (no feature change)
- [ ] **chore**: Maintenance tasks

## Specification

<!-- Link to spec if this is a feature -->
- Spec: `docs/specs/[feature-name].md`
- Review: `docs/reviews/[feature-name].md`

## Quality Gates Checklist

### Code Quality
- [ ] Linting passes with zero warnings
- [ ] TypeScript strict mode (no `any`)
- [ ] No `console.log` in production code
- [ ] Proper error handling

### Functionality
- [ ] All acceptance criteria met
- [ ] Happy path works
- [ ] Edge cases handled
- [ ] Error states display properly

### Mobile Responsive *(skip if N/A)*
- [ ] Tested at 320px
- [ ] Tested at 375px
- [ ] Tested at 768px
- [ ] Tested at 1024px
- [ ] Tested at 1440px
- [ ] Touch targets 44x44px minimum

### Performance
- [ ] Lighthouse score > 90
- [ ] No unnecessary re-renders
- [ ] Images optimized

### Accessibility *(skip if N/A)*
- [ ] Keyboard navigation works
- [ ] Screen reader compatible
- [ ] Color contrast meets requirements

### Browser Testing *(skip if N/A)*
- [ ] Chrome
- [ ] Safari
- [ ] Firefox

### Integration
- [ ] API calls work correctly
- [ ] Error handling for failures
- [ ] Loading states display

### Security
- [ ] No XSS vulnerabilities
- [ ] Secrets in env vars
- [ ] Input sanitized

### Documentation
- [ ] Spec is up to date
- [ ] Traceability matrix complete (all ✅)
- [ ] Complex code commented

## Traceability Matrix

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `[file]` | `[name]` | ✅ |
| AC-002 | `[file]` | `[name]` | ✅ |

## Testing Instructions

<!-- How to test this PR -->

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Screenshots *(if UI changes)*

<!-- Before/after screenshots -->

| Before | After |
|--------|-------|
| [img] | [img] |

---

## Reviewer Notes

<!-- Any notes for reviewers -->
