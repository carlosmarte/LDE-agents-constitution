# A-L07 — Ask before changing the default branch

**Enforces:** A.7.1

Before its first file change in a task, an agent MUST compare the current branch with the default branch:

```bash
current=$(git branch --show-current)
default=$(git symbolic-ref --short refs/remotes/origin/HEAD | sed 's#^origin/##')
```

If they are equal, the agent MUST ask the user whether to:

- create a new branch, with a name following [A-L08](L08-branch-names.md), or
- stay on the default branch.

It MUST suggest a branch name in the question. It then follows the answer for every change in that task without asking again. If the user already named a branch for the task, the agent uses it and does not ask.

If `origin/HEAD` is not set, the agent MUST run `git remote set-head origin --auto` once. If the default branch is still unknown, it treats `main`, then `master`, as the default branch if that branch exists.

**Test:** no commit made by an agent on the default branch lacks a matching user choice to stay on it.
