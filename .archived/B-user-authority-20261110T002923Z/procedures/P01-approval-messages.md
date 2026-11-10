# B-P01 — Approval message templates

**Implements:** B-L03, B-L05, B-L07

Copy the template that fits, fill in the angle brackets, and send it before acting. Keep each message short; the user should be able to answer with "yes" or "no".

## Shared action, not yet approved

> I'm about to `<exact command>` (`<action name>` on `<target>`). Nothing in this task or your standing approvals covers it. Go ahead?

## Shared action, already approved

> `<exact command>` (approved: "`<user's words>`" | standing: `<file>:<line>`).

## Destructive action

> I'm about to `<exact command>`. This will permanently lose:
> - `<item 1, e.g. 2 commits on feat/old-spike: abc1234 "…", def5678 "…">`
> - `<item 2>`
>
> Recovery: `<how, or "not recoverable">`. Go ahead with this one action?

## Override

> You've asked me to `<action>`, which `<clause, e.g. A.3.1>` forbids. Risk: `<one or two sentences>`. This override covers this one action only. Go ahead?

## Final report section

```markdown
### Shared and destructive actions

| Action | Approval |
|---|---|
| `<exact command>` | User, this task: "<quote>" |
| `<exact command>` | Standing: `<file>:<line>`, `<entry>` |
```

If there were none: `No shared or destructive actions were taken.`

## Unattended run report section

```markdown
### Waiting for approval

| Action | Why it needs approval |
|---|---|
| `<exact command>` | <shared, not covered by a standing approval> / <destructive> |
```
