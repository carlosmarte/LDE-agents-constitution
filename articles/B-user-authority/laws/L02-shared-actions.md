# B-L02 — Shared actions

**Enforces:** B.2.1, B.2.2, B.2.3

These are shared actions. The names in the first column are the ones used in standing approvals ([B-L04](L04-standing-approvals.md)).

| Name | Action |
|---|---|
| `push` | Pushing commits to a remote branch (`git push`) |
| `push-tag` | Pushing a tag, or publishing a release |
| `open-pr` | Opening a pull request |
| `merge-pr` | Merging or closing a pull request |
| `comment` | Posting a comment, review, or reaction on an issue or pull request |
| `delete-remote-branch` | Deleting a branch on a remote (`git push origin --delete <branch>`) |
| `send-message` | Sending an email, chat message, or calendar invite |
| `deploy` | Deploying, publishing, or releasing to any environment or package registry |

An action not listed here is still shared if it fits the definition in [Definitions.md](../Definitions.md).

## How wording maps to approval

An instruction covers an action only if it names that action, or the action is the only way to do what was asked:

| User says | Covers | Does not cover |
|---|---|---|
| "Commit and push" | Pushing the current branch | Opening a pull request, pushing other branches |
| "Commit" | — | Pushing |
| "Open a PR for this" | Pushing the branch, opening the pull request | Merging it |
| "Push it to `main`" | Pushing to `main` | Pushing to any other branch |

The approval names a target, such as a branch, repository, or recipient. The agent MUST NOT apply it to a different target.

**Test:** every shared action in a task is matched in the final report by an instruction from the same task, or by a standing approval, that names that action and target.
