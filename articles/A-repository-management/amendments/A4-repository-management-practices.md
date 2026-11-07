# A4 — Add repository management practices

- **Date:** 2026-11-07
- **Status:** Adopted
- **Changes:** Adds Sections 6 to 12 (clauses A.6.1–A.12.3), laws A-L06 to A-L15, and procedures A-P03 to A-P06. Updates the Purpose. Adds the terms "Default branch", "Upstream", "Syncing", "Repository convention", "Conflict", "Worktree root", and "Agent-created worktree".

## Reason

After A3 made Article A the home for repository management, it still covered only cloning. Agents also create branches, commit, sync, push, make worktrees, and clean up, and each of those can lose work or surprise the user when done carelessly. This amendment sets one shared way to do each.

The rules were shaped with the `/critique-article` skill. The decisions were:

- **Repository conventions win, but conflicts pause.** Agents follow a repository's own written conventions. When one would break a clause of this Article, the agent stops and asks the user. With no user available, it skips the step and reports it.
- **Branches.** Agents ask before their first change on the default branch. Without a repository convention, names are `<type>/<kebab-description>`, matching existing branches such as `fix/claude-aliases-use-path`.
- **Commits.** Imperative summary of at most 72 characters plus a body explaining why, when the repository has no format. A secrets check before every commit.
- **Syncing.** Fast-forward only from a branch's upstream. Merge, not rebase, to bring in the default branch, unless the repository says otherwise. Merge conflicts pause.
- **Pushing.** Only the current branch, by name.
- **Worktrees.** Agent-created worktrees go under their own root, `/Users/Shared/agent/repos/worktree`, so the clone location check (A-P02) does not mistake them for clones. Tool-managed worktrees are exempt.
- **Cleanup.** Only merged branches and clean, merged agent-created worktrees may be removed. Clones are never removed.

## Deferred

This amendment covers how repository actions are done, not who may approve them. Two questions were set aside for a future article on approvals:

1. Who may approve shared actions, such as pushing, opening pull requests, and deleting remote branches, and whether approval can carry across sessions.
2. Whether destructive actions (force-push, `reset --hard`, rewriting pushed commits, `branch -D`, removing work with unsaved changes) need approval for each specific action.

The conflict pause in A.6.2 applies only to Article A. If every article should pause on conflicts, that rule belongs in a constitution-wide article.
