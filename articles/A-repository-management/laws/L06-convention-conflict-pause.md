# A-L06 — Pause on a convention conflict

**Enforces:** A.6.1, A.6.2, A.6.3

Before changing a repository, an agent MUST read whichever of these exist at the repository root: `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, `.github/CONTRIBUTING.md`, and `docs/CONTRIBUTING.md`. The rules written there are the repository's conventions.

When a convention would break a clause of this Article, the agent MUST stop before the step that would break it and send the user a message that:

1. Quotes the convention and names the file it came from.
2. Cites the clause it would break, for example `A.10.1`.
3. Says what the agent will do under each choice, and asks which one to follow.

The agent MUST NOT act on the conflicting step until the user answers. The answer covers that conflict for the rest of the task.

In a run where no user can answer (CI, a scheduled job, or a background agent), the agent MUST skip the conflicting step, complete any other work that does not depend on it, and put the same three points in its final report.

**Test:** in the agent's transcript or report, every step where a convention and a clause disagreed is preceded by a message containing the three points above.
