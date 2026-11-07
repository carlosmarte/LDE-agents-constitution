# AGENTS.md — Rules for editing this repository

This repository is the constitution for AI agents in this local development environment (LDE). Any AI agent that adds, changes, or reviews content here MUST follow this file. It covers how the constitution is **structured and written**. What the constitution requires of agents is in [README.md](README.md) and `articles/`.

Key words (MUST, MUST NOT, SHOULD, MAY) follow BCP 14 ([RFC 2119](https://www.rfc-editor.org/rfc/rfc2119) and [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174)): they carry these meanings only when written in capitals.

## 1. Required layout

Every article is a folder under `articles/`:

```
articles/
  <NN>-<name>/
    ARTICLE.md        # the article: sections > clauses
    Definitions.md    # terms specific to this article
    laws/             # rules that enforce the article
    procedures/       # scripts and how-tos that guide, validate, and defend the laws
    amendments/       # record of how the article was added or changed
```

- `<NN>` is a two-digit number assigned in order (`01`, `02`, …). It MUST NOT be reused or renumbered once used, even if the article is repealed.
- `<name>` is lowercase kebab-case, for example `01-repository-cloning`.
- All five entries MUST exist. An empty folder holds a `.gitkeep` file.
- Content MUST NOT be placed directly in `articles/` as loose files.

## 2. What goes where

| File / folder | Holds | MUST NOT hold |
|---|---|---|
| `ARTICLE.md` | The article's purpose, then **Sections** (`## Section N — Title`), each made of numbered **Clauses**. Principles and obligations that rarely change. | Implementation detail likely to change: paths, commands, versions. Those go in `laws/`. |
| `laws/` | One concrete, testable rule per file. Each law MUST name the clause it enforces. | Rules with no parent clause. |
| `procedures/` | Scripts, how-tos, and checks that carry out, validate, or defend a law. Each procedure MUST name the law(s) it serves. | New obligations. A procedure can only implement what a law already requires. |
| `amendments/` | One record per change to the article. | Edits to past records. Amendments are append-only. |
| `Definitions.md` | Terms used in this article that are not common usage or defined in BCP 14. | Redefinitions of BCP 14 key words or of terms another article already defines. |

## 3. Citations

Every rule MUST be traceable to the article it serves.

- **Clause:** `<Article>.<Section>.<Clause>`, with the article as a Roman numeral matching its folder number (`01` = `I`) and section and clause in Arabic numerals, e.g. `I.3.2` = Article I, Section 3, Clause 2.
- **Law:** file name `laws/L<NN>-<name>.md`, cited as `I-L01`. Its first line after the title MUST be `**Enforces:** I.<s>.<c>`.
- **Procedure:** file name `procedures/P<NN>-<name>.<ext>`, cited as `I-P01`. A how-to starts with `**Implements:** I-L<NN>`; a script carries the same line as a comment near the top.
- **Amendment:** file name `amendments/A<NNNN>-<name>.md`, cited as `I-A0001`.

## 4. Precedence

If two parts of an article disagree, the higher one wins and the lower one MUST be fixed:

1. `ARTICLE.md` (sections > clauses)
2. `laws/`
3. `procedures/`

`Definitions.md` governs the meaning of terms at every level.

## 5. Changing the constitution

Every change to an `ARTICLE.md` or a law MUST include a new amendment record in the same commit, with:

```markdown
# A<NNNN> — <short title>

- **Date:** YYYY-MM-DD
- **Status:** Proposed | Adopted | Repealed
- **Changes:** <citations of clauses / laws added, changed, or removed>

## Reason
<why the change was needed>
```

- Adding a new article means creating its folder with all five entries, an amendment `A0001` that records its adoption, and a row in the articles table in [README.md](README.md).
- Typo and formatting fixes that do not change meaning do not need an amendment.
- Repealed articles and laws stay in place, marked `**Status:** Repealed`, so their citations still resolve.

## 6. Checklist before committing

- [ ] Every article folder has `ARTICLE.md`, `Definitions.md`, `laws/`, `procedures/`, `amendments/`.
- [ ] Every law has an `Enforces:` line pointing to a real clause.
- [ ] Every procedure has an `Implements:` line pointing to a real law.
- [ ] Every meaning-changing edit has a new amendment record.
- [ ] The README articles table lists every article.
- [ ] No citation number was reused or renumbered.
