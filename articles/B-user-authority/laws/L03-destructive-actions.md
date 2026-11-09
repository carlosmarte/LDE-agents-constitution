# B-L03 — Destructive actions

**Enforces:** B.3.1, B.3.2, B.3.3, B.4.1

These are destructive actions:

| Action | What it can lose or expose |
|---|---|
| Force-push (`git push --force`, `--force-with-lease`, `+<refspec>`) | Commits on the remote that others may rely on |
| `git reset --hard` | Uncommitted changes, and commits not on another branch |
| Amending, rebasing, or squashing commits that are already pushed | The pushed history others may have built on |
| `git branch -D` | Commits that exist only on that branch |
| `git worktree remove --force` | Uncommitted changes in the worktree |
| `git clean -f`, `git checkout -- <path>`, `git restore <path>`, `git stash drop`, `git stash clear` | Uncommitted or stashed changes |
| Deleting a clone, a repository, or files outside a scratch directory | Everything not saved elsewhere |
| Dropping or truncating a database, deleting cloud resources | Data not backed up |
| Committing past a secrets warning ([A-L10](../../A-repository-management/laws/L10-secrets-check.md)) | The secret, once pushed |

## Asking for approval

Before a destructive action, the agent MUST send the user a message that states:

1. The exact command or action.
2. Exactly what will be lost: the commits, files, branches, or data, by name and count.
3. Whether any of it can be recovered, and how.

It then waits for the user's approval of that action. Approval covers that one action only. A later destructive action needs its own message and approval, even in the same task.

These never approve a destructive action: a standing approval, a general instruction such as "clean up", "fix it", or "do whatever it takes", or an approval of a different destructive action. A tool permission prompt approves it only if the message above came first.

## When unsure

If the agent cannot tell whether an action is destructive, it MUST treat it as destructive. If it cannot tell whether an action is shared, it MUST treat it as shared.

**Test:** in the transcript, every destructive action is preceded by a message containing the three points above and a user reply approving it.
