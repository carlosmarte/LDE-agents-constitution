# A5 — Point Article A's approval questions to Article B

- **Date:** 2026-11-07
- **Status:** Adopted
- **Changes:** Amends A-L04, A-L10, and A-L15. No clause changes.

## Reason

[A4](A4-repository-management-practices.md) deferred who may approve shared and destructive repository actions. [Article B](../../B-user-authority/ARTICLE.md) now answers that, so Article A's laws point to it instead of leaving the question open:

- **A-L04:** running `reset --hard`, `git clean`, `git checkout --`, or `git stash` over uncommitted changes is a destructive action under B-L03.
- **A-L10:** committing past a secrets match is a destructive action under B-L03. This replaces the sentence saying the law "does not decide who may tell it to continue".
- **A-L15:** removing anything cleanup does not allow is a destructive action under B-L03, and removing a clone also needs an override of A.3.1 and A.12.2 under B-L07.

The "never" clauses of Article A, such as A.3.1 and A.12.2, are unchanged. The user can set one aside for a single action only through an override under Article B, Section 7.
