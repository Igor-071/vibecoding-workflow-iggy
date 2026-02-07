# Skill: Quality Review

Activate when: Implementation is approved and ready for final review before shipping.

## Quality Gates

Run each gate. Report pass/fail. ALL must pass.

### Prototype Mode (5 gates)

| # | Gate | How to Verify | Pass Criteria |
|---|------|---------------|---------------|
| 1 | **Tests pass** | `npm run test` | 0 failures |
| 2 | **Lint clean** | `npm run lint` | 0 errors, 0 warnings |
| 3 | **All ACs met** | Check traceability matrix | Every AC has a passing test |
| 4 | **Responsive** | Playwright or manual check at 320/375/768/1024/1440px | No layout breaks |
| 5 | **Code review** | Read the diff. Check for: dead code, hardcoded values, missing error handling at boundaries, security issues | Clean |

### Production Mode (add these 5)

| # | Gate | How to Verify | Pass Criteria |
|---|------|---------------|---------------|
| 6 | **Performance** | Lighthouse audit | Score > 90, FCP < 1.5s |
| 7 | **Accessibility** | axe-core or Lighthouse a11y | WCAG 2.1 AA, keyboard nav works |
| 8 | **Cross-browser** | Test in Chrome, Safari, Firefox | No visual or functional regressions |
| 9 | **Build succeeds** | `npm run build` | 0 errors |
| 10 | **Security scan** | Check for XSS, injection, exposed secrets | Clean |

## Output Format

```
QUALITY REVIEW: [Feature Name]

| # | Gate           | Status | Notes              |
|---|----------------|--------|--------------------|
| 1 | Tests pass     | PASS   | 12/12 passing      |
| 2 | Lint clean     | PASS   |                    |
| 3 | All ACs met    | PASS   | 4/4 criteria       |
| 4 | Responsive     | PASS   | All breakpoints OK |
| 5 | Code review    | PASS   | No issues found    |

RESULT: ALL GATES PASSED — Ready to ship
```

## If a Gate Fails

1. Report which gate failed and why
2. Fix the issue
3. Re-run ALL gates (not just the failed one)
4. Report again
