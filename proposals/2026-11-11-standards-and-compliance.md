# Standards and compliance

- **Author:** Carlos Marte
- **Date:** 2026-11-11
- **Status:** Open
- **Affects:** unsure. Possibly a new article, or a new section in Article A next to Section 6 (Repository conventions) and Section 8 (Commits).

## Idea

Decide which standards agents must follow in every project, and how an agent shows that its work complies, so that "done" means the same thing whichever agent did the work.

The note is deliberately broad, as a starting point for the meeting. Areas to consider:

| Area | Examples of what a standard could say |
|---|---|
| Security | No secrets in commits (already [A-L10](../articles/A-repository-management/laws/L10-secrets-check.md)); dependency vulnerability checks; no disabling of security tooling to make a build pass. |
| Licensing | Check the license of any new dependency or copied code; keep `LICENSE` and third-party notices current. |
| Privacy and data | No real personal data in tests, fixtures, or logs; use made-up sample data. |
| Code quality | Run the project's own linter, formatter, and tests before committing, and report any that were skipped or failed. |
| Documentation | Update the README or docs when behavior changes. |
| Accessibility | Follow a named level, such as WCAG 2.2 AA, for any user interface. |
| Regulatory | Where a project falls under a framework (for example SOC 2, HIPAA, or GDPR), agents follow that project's controls and do not work around them. |
| Evidence | How an agent records what it checked: in the commit message, the pull request description, or a report under a known folder. |

## Why

- Different agents have different defaults for what to check before calling work finished. A shared standard makes their output consistent and easier to review.
- Some failures are expensive and hard to undo: a leaked secret, an incompatible license, real customer data in a test file. A clear rule is cheaper than finding them later.
- Teams that have to prove compliance need agents to leave a record of what they checked.

## Scope to agree on

[PROPOSAL.md](../PROPOSAL.md) says project-specific coding standards and domain rules stay in each project's own files. So the line to draw is:

- **In the constitution:** standards that hold for any project, and the duty to follow a project's own standards and report what was checked.
- **In each project:** the specific linters, test commands, style guides, and regulatory controls.

## Open questions

- Which of the areas above belong in the constitution, and which are left to each project?
- Should the constitution name outside standards (for example WCAG or OWASP), or only require agents to follow the ones a project names?
- What counts as evidence of compliance, and where is it kept? This may connect to the `.output/` folder in the [dot folders proposal](2026-11-11-dot-folders.md).
- What should an agent do when a check fails and it cannot fix it: stop, commit anyway and report, or ask?
- What should an agent do when a project has no stated standard for an area?
- Is this one article, or should each area become a law under an existing article?

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
