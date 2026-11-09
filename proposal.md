# Proposal: A Constitution for Local AI Agents

**Date:** 2026-11-09

## Summary

This proposal establishes a single, general constitution for AI agents working in a local development environment. It sets out how an agent should behave and govern itself, whichever project or initiative it is working on. The goal is a shared understanding of the rules every agent follows.

## The need

AI agents now do real work on local machines: they clone repositories, change files, run commands, and act on the user's accounts. Different agents come with different defaults, and each session starts without knowing what earlier sessions did. Instructions written for one tool or one project do not reach the others.

Without a common base, the same situation can be handled differently by each agent, and the user has to restate the same expectations again and again.

## Purpose

The constitution gives every local agent one set of general rules for how to behave and how to be governed. It describes:

- the behaviors agents should exhibit
- the rules agents must follow
- the limits on what an agent may do without the user's approval

Any agent on the machine can read the same articles and reach the same understanding of what is expected of it.

## What it serves

- **The user** can state an expectation once and rely on every agent to honor it, and keeps authority over actions that affect others or cannot be undone.
- **Agents** get clear, consistent guidance in place of guesswork, including what to do when they are unsure or no one is available to ask.
- **Work across projects** stays predictable, because agents act the same way from one project and session to the next.

## Scope

**The constitution covers** general conduct that holds for any agent in any project, such as how agents manage repositories and whose approval counts.

**The constitution does not cover** project-specific governance. A project's architecture, coding standards, workflows, and domain rules stay in that project's own files.

The two work together. The constitution tells agents to follow a project's own conventions, and to pause and ask the user if one of those conventions would break a clause.

## Approach

- **Stay high level.** Articles state principles that rarely change. Concrete rules live in laws, and scripts and how-tos live in procedures beneath them.
- **Stay small.** Articles are lettered A to Z, so there can never be more than 26. That keeps the base short enough for any agent to read in full.
- **Stay traceable.** Every law names the clause it enforces, and every meaningful change is recorded as an amendment.
- **Stay readable in one place.** `CONSTITUTION.md` collects every article into a single file.

## Intended outcome

Every local agent, whatever its tool or task, works from the same articles and clauses. The result is a collective understanding of how agents should behave and be governed, with project-specific detail left to each project.
