# Bug Post-Mortem Template

Copy this template to `docs/bugs/BUG-[ID]-[brief-name].md` when analyzing a bug.

---

```markdown
# Bug Post-Mortem: BUG-[ID]

## Summary

| Field | Value |
|-------|-------|
| **Bug ID** | BUG-[ID] |
| **Title** | [Brief descriptive title] |
| **Severity** | Critical / High / Medium / Low |
| **Found By** | User / QA / Automated Test |
| **Date Found** | YYYY-MM-DD |
| **Date Fixed** | YYYY-MM-DD |
| **Time to Fix** | [X hours/days] |
| **Fixed By** | [Name] |

---

## What Happened

### Bug Description
[Clear, precise description of the bug behavior]

### Expected Behavior
[What should have happened instead]

### Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]
4. Bug occurs

### Environment
- Browser/Device: [e.g., Chrome 120, iPhone 15]
- OS: [e.g., macOS 14.0]
- App Version: [e.g., 1.2.3]

### Evidence
[Screenshots, error logs, console output if applicable]

---

## Root Cause Analysis (5 Whys)

### The 5 Whys

1. **Why did this happen?**
   → [Answer]

2. **Why?** (dig deeper into previous answer)
   → [Answer]

3. **Why?** (dig deeper)
   → [Answer]

4. **Why?** (dig deeper)
   → [Answer]

5. **Why?** (root cause)
   → [ROOT CAUSE]

### Root Cause Summary
[One sentence summary of the actual root cause]

---

## Impact Assessment

### Users Affected
- Number of users: [estimated count or "unknown"]
- User segments: [e.g., "all users", "premium users", "mobile users"]
- Duration of impact: [e.g., "2 hours", "since last release"]

### Data Impact
- [ ] No data affected
- [ ] Data was corrupted
- [ ] Data was lost
- [ ] Data was exposed

Details: [If data was affected, describe the extent]

### Business Impact
- [ ] Revenue impact: [describe if applicable]
- [ ] Reputation impact: [describe if applicable]
- [ ] SLA breach: [Yes/No]

---

## Fix Applied

### Description of Fix
[What was changed to fix the bug]

### Files Changed

| File | Change |
|------|--------|
| `[path/to/file]` | [Brief description of change] |
| `[path/to/file]` | [Brief description of change] |

### Code Diff Summary
```diff
- [old code]
+ [new code]
```

---

## Regression Test Added

### Test Details

| Field | Value |
|-------|-------|
| **Test File** | `[path/to/test.ts]` |
| **Test Name** | `[test name]` |
| **Test Type** | Unit / Integration / E2E |

### Test Code
```typescript
describe('[Feature]', () => {
  it('[should do expected behavior]', () => {
    // Test implementation
  });
});
```

### Test Verification
- [ ] Test fails without the fix
- [ ] Test passes with the fix
- [ ] Test is added to CI pipeline

---

## Prevention Measures

### Immediate Actions
- [ ] Regression test added (see above)
- [ ] Code review of similar patterns
- [ ] Documentation updated

### Long-term Improvements

| Improvement | Owner | Due Date | Status |
|-------------|-------|----------|--------|
| [Improvement 1] | [Name] | [Date] | [ ] Todo |
| [Improvement 2] | [Name] | [Date] | [ ] Todo |

### Quality Gate Updates
- [ ] New quality gate check needed: [describe]
- [ ] Existing gate needs strengthening: [describe]
- [ ] No gate updates needed

---

## Lessons Learned

### What Went Well
- [Positive aspect of how bug was handled]
- [Another positive]

### What Could Be Improved
- [Area for improvement]
- [Another area]

### Key Takeaways
1. [Lesson 1]
2. [Lesson 2]
3. [Lesson 3]

---

## Timeline

| Time | Event |
|------|-------|
| [YYYY-MM-DD HH:MM] | Bug reported |
| [YYYY-MM-DD HH:MM] | Investigation started |
| [YYYY-MM-DD HH:MM] | Root cause identified |
| [YYYY-MM-DD HH:MM] | Fix implemented |
| [YYYY-MM-DD HH:MM] | Fix verified |
| [YYYY-MM-DD HH:MM] | Fix deployed |

---

## Sign-off

| Role | Name | Date | Approved |
|------|------|------|----------|
| Developer | [Name] | [Date] | [ ] |
| Quality Lead | Dr. Priya Patel | [Date] | [ ] |
```

---

## Severity Guidelines

| Severity | Definition | Response Time |
|----------|------------|---------------|
| **Critical** | Data loss, security breach, complete system failure | Immediate (drop everything) |
| **High** | Major feature broken, no workaround available | Same day |
| **Medium** | Feature degraded but workaround exists | Next sprint |
| **Low** | Minor issue, cosmetic, edge case | Backlog |

---

## Usage Notes

1. Create post-mortem BEFORE fixing the bug
2. Complete 5 Whys analysis to find true root cause
3. Write failing regression test BEFORE implementing fix
4. Verify test fails without fix, passes with fix
5. Document prevention measures
6. Get sign-off from Quality Lead
