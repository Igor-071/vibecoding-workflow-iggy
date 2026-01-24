# Quality Review Template

Copy this template to `docs/reviews/[feature-name].md` after implementation.

---

```markdown
# Quality Review: [Feature Name]

**Reviewer:** Dr. Priya Patel (Quality Lead)
**Date:** [YYYY-MM-DD]
**Spec:** [Link to docs/specs/[feature-name].md]
**Status:** In Review | Passed | Failed

---

## 1. Acceptance Criteria Verification

| Criterion | Description | Verified | Notes |
|-----------|-------------|----------|-------|
| AC-001 | [Brief description] | [ ] | |
| AC-002 | [Brief description] | [ ] | |
| AC-003 | [Brief description] | [ ] | |
| AC-004 | [Brief description] | [ ] | |
| AC-005 | [Brief description] | [ ] | |

**Result:** [ ] All criteria verified

---

## 2. Quality Gates

### Gate 1: Code Quality
- [ ] Linting passes with zero warnings
- [ ] TypeScript strict mode (no `any` types)
- [ ] No `console.log` statements in production code
- [ ] Proper error handling throughout
- [ ] No commented-out code
- [ ] Consistent code style

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 2: Functionality
- [ ] All acceptance criteria met
- [ ] Happy path works correctly
- [ ] Edge cases handled properly
- [ ] Error states display correctly
- [ ] No regressions in existing features

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 3: Mobile Responsive
*(Skip for CLI/backend projects)*

| Breakpoint | Tested | Issues |
|------------|--------|--------|
| 320px (iPhone SE) | [ ] | |
| 375px (iPhone standard) | [ ] | |
| 768px (Tablet) | [ ] | |
| 1024px (Desktop) | [ ] | |
| 1440px (Large desktop) | [ ] | |

- [ ] Touch targets minimum 44x44px
- [ ] Text minimum 16px on mobile
- [ ] No horizontal scroll at any breakpoint
- [ ] Images scale appropriately

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A

**Notes:**

---

### Gate 4: Performance
- [ ] Lighthouse Performance score > 90
- [ ] First Contentful Paint < 1.5s
- [ ] Time to Interactive < 3s
- [ ] No Cumulative Layout Shift
- [ ] Images optimized (WebP, lazy loading)
- [ ] No unnecessary re-renders

**Metrics:**
- Lighthouse Score: ___
- FCP: ___s
- TTI: ___s
- Bundle Size Impact: ___KB

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 5: Accessibility
*(Skip for CLI/backend projects)*

- [ ] WCAG 2.1 AA compliant
- [ ] Keyboard navigation works (Tab, Enter, Escape)
- [ ] Focus visible on all interactive elements
- [ ] Screen reader compatible (tested with VoiceOver/NVDA)
- [ ] Proper heading hierarchy
- [ ] Alt text for all images
- [ ] Color contrast meets requirements
- [ ] Form labels properly associated
- [ ] Error messages announced to screen readers

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A

**Notes:**

---

### Gate 6: Browser Testing
*(Skip for non-web projects)*

| Browser | Version | Tested | Issues |
|---------|---------|--------|--------|
| Chrome | Latest | [ ] | |
| Safari | Latest | [ ] | |
| Firefox | Latest | [ ] | |
| Chrome Mobile | Latest | [ ] | |
| Safari Mobile | Latest | [ ] | |

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A

**Notes:**

---

### Gate 7: Integration Testing
- [ ] API calls work correctly
- [ ] Error handling for API failures
- [ ] Loading states display properly
- [ ] Data flows correctly between components
- [ ] State management works as expected
- [ ] No race conditions

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 8: Security Review
- [ ] No XSS vulnerabilities (user input sanitized)
- [ ] No SQL injection points
- [ ] Secrets stored in environment variables
- [ ] Authentication checks where required
- [ ] Authorization checks where required
- [ ] No sensitive data in logs or console
- [ ] HTTPS enforced for external calls

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 9: UX Consistency
*(Skip for CLI/backend projects)*

- [ ] Matches design system/style guide
- [ ] Consistent spacing (using design tokens)
- [ ] Proper typography hierarchy
- [ ] Animations/transitions appropriate
- [ ] Clear and helpful error messages
- [ ] Logical tab order
- [ ] Consistent button styles and sizes

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A

**Notes:**

---

### Gate 10: Documentation
- [ ] Complex code has explanatory comments
- [ ] Specification is up to date
- [ ] Traceability matrix is complete (all ✅)
- [ ] Reusable components documented
- [ ] Any new APIs documented

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

## 3. Traceability Matrix Verification

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `[file]` | `[name]` | ✅/❌ |
| AC-002 | `[file]` | `[name]` | ✅/❌ |
| AC-003 | `[file]` | `[name]` | ✅/❌ |

**All tests passing:** [ ] Yes  [ ] No

---

## 4. Summary

### Gates Summary

| Gate | Status |
|------|--------|
| Code Quality | |
| Functionality | |
| Mobile Responsive | |
| Performance | |
| Accessibility | |
| Browser Testing | |
| Integration | |
| Security | |
| UX Consistency | |
| Documentation | |

### Overall Result

[ ] **PASSED** - All gates passed, ready for user testing
[ ] **FAILED** - Issues found, requires fixes

### Issues Found

| Issue | Severity | Gate | Description |
|-------|----------|------|-------------|
| 1 | High/Medium/Low | [Gate] | [Description] |
| 2 | | | |

### Recommendations

[Any recommendations for improvement]

---

## 5. Sign-off

| Role | Name | Date | Approved |
|------|------|------|----------|
| Quality Lead | Dr. Priya Patel | [DATE] | [ ] |
```

---

## Usage Notes

1. Copy this template after implementation is complete
2. Verify each acceptance criterion manually
3. Check ALL quality gates (skip N/A ones)
4. Document any issues found
5. Feature cannot proceed to user testing until all gates PASSED
