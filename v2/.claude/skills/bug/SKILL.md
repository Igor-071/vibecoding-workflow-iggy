# Skill: Bug Analysis

Activate when: A bug is found during development or reported by user.

## Process

### 1. STOP — Don't fix yet
Understand before acting.

### 2. Reproduce
```
Write the exact steps to reproduce the bug.
If you can't reproduce it, you can't fix it.
```

### 3. Five Whys
```
Why did it happen? → [Answer 1]
Why? → [Answer 2]
Why? → [Answer 3]
Why? → [Answer 4]
Why? → [Root cause]
```

### 4. Write failing test FIRST
```
Write a test that reproduces the bug.
Run it. Confirm it fails.
This is now your regression test.
```

### 5. Fix — Minimal change
```
Fix the root cause. Not the symptom.
The smallest change that makes the failing test pass.
```

### 6. Verify
```
Run ALL tests. Not just the new one.
The fix must not break anything else.
```

### 7. Document in `docs/bugs/BUG-[number]-[name].md`

```markdown
# BUG-[number]: [Short description]

## What happened
[One paragraph]

## Root cause (Five Whys)
1. [Why 1]
2. [Why 2]
3. [Why 3]
4. [Why 4]
5. [Root cause]

## Fix applied
[What was changed and why]

## Regression test
[File:line — test name]

## Prevention
[What would prevent this class of bug in the future]
```

## Rules
- Never skip the failing test. The test proves the bug existed and proves it's fixed.
- Fix root causes, not symptoms. A symptom fix means the bug comes back.
- Keep bug docs short. If it takes more than a page, the bug is multiple bugs.
