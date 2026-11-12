# One pipeline to distribute rules and skills to every agent harness

- **Author:** Carlos Marte
- **Date:** 2026-11-12
- **Status:** Open
- **Affects:** `scripts/` and the layout in [AGENTS.md](../AGENTS.md). Possibly a new article on how the constitution reaches agents.

## Idea

Write each rule and skill once, in this repository, and generate the files every agent harness expects from that single source. One command (and later one CI job) rebuilds and installs them all. Nobody edits a harness's copy by hand.

[PROPOSAL.md](../PROPOSAL.md) aims for every agent, "whatever its tool or task", to work from the same articles. Today that only holds for tools that read this repository directly.

## The problem

Each harness looks for instructions in a different place and format. A sample, to be checked against each tool's current docs when the pipeline is built, since these paths change often:

| Harness | Instructions | Scoped rules or skills |
|---|---|---|
| Claude Code | `CLAUDE.md` (project), `~/.claude/CLAUDE.md` (user) | `.claude/skills/<name>/SKILL.md`, hooks in `.claude/settings.json` |
| GitHub Copilot | `.github/copilot-instructions.md`, `AGENTS.md` | `.github/instructions/*.instructions.md` with `applyTo:` globs, `.github/prompts/*.prompt.md` |
| Cursor | `AGENTS.md` | `.cursor/rules/*.mdc` with `description`, `globs`, `alwaysApply` |
| OpenAI Codex | `AGENTS.md`, `~/.codex/AGENTS.md` | Skills folder, per current docs |
| Gemini CLI | `GEMINI.md` | Per current docs |

Copying by hand means every change has to be made five times, and the copies drift. There is already a small example of drift: the cloning rule from Article A is also written by hand into a user-level `~/.claude/CLAUDE.md` on this machine. If Article A changes, that copy will not.

## Draft design to discuss

**1. One source format.** Rules and skills are written once, as Markdown with a small front-matter block that carries what the targets need:

```markdown
---
id: A-L03
title: Reuse an existing clone
applies_to: ["**"]        # file globs, for tools that scope rules by path
always: true              # load every session, or only when relevant
targets: [all]            # or a list: [claude, copilot, cursor]
---
<rule text>
```

Skills use the open Agent Skills format (`SKILL.md` with `name` and `description`), which several harnesses read directly. Where a harness doesn't, the build turns the skill into the nearest equivalent, such as a prompt file.

**2. One build script.** A script next to `scripts/build-constitution.sh`, for example `scripts/build-harness.sh`, with one small adapter per harness:

- Reads the source rules and skills.
- Writes each harness's files into a build folder, for example `.output/harness/<tool>/`. This links to the [dot folders proposal](2026-11-11-dot-folders.md).
- Puts a header on every generated file: generated, do not edit, and where the source is.
- Has a `--check` mode, like `build-constitution.sh`, that fails if any output is out of date.

**3. One install step.** The same script, with an install option, copies or links the outputs to where each harness looks:

- **User level:** for example `~/.claude/`, `~/.codex/`. It covers every repository on the machine, which fits a local constitution.
- **Project level:** for example `.github/`, `.cursor/rules/`, `AGENTS.md` in a given repository, for teams that need rules committed with the code.

It only replaces files it generated (those with the header). It reports anything else in the way and leaves it alone.

**4. Later, one CI job.** On every merge to `main`, CI runs the build in `--check` mode, then publishes the outputs, for example as a release artifact or as pull requests to the repositories that consume them.

## Why

- Updating each harness by hand defeats the purpose of one constitution. A rule changed here should reach every agent from one command.
- Generated files with a do-not-edit header make drift visible, and `--check` catches it.
- Teams can switch or mix tools without rewriting their rules.

## Open questions

- User-level install, project-level files, or both? Project files are visible to the team but add generated files to every repository.
- Copy or symlink? Symlinks update without re-running the script but don't work for every harness or for files committed to other repositories.
- Which harnesses to support first? Claude Code, Copilot, and `AGENTS.md` cover the most tools for the least work.
- Is `AGENTS.md` enough as the shared baseline, with harness-specific files only for what it can't express (path-scoped rules, skills, hooks)?
- Hooks and settings (like the rebuild hook in `.claude/settings.json`) have no equivalent in most harnesses. Are they in scope?
- How are the source rules related to the articles? Is every law exported, or only the ones marked for export?
- How does a consuming repository add its own rules without the next build overwriting them?
- Who owns the adapters when a harness changes its folder layout?

## Discussion

<!-- One entry per meeting: date, what was decided, who follows up. -->

## Outcome

<!-- Amendments that applied this proposal, for example A7. Or why it was declined. -->
