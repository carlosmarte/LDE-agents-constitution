# AGENTS.md — Rules for editing this repository

This repository is the constitution for AI agents in this local development environment (LDE). Any AI agent that adds, changes, or reviews content here MUST follow this file. It covers how the constitution is **structured and written**. What the constitution requires of agents is in [README.md](README.md) and `articles/`.

Key words (MUST, MUST NOT, SHOULD, MAY) follow BCP 14 ([RFC 2119](https://www.rfc-editor.org/rfc/rfc2119) and [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174)): they carry these meanings only when written in capitals.

## 1. Required layout

Every article is a folder under `articles/`:

```
articles/
  <X>-<name>/
    ARTICLE.md        # the article: sections > clauses
    Definitions.md    # terms specific to this article
    laws/             # rules that enforce the article
    procedures/       # scripts and how-tos that guide, validate, and defend the laws
    amendments/       # record of how the article was added or changed
```

- `<X>` is the article's letter: one uppercase letter, `A` to `Z`, assigned in alphabetical order. A letter MUST NOT be reused or reassigned once used, even if the article is repealed.
- `<name>` is lowercase kebab-case, for example `A-repository-management`.
- All five entries MUST exist. An empty folder holds a `.gitkeep` file.
- Content MUST NOT be placed directly in `articles/` as loose files.

### The 26-article limit

The constitution is the base, not the rulebook. It MUST NOT grow past 26 articles, one per letter. The limit is deliberate: it keeps the base small enough for any agent to read in full, and it pushes detail into laws and procedures, where it belongs.

- Before adding an article, check whether the idea fits as a law or a clause in an existing article. Prefer that.
- Repealed articles keep their letter, so they count toward the 26.
- When all 26 letters are used, a new article is only possible by merging existing articles. A merge is recorded as an amendment of each article involved.

## 2. What goes where

| File / folder | Holds | MUST NOT hold |
|---|---|---|
| `ARTICLE.md` | The article's purpose, then **Sections** (`## Section N — Title`), each made of numbered **Clauses**. Principles and obligations that rarely change. | Implementation detail likely to change: paths, commands, versions. Those go in `laws/`. |
| `laws/` | One concrete, testable rule per file. Each law MUST name the clause it enforces. | Rules with no parent clause. |
| `procedures/` | Scripts, how-tos, and checks that carry out, validate, or defend a law. Each procedure MUST name the law(s) it serves. | New obligations. A procedure can only implement what a law already requires. |
| `amendments/` | One record per change to the article. | Edits to past records. Amendments are append-only. |
| `Definitions.md` | Terms used in this article that are not common usage or defined in BCP 14. | Redefinitions of BCP 14 key words or of terms another article already defines. |
| `CONSTITUTION.md` | Every `ARTICLE.md`, A to Z, in one generated file. | Hand edits. See [Section 5](#5-changing-the-constitution). |
| `scripts/` | Tooling for this repository itself. | Rules or procedures that bind agents. Those go in an article. |

## 3. Citations

Every rule MUST be traceable to the article it serves.

| Kind | File name | Cited as | Example |
|---|---|---|---|
| Article | `articles/<X>-<name>/ARTICLE.md` | `<X>` | `A` = Article A |
| Clause | — | `<X>.<section>.<clause>` | `A.3.2` = Article A, Section 3, Clause 2 |
| Law | `laws/L<NN>-<name>.md` | `<X>-L<NN>` | `A-L01` |
| Procedure | `procedures/P<NN>-<name>.<ext>` | `<X>-P<NN>` | `A-P01` |
| Amendment | `amendments/<X><n>-<name>.md` | `<X><n>` | `A1` = Article A's first amendment |

- A law's first line after the title MUST be `**Enforces:** <X>.<s>.<c>`.
- A how-to procedure starts with `**Implements:** <X>-L<NN>`; a script carries the same line as a comment near the top.
- Amendment numbers start at 1 and count up with no padding: `A1`, `A2`, … `A10`. The article's adoption is always `<X>1`.
- "Article A as of A3" means the article with amendments `A1` to `A3` applied.

## 4. Precedence

If two parts of an article disagree, the higher one wins and the lower one MUST be fixed:

1. `ARTICLE.md` (sections > clauses)
2. `laws/`
3. `procedures/`

`Definitions.md` governs the meaning of terms at every level.

## 5. Changing the constitution

To shape a rough idea into a new article or an amendment, follow [.claude/skills/critique-article/SKILL.md](.claude/skills/critique-article/SKILL.md) (`/critique-article` in Claude Code). It checks whether the constitution already covers the idea, then interviews the user before writing anything.

Every change to an `ARTICLE.md` or a law MUST include a new amendment record in the same commit, with:

```markdown
# <X><n> — <short title>

- **Date:** YYYY-MM-DD
- **Status:** Proposed | Adopted | Repealed
- **Changes:** <citations of clauses / laws added, changed, or removed>

## Reason
<why the change was needed>
```

- Adding a new article means taking the next unused letter, creating its folder with all five entries, an amendment `<X>1` that records its adoption, and a row in the articles table in [README.md](README.md).
- Typo and formatting fixes that do not change meaning do not need an amendment.
- Repealed articles and laws stay in place, marked `**Status:** Repealed`, so their citations still resolve.

### Rebuilding CONSTITUTION.md

`CONSTITUTION.md` is generated from every `ARTICLE.md` by `scripts/build-constitution.sh`. If it ever disagrees with an `ARTICLE.md`, the `ARTICLE.md` wins and the file MUST be rebuilt.

- Every change that adds, edits, or removes an `ARTICLE.md` MUST include the rebuilt `CONSTITUTION.md` in the same commit.
- `CONSTITUTION.md` MUST NOT be edited by hand. The next rebuild overwrites it.
- Run `scripts/build-constitution.sh` to rebuild it, and `scripts/build-constitution.sh --check` to confirm it is current without changing anything.
- In Claude Code, a hook in `.claude/settings.json` rebuilds it after each file edit or shell command. Other agents MUST run the script themselves.

## 6. Checklist before committing

- [ ] Every article folder has `ARTICLE.md`, `Definitions.md`, `laws/`, `procedures/`, `amendments/`.
- [ ] Every law has an `Enforces:` line pointing to a real clause.
- [ ] Every procedure has an `Implements:` line pointing to a real law.
- [ ] Every meaning-changing edit has a new amendment record.
- [ ] The README articles table lists every article.
- [ ] `scripts/build-constitution.sh --check` exits 0.
- [ ] There are at most 26 articles, each with its own letter.
- [ ] No article letter or citation number was reused or reassigned.
