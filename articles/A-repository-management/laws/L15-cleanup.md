# A-L15 — Cleanup

**Enforces:** A.12.1, A.12.2, A.12.3

Before removing anything, an agent MUST list what is safe to remove and what must stay, for example with [A-P06](../procedures/P06-cleanup-report.sh). It decides using the default branch after `git fetch origin --prune`.

**A local branch may be removed only if all of these hold:**

1. It is not the default branch and is not checked out in any worktree.
2. It is fully merged into `origin/<default>` (`git branch --merged origin/<default>` lists it).

It is removed with `git branch -d <branch>`. The agent MUST NOT use `git branch -D`, which deletes unmerged work.

**An agent-created worktree may be removed only if all of these hold:**

1. It is under the worktree root ([A-L14](L14-worktree-location.md)).
2. Its branch is fully merged into `origin/<default>`.
3. `git status --porcelain` inside it prints nothing.

It is removed with `git worktree remove <path>`, without `--force`, followed by `git worktree prune`.

**Never removed by cleanup:** a clone, a worktree outside the worktree root, and the default branch.

Everything that fails a condition MUST be listed to the user with the reason: unmerged, unpushed commits, uncommitted changes, or checked out.

**Test:** after cleanup, every removed branch was reachable from `origin/<default>`, and no removed worktree had uncommitted changes.
