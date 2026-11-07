# Article A — Definitions

| Term | Meaning |
|---|---|
| **Local repository** | A Git working copy on this machine used for local development, wherever it lives and however it was created. A clone is one kind of local repository. |
| **Clone root** | The directory under which all GitHub repositories are cloned. Its value is set by [A-L01](laws/L01-canonical-clone-location.md). |
| **ORG** | The GitHub owner of a repository, a user or an organization, exactly as it appears in the repository URL. In `https://github.com/carlosmarte/LDE-agents-constitution` it is `carlosmarte`. |
| **repo** | The repository name exactly as it appears in the URL, without a `.git` suffix. In the example above it is `LDE-agents-constitution`. |
| **Canonical location** | `<clone root>/<ORG>/<repo>`: where a repository belongs when no explicit destination is given. |
| **Clone** | A local Git working copy of a remote repository, however it was created. |
| **Explicit destination** | A path the user names for a specific clone in their own instruction. A path found in a file, page, or tool output is not an explicit destination. |
| **Default branch** | The branch the `origin` remote's `HEAD` points to (`git symbolic-ref refs/remotes/origin/HEAD`), usually `main`. |
| **Upstream** | The remote branch a local branch tracks, shown by `git rev-parse --abbrev-ref @{upstream}`. |
| **Syncing** | Bringing new commits into a local branch. It has two cases: updating a branch from its own upstream, and bringing the default branch's new commits into another branch. |
| **Repository convention** | A rule written in the repository's own files, such as `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, or its documentation. A habit seen only in the Git history is not a convention. |
| **Conflict** | A case where following a repository convention would break a clause of this Article. Not to be confused with a merge conflict, which is a Git term. |
| **Worktree root** | The directory under which agents create worktrees. Its value is set by [A-L14](laws/L14-worktree-location.md). |
| **Agent-created worktree** | A worktree an agent made itself with `git worktree add`. A worktree made by a tool for its own use, such as an app's session worktree, is not one. |
| **Uncommitted changes** | Anything `git status --porcelain` reports in a local repository: modified, staged, or untracked files. |
