# I-L04 — Preserve uncommitted changes

**Enforces:** I.3.2

Before any command that could change files in an existing clone (`pull`, `checkout`, `switch`, `reset`, `rebase`, `merge`, `stash`, `clean`), the agent MUST run `git status --porcelain`. If it prints anything, the agent MUST:

1. Not run `git reset --hard`, `git clean`, `git checkout -- <path>`, or `git stash` on its own initiative.
2. Tell the user which clone has uncommitted changes, and wait for their instruction before continuing with anything that could affect them.

`git fetch` changes no working files and MAY always run.

**Test:** the uncommitted changes reported before an agent's work are still present afterwards, unless the user approved changing them.
