# I-A0001 — Adopt Article I, Repository Cloning

- **Date:** 2026-11-07
- **Status:** Adopted
- **Changes:** Adds clauses I.1.1–I.5.3, laws I-L01–I-L05, procedures I-P01–I-P02.

## Reason

Agents cloned repositories into whatever directory their session happened to start in, so the same repository could end up in several places and later sessions could not find earlier work. This article gives every GitHub clone one predictable location at `/Users/Shared/agent/repos/clone/<ORG>/<repo>`.

The rule was first committed as a single file, `articles/01-repository-cloning.md` (commit `d615a96`). This record covers its adoption in the article layout defined by [AGENTS.md](../../../AGENTS.md); the rules themselves did not change.
