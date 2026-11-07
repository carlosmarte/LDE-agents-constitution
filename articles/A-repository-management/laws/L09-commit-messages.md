# A-L09 — Commit messages

**Enforces:** A.8.1

When the repository has no commit message convention, a commit message MUST have:

1. A summary line in the imperative mood ("Add", "Fix", "Remove", not "Added" or "Adds"), at most 72 characters, with no trailing period.
2. A blank line.
3. A body that explains why the change was made, wrapped at 72 characters. The body MAY be left out only when the summary already makes the reason obvious.

Trailer lines that the agent's tool requires (such as `Co-Authored-By:`) go at the end of the body.

```
Add worktree location rule to Article A

Agents created worktrees inside clones, where the clone location
check reported them as misplaced. A separate worktree root keeps
both tidy.
```

**Test:** for every commit an agent made, the first line is at most 72 characters and does not end with a period, and the second line is empty.
