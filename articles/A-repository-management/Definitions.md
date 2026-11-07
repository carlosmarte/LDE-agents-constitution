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
| **Uncommitted changes** | Anything `git status --porcelain` reports in a local repository: modified, staged, or untracked files. |
