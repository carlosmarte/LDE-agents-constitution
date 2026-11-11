---
name: manage-article-archive
description: Archive one article of the LDE agents constitution, given its letter or folder name. Moves it to a timestamped folder under .archived/, amends whatever in force depends on it, and rebuilds CONSTITUTION.md. Use when the user wants to archive, shelve, or set aside an article without repealing it.
---

# Archive an article

The user names an article; you take it out of force and keep it under `.archived/`. You change nothing until the user confirms the plan in Step 3.

Read the "Archiving an article" part of [AGENTS.md](../../../AGENTS.md) before you start. It sets the rules for the result. Where this skill and AGENTS.md disagree, AGENTS.md wins.

## Step 1 — Identify the article

Find the one folder `articles/<X>-<name>/` that matches the letter or name the user gave. Stop and tell the user if:

- No folder matches, or more than one does. If it is already under `.archived/`, say so.
- It is the only folder under `articles/`. `scripts/build-constitution.sh` fails when there are no articles.
- The user wants it withdrawn for good and its citations kept in place. That is a repeal, which AGENTS.md handles differently.

Run `git status --porcelain` and report any uncommitted changes in the files you would touch. Never discard them. Follow Article A on branches: on the default branch, ask whether to create a new branch or stay.

## Step 2 — Find what depends on it

Search everything outside the article's own folder, replacing `<X>` and `<name>`:

```
git grep -nwE '<X>-<name>|Article <X>|<X>-[LP][0-9]{2}|<X>\.[0-9]+\.[0-9]+|<X>[0-9]+' -- ':!articles/<X>-<name>' ':!CONSTITUTION.md'
```

Read each match and sort it:

| Kind | Where | What happens |
|---|---|---|
| In force | Another article's `ARTICLE.md`, `Definitions.md`, laws, or procedures | Must change, by amendment of that article. |
| Description | `README.md`, `PROPOSAL.md`, `AGENTS.md`, skills | Must stop describing the article as active. |
| Record | `amendments/*`, `.archived/*` | Left alone. Amendments are append-only. |

Discard false matches. Short patterns such as `<X>1` can match unrelated text.

For each in-force match, check `git log -p` for the amendment that added it. If a pointer was added after the text already worked, the fix is to restore the earlier text. If a rule cannot stand without the article, the fix is the user's decision.

## Step 3 — Confirm

Show the user:

- the folder that will move and the form of its new name
- each dependent file and the change it needs
- each amendment you will add, by number
- any rule that becomes undecided or weaker once the article is gone

Ask the user to confirm, and to decide anything marked as theirs. Do not continue until they do.

## Step 4 — Move the folder

```
ts="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p .archived
git mv "articles/<X>-<name>" ".archived/<X>-<name>-$ts"
```

Do not edit the moved files, including links that no longer resolve.

## Step 5 — Update what depended on it

- **Other articles:** make the changes from Step 3, and add the next `amendments/<Y><n>-<name>.md` to each article changed, in the format AGENTS.md requires. Its reason MUST link to the article's new location, since older records still cite the old one.
- **README.md:** remove the article's row from the articles table, and fix any text that relies on the article.
- **Other descriptions:** make the changes from Step 3.
- If `.archived/README.md` is missing, create it saying nothing in that folder is in force, whatever an archived file's `Status:` line says.

## Step 6 — Rebuild and verify

Run `scripts/build-constitution.sh`, then confirm:

- `scripts/build-constitution.sh --check` exits 0, and `CONSTITUTION.md` no longer has the article.
- The Step 2 search now returns only records.
- `git status` shows the article's files as renames, with nothing lost.
- Every item of the AGENTS.md checklist holds.

## Step 7 — Report

Report the new location, every file changed, each amendment added, and anything now undecided. Say that the article's letter is free for the next new article. Do not commit or push unless the user asks.
