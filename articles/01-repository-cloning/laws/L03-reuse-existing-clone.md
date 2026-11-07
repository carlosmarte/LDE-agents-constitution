# I-L03 — Reuse an existing clone

**Enforces:** I.3.1

If `<canonical location>/.git` exists, the agent MUST:

1. Not run `git clone` for that repository.
2. Update it with `git fetch --all --prune`.
3. Run `git pull` only when the working tree has no uncommitted changes and the user's task needs the latest commits.

If the canonical location exists, is not empty, and is not a Git repository, the agent MUST stop and tell the user. It MUST NOT delete or overwrite it.

**Test:** each repository appears at most once on disk, and no directory beside a canonical location is named with a suffix such as `-2`, `-copy`, or `-old`.
