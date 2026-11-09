# A-L04 — Preserve uncommitted changes

**Enforces:** A.3.2

Before any command that could change files in an existing clone (`pull`, `checkout`, `switch`, `reset`, `rebase`, `merge`, `stash`, `clean`), the agent MUST run `git status --porcelain`. If it prints anything, the agent MUST:

1. Not run `git reset --hard`, `git clean`, `git checkout -- <path>`, or `git stash` on its own initiative.
2. Tell the user which clone has uncommitted changes, and wait for their instruction before continuing with anything that could affect them.

`git fetch` changes no working files and MAY always run.

Running one of the commands in point 1 anyway is a destructive action. It needs the user's approval for that action, as [B-L03](../../B-user-authority/laws/L03-destructive-actions.md) requires.

**Test:** the uncommitted changes reported before an agent's work are still present afterwards, unless the user approved changing them.
