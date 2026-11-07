# A-L08 — Branch names

**Enforces:** A.7.2

When the repository has no branch naming convention, a new branch name MUST be:

```
<type>/<description>
```

- `<type>` is one of: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`.
- `<description>` is lowercase kebab-case: letters `a-z`, digits, and single hyphens, starting with a letter or digit, at most 50 characters.

| Valid | Not valid |
|---|---|
| `fix/claude-aliases-use-path` | `fix/Claude_Aliases` (uppercase, underscore) |
| `docs/repository-management` | `feature/login` (`feature` is not a type) |
| `feat/add-worktree-script` | `fix/` (no description) |

This law covers names agents choose. A name the user gives is used as given.

**Test:** [A-P03](../procedures/P03-check-branch-name.sh) exits 0 for every branch an agent created.
