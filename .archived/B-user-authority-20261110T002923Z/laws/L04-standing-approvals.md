# B-L04 — Standing approvals

**Enforces:** B.2.1, B.6.2

Standing approvals are read only from user-level instruction files:

- `~/.claude/CLAUDE.md`
- `~/.codex/AGENTS.md`
- The user-level instruction file of whichever agent tool is running, if it has one.

In those files, standing approvals are the list items under a heading named exactly `## Standing approvals`, up to the next heading. Each entry is one line:

```
- <action>: <ORG>/<repo pattern> [<branch pattern>]
```

- `<action>` is a name from the table in [B-L02](L02-shared-actions.md).
- `<ORG>/<repo pattern>` and `<branch pattern>` may use `*` as a wildcard. Without a branch pattern, the entry covers every branch except the default branch.
- To cover the default branch, name it: `- push: carlosmarte/* main`.

```markdown
## Standing approvals

- push: carlosmarte/* feat/*
- push: carlosmarte/* fix/*
- open-pr: carlosmarte/*
```

An entry naming a destructive action, or an action not in [B-L02](L02-shared-actions.md), MUST be ignored, and the agent SHOULD tell the user it ignored it.

**Test:** [B-P02](../procedures/P02-list-standing-approvals.sh) lists the same approvals the agent relied on, and reports destructive or unknown entries as ignored.
