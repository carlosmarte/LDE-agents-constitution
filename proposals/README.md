# Proposals

A place to write down ideas, comments, and draft sections for the constitution before anyone decides on them. Each note is brought to a group meeting, where the group decides which parts to apply and which articles they belong in.

Nothing in this folder is in force. Agents MUST NOT treat a proposal as part of the constitution, whatever it says.

## Adding a note

1. Copy [TEMPLATE.md](TEMPLATE.md) to `proposals/YYYY-MM-DD-<short-name>.md`, using today's date and a lowercase kebab-case name, for example `2026-11-11-commit-signing.md`.
2. Fill in the idea and why it matters. Rough notes are fine; a note does not need to be finished to be discussed.
3. Under **Affects**, name where you think it belongs: a clause (`A.3.2`), a law (`A-L07`), an article (`A`), or `new article`. Write `unsure` if you don't know yet; the meeting can decide.
4. Set **Status** to `Open`.

## Status

| Status | Meaning |
|---|---|
| `Open` | Written down, not yet discussed. |
| `Discussed` | Talked about in a meeting, with no final decision yet. |
| `Accepted` | The group agreed to apply all or part of it. |
| `Declined` | The group decided not to apply it. |

These are deliberately different from the `Proposed`, `Adopted`, and `Repealed` statuses of amendments. A proposal here is only a note; it becomes a real change only through an amendment.

## After a meeting

- Add the meeting's date and outcome under **Discussion**, and update **Status**.
- For each accepted part, make the change the usual way: follow [AGENTS.md](../AGENTS.md) and write an amendment, or use `/critique-article` in Claude Code to shape it first. Then list the amendment under **Outcome**, for example `A7`.
- Keep accepted and declined notes here, so the reasons for past decisions stay easy to find.
