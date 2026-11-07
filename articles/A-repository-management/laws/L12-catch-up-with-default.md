# A-L12 — Bring in the default branch's new commits

**Enforces:** A.9.2

To bring the default branch's new commits into the current branch, an agent MUST run:

```bash
git fetch origin
git merge origin/<default>
```

where `<default>` is the default branch. If a repository convention calls for rebasing instead, the agent runs `git rebase origin/<default>`.

If the merge or rebase stops with merge conflicts, the agent MUST:

1. Not resolve them by taking one side wholesale (`--ours`, `--theirs`, `-X ours`, `-X theirs`).
2. List the conflicting files to the user and ask how to proceed.

The agent MAY propose a resolution for each file, but MUST wait for the user before completing the merge or rebase. If the user asks it to stop, it runs `git merge --abort` or `git rebase --abort`.

[A-L04](L04-preserve-uncommitted-changes.md) still applies: the agent checks for uncommitted changes first.

**Test:** in a repository with no rebase convention, branches an agent updated show the default branch merged in, not rebased onto it.
