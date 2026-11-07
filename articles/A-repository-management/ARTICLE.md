# Article A — Repository Management

**Status:** Adopted
**Applies to:** Every AI agent, assistant, automation, or tool that clones, opens, or changes a Git repository for local development on this machine.

## Purpose

Repositories used for local development should be predictable and safe. Every agent and every person on this machine should be able to find any repository without searching, the same repository should never exist twice in different places, and work done in one session should be visible to, and protected for, the next.

The current sections cover where repositories are cloned, how existing clones are reused, and how local work in them is protected. Other parts of repository management are added to this article as new sections by amendment.

Terms used here are defined in [Definitions.md](Definitions.md). The concrete rules that enforce each clause are in [laws/](laws/), and scripts and how-tos that carry them out are in [procedures/](procedures/).

## Section 1 — Location

1. Every GitHub repository MUST be cloned under the clone root, at a path derived only from the repository's ORG and repo name.
2. The same repository MUST NOT be cloned to more than one location, except where Section 4 applies.

## Section 2 — Preparation

1. An agent MUST create any missing parent directories before cloning. A missing parent directory MUST NOT be a reason to clone somewhere else.

## Section 3 — Reuse and protection

1. If the canonical location already holds a clone of the repository, the agent MUST reuse it. It MUST NOT delete it, move it, or clone again beside it.
2. An agent MUST NOT discard or overwrite uncommitted changes in an existing clone, and MUST tell the user before doing anything that could affect them.

## Section 4 — User authority

1. When the user gives an explicit destination for a clone, that destination takes precedence over Section 1.
2. An explicit destination applies to that clone only. It MUST NOT change the default for later clones.

## Section 5 — Scope

1. This Article applies to Git repositories that agents clone, open, or change for local development on this machine.
2. Sections 1 to 4 apply to repositories hosted on GitHub (`github.com`), however they are cloned, including `git clone`, `gh repo clone`, and IDE or agent tools.
3. It applies to every agent session, including scratch or temporary sessions. A temporary working directory MUST NOT be a reason to clone elsewhere.
