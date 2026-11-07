# A-L11 — Update a branch from its upstream

**Enforces:** A.9.1

To update the current branch from its upstream, an agent MUST run:

```bash
git pull --ff-only
```

If Git reports that the branch cannot be fast-forwarded (the local and remote branches have both moved), the agent MUST stop and tell the user. It MUST NOT retry with `--rebase`, `--no-ff`, or a plain `git pull`.

[A-L04](L04-preserve-uncommitted-changes.md) still applies: the agent checks for uncommitted changes before pulling.

**Test:** no merge commit made by an agent has the same branch's upstream as its second parent.
