# A3 — Broaden Article A to Repository Management

- **Date:** 2026-11-07
- **Status:** Adopted
- **Changes:** Retitles the article from "Repository Cloning" to "Repository Management" and renames its folder to `A-repository-management`. Rewrites the Purpose and "Applies to" line. Retitles Sections 1 and 3. Amends A.5.1 and A.5.2. Adds the term "Local repository" and widens "Uncommitted changes" to any local repository.

## Reason

Cloning is only one part of managing repositories for local development. Branches, commits, pushing, syncing, worktrees, and cleanup also need shared rules. Rather than spend a new letter on each, Article A becomes the home for all repository management, and those topics are added to it as new sections.

## Effect on existing rules

No obligation changed. Every clause keeps its number, so citations such as `A.3.2` and `A-L04` still point to the same rule.

- **A.5.1** previously limited the whole article to repositories hosted on GitHub. It now covers every Git repository agents clone, open, or change for local development.
- **A.5.2** keeps the cloning rules (Sections 1 to 4) limited to GitHub repositories, and folds in the old clause's list of cloning tools.
