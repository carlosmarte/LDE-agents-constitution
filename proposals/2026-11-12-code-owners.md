# Code owners by domain and business unit

- **Author:** Carlos Marte
- **Date:** 2026-11-12
- **Status:** Open
- **Affects:** unsure. Possibly a new section in Article A next to Section 6 (Repository conventions), or a new article on ownership and escalation.

## Idea

Agents should be able to answer "who owns this?" for any part of a repository: which team or person is responsible for a domain or business unit, who reviews changes to it, and who to ask when something is unclear. They then use that answer to route questions, request reviews, and respect the boundaries of areas they don't own.

## What exists today

GitHub already supports a `CODEOWNERS` file (in the repository root, `.github/`, or `docs/`). It maps file paths to owners, and GitHub requests their review on pull requests:

```
/billing/        @octo-org/payments-team
/apps/checkout/  @octo-org/checkout-team
*.tf             @octo-org/platform
```

It answers "who reviews these files" but not:

- which **domain** or **business unit** an area belongs to,
- how to **contact** the owner outside a pull request (chat channel, on-call rotation),
- who to **escalate** to when the owner doesn't respond,
- who owns things that are **not files**, such as a service, a data set, or a shared library used across repositories.

## Draft structure to discuss

Keep `CODEOWNERS` for path-based review, and add an ownership file that describes each domain. For example `OWNERS.md` or `.ownership.yml`:

| Field | Example |
|---|---|
| Domain | Payments |
| Business unit | Commerce |
| Paths | `/billing/`, `/apps/checkout/` |
| Owning team | `octo-org/payments-team` |
| Contact | `#payments-eng` channel |
| Escalation | Payments engineering manager |
| Notes | PCI scope: changes need security review. |

## How agents would use it

- **Before changing** files in a domain the user's team doesn't own, the agent says so and names the owner.
- **In pull requests**, it lists the owning team as reviewers. It doesn't rely only on GitHub's automatic request, and it doesn't `@`-mention people by guess.
- **When unsure** what a piece of code should do, it points the user to the owner rather than guessing.
- **In unattended runs**, it reports changes that touch another team's domain rather than merging them.
- It does not edit `CODEOWNERS` or the ownership file unless the task is to change ownership.

## Why

- In large or shared repositories, the person asking an agent for a change is often not the person who owns the code. Knowing the owner avoids surprise changes and slow reviews.
- Questions get to the right people faster when agents can name them.
- Domains with compliance needs (payments, health data, security) are usually the ones with strict owners. This connects to the [standards and compliance proposal](2026-11-11-standards-and-compliance.md).

## Open questions

- Is `CODEOWNERS` enough, or is a separate domain ownership file worth maintaining? If separate, what is it called and where does it live?
- Should ownership be recorded per repository, or in one central place that covers many repositories?
- What should an agent do when a change crosses several domains?
- What should an agent do when a file has no owner listed?
- Are agents allowed to notify owners directly (for example by `@`-mention or chat), or only tell the user who the owner is?
- How is the ownership file kept current when teams change?

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
