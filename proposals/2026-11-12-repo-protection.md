# Main branch and repository protection

- **Author:** Carlos Marte
- **Date:** 2026-11-12
- **Status:** Open
- **Affects:** Article A, Sections 7 (Branches) and 10 (Pushing), and possibly a new section on protection settings. Laws [A-L07](../articles/A-repository-management/laws/L07-default-branch-check.md) and [A-L13](../articles/A-repository-management/laws/L13-push-current-branch.md) are the closest today.

## Idea

Protect the default branch, and the repository as a whole, in two layers:

1. **Agent rules:** what an agent must never do to a protected branch or to the repository's settings, whatever the server allows.
2. **Repository settings:** a standard set of protection rules that every repository should have turned on (GitHub branch protection or rulesets), and a check that reports repositories missing them.

The agent rules guard against mistakes when the server allows too much. The server settings guard against any agent or person that doesn't follow the rules.

## What the constitution already covers

- [A-L07](../articles/A-repository-management/laws/L07-default-branch-check.md): an agent on the default branch asks the user before its first change whether to branch or stay.
- [A-L13](../articles/A-repository-management/laws/L13-push-current-branch.md): an agent pushes only its current branch, by name. No `--all`, `--mirror`, or refspecs like `HEAD:main` unless the task asks for that exact effect.
- [A-L11](../articles/A-repository-management/laws/L11-sync-from-upstream.md): updating from upstream never rewrites history.

These depend entirely on the agent following them. If the user says "stay on main" or "commit to main", an agent can push straight to the default branch with no review. That happened while these proposals were being written: commits went directly to `main`, which nothing on the server stopped. That was fine here because the user asked, but the same path is open to a mistaken or unattended agent.

## Draft agent rules

An agent MUST NOT, unless the user asks for that exact action in the current conversation:

- Force-push (`--force`, `--force-with-lease`, `+refspec`) to the default branch or any protected branch.
- Delete the default branch or a protected branch, locally on the remote or on the server.
- Rewrite published history on a shared branch (rebase, amend, or reset of commits already pushed).
- Bypass hooks or checks with `--no-verify`, or skip required status checks.
- Use an admin override to merge a pull request that has not met its protection rules.

An agent MUST NOT, even when asked, change protection settings itself. It tells the user what to change and where, since these are security settings that belong to the repository's admins.

An agent SHOULD, when the default branch is protected, work on a branch and open a pull request, rather than asking to commit to the default branch.

## Draft standard repository settings

A baseline to agree on, applied to the default branch of every repository the team owns:

| Setting | Baseline |
|---|---|
| Require a pull request before merging | On |
| Required approving reviews | At least 1 |
| Require review from code owners | On (links to the [code owners proposal](2026-11-12-code-owners.md)) |
| Dismiss stale approvals when new commits are pushed | On |
| Require status checks to pass | On, with the repository's CI checks listed |
| Require branches to be up to date before merging | On |
| Require conversation resolution | On |
| Block force pushes | On |
| Block deletion | On |
| Require linear history | Team choice |
| Require signed commits | Team choice |
| Apply rules to administrators (no bypass) | On, or bypass limited to a named group |
| Protect release tags (for example `v*`) | On |
| Secret scanning and push protection | On (links to [A-L10](../articles/A-repository-management/laws/L10-secrets-check.md)) |

A procedure could read a repository's current rules with the GitHub CLI (for example `gh api repos/<ORG>/<repo>/rulesets` and the branch protection endpoint), compare them with the baseline, and report the gaps without changing anything.

## Why

- The default branch is what everyone builds and deploys from. One bad force push or unreviewed commit affects the whole team.
- Agents increasingly run unattended. Server-side protection is the only safeguard that doesn't depend on every agent behaving.
- A written baseline turns "is this repo protected?" into a check anyone can run, instead of a setting someone has to remember.

## Open questions

- Should "the user asked" be enough for an agent to push directly to a protected default branch, or should agents always go through a pull request once protection is on?
- Which settings are required for every repository, and which are a team choice?
- Personal and scratch repositories: same baseline, a lighter one, or exempt?
- Should the check run on a schedule and report, or only when an agent first works in a repository?
- Should the baseline be stored as a GitHub ruleset file (JSON) in this repository, so it can be applied the same way everywhere by an admin?
- Who may approve exceptions, and where are they recorded?

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
