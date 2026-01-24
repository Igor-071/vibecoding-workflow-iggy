---
name: Bug Report
about: Report a bug (will require post-mortem)
title: '[BUG] '
labels: 'bug'
assignees: ''
---

## Bug Description

<!-- Clear, precise description of the bug -->

## Expected Behavior

<!-- What should have happened? -->

## Actual Behavior

<!-- What actually happened? -->

## Steps to Reproduce

1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

## Environment

- **Browser/Device:** [e.g., Chrome 120, iPhone 15]
- **OS:** [e.g., macOS 14.0, iOS 17]
- **App Version:** [e.g., 1.2.3]
- **Screen Size:** [e.g., 375px width]

## Screenshots / Videos

<!-- If applicable, add screenshots or screen recordings -->

## Console Errors

<!-- Copy any relevant console errors -->

```
[Paste console errors here]
```

## Severity Assessment

- [ ] **Critical** - Data loss, security breach, complete failure
- [ ] **High** - Major feature broken, no workaround
- [ ] **Medium** - Feature degraded, workaround exists
- [ ] **Low** - Minor issue, cosmetic

---

## For Development Team

### Bug Handling Workflow

1. [ ] **STOP** - Don't fix immediately
2. [ ] **ANALYZE** - Root cause (5 Whys)
3. [ ] **DOCUMENT** - Post-mortem: `docs/bugs/BUG-[ID]-[name].md`
4. [ ] **TEST** - Write failing regression test
5. [ ] **FIX** - Implement minimal fix
6. [ ] **VERIFY** - Run all tests
7. [ ] **REVIEW** - Quality check
8. [ ] **CLOSE** - Update post-mortem
