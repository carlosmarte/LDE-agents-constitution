# Anti-pattern rules

- **Author:** Carlos Marte
- **Date:** 2026-11-11
- **Status:** Open
- **Affects:** the layout in [AGENTS.md](../AGENTS.md) (Sections 1 to 3), and possibly a new article on writing prompts and instructions for agents.

## Idea

Give the constitution a standard way to record **anti-patterns**: practices that used to be common or recommended but are now known to be outdated, unhelpful, or harmful. Each one says what to stop doing, why, and what to do instead. Agents check their own output against the list, and people can point to it in reviews.

The first use is prompting. Agents write prompts all the time: for subagents, in `CLAUDE.md` and `AGENTS.md` files, in skills, and in scheduled tasks. Phrases that helped older models can make current models worse.

## Candidate prompting anti-patterns

These are examples for the meeting to accept, change, or drop.

| Anti-pattern | Why it is legacy | Use instead |
|---|---|---|
| "Think harder", "think step by step", "be more thorough" | Current models reason on their own, and how much they think is set by the model's effort or thinking settings, not by urging. Vague urging adds length, not quality. | Say what "thorough" means here: which files to check, which cases to cover, what to verify before finishing. Raise the effort setting if more reasoning is needed. |
| Shouting: "IMPORTANT", "CRITICAL", "YOU MUST", repeated capitals | Newer models follow instructions closely. Heavy emphasis makes them over-apply a rule in places it was not meant for. | State the rule once, plainly, with the reason. Keep capitals for BCP 14 key words, as this repository already does. |
| Threats and rewards: "I'll tip you", "or you'll be fired", "my job depends on this" | No reliable benefit, and it adds noise. | Explain the real stakes: who uses the result and what goes wrong if it is wrong. |
| "Don't hallucinate", "don't make mistakes" | Gives the model nothing to act on. | Say what to do when unsure: cite the source, say "I don't know", or ask. |
| Bare negative lists: "don't use X, don't do Y" with no alternative | The model knows what to avoid but not what to do. | Say what to do, and give the reason for any limit. |
| Generic role lines: "You are a world-class expert" | Adds little on its own. | Describe the actual task, the audience, and the context. |
| Asking for hidden reasoning in a fixed format ("put your thinking in `<thinking>` tags") when the model has built-in thinking | Duplicates what the model already does, and costs tokens. | Use the model's thinking feature, and ask only for the output you need. |

## How anti-patterns could be recorded

Options to choose from:

1. **A folder per article:** add `anti-patterns/` as a sixth entry in each article folder, cited as `<X>-AP<NN>`, like laws. Each one names the clause it serves.
2. **Laws phrased as MUST NOT:** no new structure. An anti-pattern is just a law, such as `C-L03 — No urging phrases in prompts`.
3. **One catalog at the root:** an `ANTI-PATTERNS.md` file, grouped by topic, each entry linked to the clause it supports.

Each entry would have the same fields:

- **Pattern:** what to stop doing, with example wording.
- **Why:** what goes wrong, and since when (for example, which model generation made it outdated).
- **Instead:** what to do.
- **Applies to:** where the rule is checked, for example prompts, skills, `CLAUDE.md` files, or commit messages.

## Why

- Prompting advice changes with each model generation. Without a record, old habits keep getting copied from old prompts and templates.
- A named, dated list lets a reviewer say "that's `AP03`" instead of re-arguing the point each time.
- Agents that write prompts for other agents can check their own drafts against the list.

## Open questions

- Which recording option above, or another?
- Is an anti-pattern binding (MUST NOT) or advice (SHOULD NOT)?
- Prompting anti-patterns change with each model generation. Who reviews the list, and how often? Should each entry name the models it applies to?
- Should agents fix anti-patterns they find in existing files, or only avoid adding new ones?
- Beyond prompting, which other topics would use this, for example Git habits, dependency management, or testing?
- Does prompting guidance need its own article, or does it fit under an existing one?

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
