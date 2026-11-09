# B-L05 — Approval records

**Enforces:** B.5.1, B.5.2

**Before** each shared or destructive action, the agent MUST state the exact action, for example:

> Pushing `feat/add-worktree-script` to `origin` (approved: "commit and push").

**At the end** of the task, the agent's final report MUST include a section listing each shared or destructive action it took:

| Action | Approval |
|---|---|
| `git push origin feat/add-worktree-script` | User, this task: "commit and push" |
| `gh pr create` | Standing: `~/.claude/CLAUDE.md` line 14, `open-pr: carlosmarte/*` |
| `git branch -D feat/old-spike` | User, this task, after loss was stated: "yes, delete it" |

Each approval is either a short quote of the user's words, or the file and line of a standing approval. If the task took no shared or destructive action, the report says so in one line.

Templates are in [B-P01](../procedures/P01-approval-messages.md).

**Test:** every shared or destructive action visible in the transcript appears in the final report's list, with an approval.
