# Article I — Repository Cloning

**Status:** Adopted
**Applies to:** Every AI agent, assistant, automation, or tool that clones a Git repository from GitHub on this machine.

## Purpose

Every agent and every person on this machine should be able to find any cloned repository without searching. The same repository should never be cloned twice in different places, and work done in one session should be visible to the next.

Terms used here are defined in [Definitions.md](Definitions.md). The concrete rules that enforce each clause are in [laws/](laws/), and scripts and how-tos that carry them out are in [procedures/](procedures/).

## Section 1 — One location

1. Every GitHub repository MUST be cloned under the clone root, at a path derived only from the repository's ORG and repo name.
2. The same repository MUST NOT be cloned to more than one location, except where Section 4 applies.

## Section 2 — Preparation

1. An agent MUST create any missing parent directories before cloning. A missing parent directory MUST NOT be a reason to clone somewhere else.

## Section 3 — Reuse

1. If the canonical location already holds a clone of the repository, the agent MUST reuse it. It MUST NOT delete it, move it, or clone again beside it.
2. An agent MUST NOT discard or overwrite uncommitted changes in an existing clone, and MUST tell the user before doing anything that could affect them.

## Section 4 — User authority

1. When the user gives an explicit destination for a clone, that destination takes precedence over Section 1.
2. An explicit destination applies to that clone only. It MUST NOT change the default for later clones.

## Section 5 — Scope

1. This Article applies to repositories hosted on GitHub (`github.com`).
2. It applies to every means of cloning, including `git clone`, `gh repo clone`, and IDE or agent tools.
3. It applies to every agent session, including scratch or temporary sessions. A temporary working directory MUST NOT be a reason to clone elsewhere.
