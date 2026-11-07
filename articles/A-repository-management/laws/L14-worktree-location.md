# A-L14 — Worktree location

**Enforces:** A.11.1, A.11.2

The worktree root is:

```
/Users/Shared/agent/repos/worktree
```

An agent-created worktree MUST be at:

```
/Users/Shared/agent/repos/worktree/<ORG>/<repo>/<branch>
```

- `<ORG>` and `<repo>` come from the `origin` remote, exactly as [A-L01](L01-canonical-clone-location.md) derives them.
- If the repository has no `origin` remote, `<ORG>` is `local` and `<repo>` is the name of the repository's directory.
- `<branch>` is the branch name with every `/` replaced by `-`. For example, `fix/login-timeout` becomes `fix-login-timeout`.

The agent MUST create missing parent directories, as [A-L02](L02-create-parent-directories.md) requires for clones. If the path already holds a worktree, the agent reuses it.

Worktrees that a tool creates for its own use, such as an app's per-session worktree, are not agent-created and MAY live wherever that tool puts them.

**Test:** `git worktree list` in each clone shows every agent-created worktree under the worktree root, at the path above. [A-P05](../procedures/P05-create-worktree.sh) creates worktrees this way.
