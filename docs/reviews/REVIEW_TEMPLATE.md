# Quality Review Template

Copy this template to `docs/reviews/[feature-name].md` after implementation.

Gate names and order match `.claude/skills/review/SKILL.md` — the authoritative definition.

---

```markdown
# Quality Review: [Feature Name]

**Reviewer:** Dr. Priya Patel (Quality Lead)
**Date:** [YYYY-MM-DD]
**Spec:** [Link to docs/specs/[feature-name].md]
**Mode:** prototype | production
**Status:** In Review | Passed | Failed

---

## 1. Acceptance Criteria Verification

| Criterion | Description | Verified | Notes |
|-----------|-------------|----------|-------|
| AC-001 | [Brief description] | [ ] | |
| AC-002 | [Brief description] | [ ] | |
| AC-003 | [Brief description] | [ ] | |

**Result:** [ ] All criteria verified

---

## 2. Quality Gates

### Prototype Mode (5 essential — always required)

### Gate 1: Tests pass
- [ ] `npm run test` exits 0
- [ ] 0 failing tests
- [ ] Coverage meets project threshold (if configured)

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 2: Lint clean
- [ ] `npm run lint` exits 0
- [ ] 0 warnings
- [ ] TypeScript strict mode (no `any`)
- [ ] No `console.log` in production code paths
- [ ] No commented-out code

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 3: All ACs met
- [ ] Every AC in the spec maps to a passing test
- [ ] Traceability matrix complete (all ✅)
- [ ] No AC marked ⏳ or ❌
- [ ] Happy path and edge cases both covered

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Gate 4: Responsive
*(Skip for CLI/backend projects)*

| Breakpoint | Tested | Issues |
|------------|--------|--------|
| 320px (iPhone SE) | [ ] | |
| 375px (iPhone standard) | [ ] | |
| 768px (Tablet) | [ ] | |
| 1024px (Desktop) | [ ] | |
| 1440px (Large desktop) | [ ] | |

- [ ] Touch targets ≥ 44x44px
- [ ] Body text ≥ 16px on mobile
- [ ] No horizontal scroll at any breakpoint
- [ ] Images scale appropriately

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A

**Notes:**

---

### Gate 5: Code review
- [ ] No dead code or unreachable branches
- [ ] No hardcoded values that should be config
- [ ] Error handling at system boundaries only
- [ ] No off-by-one or boundary errors
- [ ] Naming is clear; no abbreviations
- [ ] Matches design system / consistent spacing (if UI)
- [ ] Complex code has a one-line *why* comment

**Status:** [ ] PASSED  [ ] FAILED

**Notes:**

---

### Production Mode (adds 5 — skip in prototype mode)

### Gate 6: Performance
- [ ] Lighthouse Performance > 90
- [ ] First Contentful Paint < 1.5s
- [ ] Time to Interactive < 3s
- [ ] No Cumulative Layout Shift
- [ ] Images optimized (WebP, lazy loading)

**Metrics:**
- Lighthouse Score: ___
- FCP: ___s
- TTI: ___s
- Bundle Size Impact: ___KB

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A (prototype)

**Notes:**

---

### Gate 7: Accessibility
*(Skip for CLI/backend projects)*

- [ ] WCAG 2.1 AA (axe-core or Lighthouse a11y clean)
- [ ] Keyboard navigation works end-to-end (Tab, Enter, Escape)
- [ ] Focus visible on all interactive elements
- [ ] Screen reader labels present (tested with VoiceOver/NVDA)
- [ ] Proper heading hierarchy
- [ ] Alt text for all images
- [ ] Color contrast passes
- [ ] Form labels properly associated

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A

**Notes:**

---

### Gate 8: Cross-browser
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

### Gate 9: Build succeeds
- [ ] `npm run build` exits 0
- [ ] No type errors
- [ ] No broken imports
- [ ] API calls wired to real endpoints (not mocks)
- [ ] Loading and error states display correctly

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A (prototype)

**Notes:**

---

### Gate 10: Security scan
- [ ] No XSS vectors (`dangerouslySetInnerHTML` reviewed)
- [ ] No SQL/command injection points
- [ ] Secrets only in environment variables
- [ ] Input sanitization at boundaries
- [ ] Auth checks on protected routes
- [ ] No sensitive data in logs
- [ ] HTTPS enforced for external calls

**Status:** [ ] PASSED  [ ] FAILED  [ ] N/A (prototype)

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
| Tests pass | |
| Lint clean | |
| All ACs met | |
| Responsive | |
| Code review | |
| Performance | |
| Accessibility | |
| Cross-browser | |
| Build succeeds | |
| Security scan | |

### Overall Result

[ ] **PASSED** — All required gates passed, ready for user testing
[ ] **FAILED** — Issues found, requires fixes

### Issues Found

| Issue | Severity | Gate | Description |
|-------|----------|------|-------------|
| 1 | High/Medium/Low | [Gate] | [Description] |

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
3. In prototype mode, Gates 6–10 are marked N/A
4. In production mode, ALL 10 gates must pass
5. Document any issues found
6. Feature cannot proceed to user testing until all required gates PASSED
