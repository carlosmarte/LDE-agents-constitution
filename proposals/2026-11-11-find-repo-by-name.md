# Finding a repository by its name alone

- **Author:** Carlos Marte
- **Date:** 2026-11-11
- **Status:** Open
- **Affects:** Article A, Sections 1 and 3 (Location; Reuse and protection), and possibly a new law next to [A-L01](../articles/A-repository-management/laws/L01-canonical-clone-location.md) and [A-L03](../articles/A-repository-management/laws/L03-reuse-existing-clone.md).

## Idea

A user should be able to name a repository, such as "work on `LDE-agents-constitution`", without giving a URL or a path, and any agent should be able to find the one existing copy and work there. When several agents work on the same project, they all end up in the same clone, not in copies of their own.

## What the constitution already covers

Article A already covers most of the cloning half:

- **Location:** every GitHub repository is cloned to `<clone root>/<ORG>/<repo>` ([A-L01](../articles/A-repository-management/laws/L01-canonical-clone-location.md)), so the place is known before the clone happens and never depends on the agent's current directory.
- **No duplicates:** an existing clone MUST be reused, never cloned again beside it ([A-L03](../articles/A-repository-management/laws/L03-reuse-existing-clone.md)).
- **Overrides:** a path the user names wins for that one clone only ([A-L05](../articles/A-repository-management/laws/L05-explicit-destination.md)).

What is missing is the other direction: going from a bare repository name to that location. The canonical path needs the ORG, and a user who says only the repository name has not given it.

## Draft rule to discuss

When the user names a repository without an ORG or URL, the agent:

1. Looks for `<clone root>/*/<repo>` (matching the name exactly, then ignoring letter case).
2. If exactly one match is found, works there and says which path it used.
3. If several match (the same name under two ORGs), lists them and asks the user which one.
4. If none match, asks the user for the ORG or URL, then clones to the canonical location. It does not guess the ORG and does not search the rest of the disk.

## Why

- Autonomous agents and parallel sessions often start from a temporary or unrelated folder. Without a lookup rule, each one may clone a fresh copy where it happens to be, and work gets split across copies.
- One copy per repository means one set of branches, one set of uncommitted changes, and no question of which copy is current.
- Saying only the repository name is how people actually talk about their projects. The rule makes that enough.

## Open questions

- Should a lookup also cover clones placed somewhere else by an explicit destination ([A-L05](../articles/A-repository-management/laws/L05-explicit-destination.md))? If so, how do agents find them: a small index file under the clone root, or a recorded list?
- Should agents be allowed a short name or nickname for a repository (for example "the constitution"), and where would those names be kept?
- What about repositories not hosted on GitHub? A-L01 covers `github.com` only. Should the pattern become `<clone root>/<host>/<ORG>/<repo>`?
- When two agents work in the same clone at the same time, should each take its own worktree ([A-L14](../articles/A-repository-management/laws/L14-worktree-location.md)) so they don't change the same files?
- The clone root is a path on this one machine. Does a team need it to be the same on every machine, or only the pattern under it?
- How do agents other than Claude Code learn the rule: this constitution alone, or also a line in each agent's own instructions file?

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
