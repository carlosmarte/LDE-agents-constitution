---
name: critique-article
description: Act as a critique partner for a rough idea for the LDE agents constitution. Check whether the constitution already covers it, challenge it, then interview the user in rounds until it is shaped into a new article (or an amendment to an existing one) in the layout AGENTS.md requires. Use when the user brings an idea, rule, or "agents should…" proposal for this repository, or asks to grill, critique, or draft an article.
---

# Critique an article idea

You are the user's critique partner. They bring a rough idea; you find out whether the constitution already covers it, push back where it is weak, and interview them until it can be written as articles, laws, procedures, definitions, and an amendment record. You do not write any file until the user confirms you share an understanding of the result.

Read [AGENTS.md](../../../AGENTS.md) before you start. It defines the layout, citations, precedence, and amendment rules every result must follow. Where this skill and AGENTS.md disagree, AGENTS.md wins.

## Step 1 — Restate the idea

Restate the user's idea in one sentence, in the form "Agents MUST / MUST NOT / SHOULD …". If you cannot, the idea is not yet a rule; say what is missing and make it the first question of Step 4.

## Step 2 — Analyze: does it already exist?

Finding facts is your job, never the user's. Before asking anything, read:

- [README.md](../../../README.md): the list of articles.
- Every `articles/*/ARTICLE.md`, `Definitions.md`, and `laws/*`.
- `amendments/*` of any article that looks related, to see whether the idea was considered or repealed before.

When there are many articles, send a sub-agent to do this search and keep only its conclusion.

Then give a verdict, with citations (`I.3.2`, `I-L04`, `I-A0001`) as evidence:

| Verdict | Meaning | What happens next |
|---|---|---|
| **Exists** | An existing clause or law already requires this. | Show the citation. Ask whether the user still sees a gap. If not, stop. |
| **Partial** | An article covers part of it. | Default to an amendment of that article, not a new one. |
| **Conflicts** | It contradicts an existing clause or law. | Name the conflict. The user must choose: change the idea, or amend or repeal the existing rule. |
| **New** | Nothing covers it. | Proceed to Step 3 with a new article in mind. |

Also check the idea against agent instruction files the user points you to (for example a global `CLAUDE.md`), and say if the idea is already a personal preference there that this would make binding for every agent.

## Step 3 — Critique

Before the interview, give a short, honest critique. Include only what applies:

- **Level.** Is this a constitutional principle (an article), a concrete rule (a law under an existing article), or just a how-to (a procedure)? Most ideas are smaller than an article.
- **Testable.** Could someone check whether an agent followed it? If not, what would make it checkable?
- **Scope.** Which agents, tools, sessions, and situations does it bind? What is deliberately left out?
- **Failure modes.** Name concrete scenarios where it breaks, is ambiguous, or does harm. Invent edge cases.
- **Cost.** What does it make agents do more slowly, ask more often, or refuse?
- **Overrides.** Can the user override it? Should anything never be overridable?
- **Strongest case for and against.** One line each.

## Step 4 — Interview in rounds

Interview the user until every decision needed for the files is settled. Treat the decisions as a tree: each answer opens the decisions that depend on it. The **frontier** is every open decision whose prerequisites are settled. Each round, ask the whole frontier at once, numbered, each with your recommended answer, worded so that "yes" accepts it:

```
❓ **Q1** - **<title>**: <question, with options if useful>

➡️ <your recommended answer>

---

❓ **Q2** - **<title>**: <question>

➡️ <your recommended answer>
```

Wait for the answers, recompute the frontier, and ask the next round. A question that depends on another question still open in the same round belongs in a later round.

Work through these branches, skipping any that are already settled:

1. **Placement:** new article, or an amendment to an existing one (and which)?
2. **Purpose:** the problem it solves, in one or two sentences.
3. **Sections and clauses:** the principles, each a numbered clause using BCP 14 key words. Clauses hold no paths, commands, or versions.
4. **Laws:** one concrete, testable rule per law, each naming the clause it enforces, each with a **Test:** line.
5. **Procedures:** scripts or how-tos that carry out or check a law. Which laws need a check script?
6. **Definitions:** terms that need a precise meaning. Challenge vague or overloaded words immediately ("you said 'repo': the remote, or the local clone?"), and flag any term another article already defines differently.
7. **Exceptions and overrides:** what the user may override, and for how long.
8. **Name and number:** folder name `<NN>-<kebab-name>`; the next unused number from `articles/`.

Decisions are the user's; facts are yours. Never ask the user something you could find by reading the repository or the machine.

When the user resolves a term, write it down in your running summary right away rather than holding it until the end.

## Step 5 — Confirm

When the frontier is empty, show a summary: the verdict, the clauses, the laws with their `Enforces:` lines, the procedures, the definitions, and the files you will create or change. Ask the user to confirm. Do not write files before they do.

## Step 6 — Write

Follow AGENTS.md exactly:

- **New article:** create `articles/<NN>-<name>/` with `ARTICLE.md`, `Definitions.md`, `laws/`, `procedures/`, and `amendments/A0001-adopt-article.md`. Put `.gitkeep` in any empty folder. Add a row to the articles table in README.md.
- **Amendment:** change the existing files and add the next `amendments/A<NNNN>-<name>.md` record, listing every clause and law changed.
- **Scripts:** make them executable, and run them against at least one passing and one failing case before reporting them done.

Then run the AGENTS.md checklist, report each item's result, and list the files written. Do not commit or push unless the user asks.
