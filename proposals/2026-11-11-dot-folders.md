# Standard dot folders in a repository

- **Author:** Carlos Marte
- **Date:** 2026-11-11
- **Status:** Open
- **Affects:** unsure. Possibly a new section in Article A (Repository Management), next to Section 6 (Repository conventions), or a new article on repository layout.

## Idea

Agree on a shared set of dot folders (folders whose names start with `.`) that a repository may have, what each one is for, and whether its contents are committed or ignored by Git. Agents would then use the same folders for the same purposes in every repository, and would create them the same way when they are missing.

A first list to discuss:

| Folder | Purpose | In version control? |
|---|---|---|
| `.output/` | Reports, build results, test and coverage output, generated artifacts. Anything that can be produced again. | No. Ignored. |
| `.agents/` | Work an agent creates while on a task: plans, notes, logs, intermediate files. One subfolder per agent or session, for example `.agents/claude/`. | Open question. Maybe ignored, with a committed `README.md` explaining the layout. |
| `.ci/` | Scripts and settings for continuous integration that are not tied to one CI provider. | Yes. |
| `.archived/` | Material set aside but kept for reference, as this repository already does for articles. | Yes. |
| `.scratch/` | Throwaway files for quick experiments. Safe to delete at any time. | No. Ignored. |
| `.cache/` | Caches for tools and downloaded dependencies. | No. Ignored. |
| `.env` (file) | Local secrets and environment settings. | No. Never committed; a committed `.env.example` shows the expected keys. |

Folders that a tool already owns keep that tool's rules and are not renamed: for example `.github/`, `.vscode/`, `.devcontainer/`, `.claude/`, `.husky/`.

## Why

- Without a shared list, each person and each agent invents its own places for reports, logs, and temporary files. Repositories end up with `out/`, `tmp/`, `reports/`, `.temp/`, and similar folders that all mean the same thing.
- Agents produce many files that should not be committed. If there is a known place for them, already listed in `.gitignore`, they stay out of commits and don't clutter the repository.
- A team that knows the structure can find an agent's reports and artifacts without asking, and agents can follow and create the same structure without being told each time.

## Open questions

- Which folders are on the standard list, and which are optional?
- For each folder: committed, ignored, or partly committed (for example a committed `README.md` inside an ignored folder)?
- Should agent work go in one shared `.agents/` folder, in one subfolder per agent, or in one subfolder per session or task?
- Should agents add missing entries to `.gitignore` themselves, or ask first?
- What should an agent do when a repository already uses a different name for the same purpose, such as `reports/` in place of `.output/`? Article A Section 6 already says to follow the repository's own conventions.
- Do the folders live only at the repository root, or can they also appear inside subprojects of a monorepo?
- How does an agent learn a repository's layout: from this constitution, from a file in the repository, or both?
- Who cleans up `.output/`, `.scratch/`, and `.agents/`, and when? This may relate to Article A Section 12 (Cleanup).

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
