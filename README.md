# LDE-agents-constitution

The constitution for AI agents working in this local development environment (LDE). Every AI system — Claude, Copilot, Cursor, Codex, custom agents, scripts — MUST read and follow these articles.

## How to use this document

- **AI systems:** treat every article marked **Binding** as a hard rule. Where an article and a general default disagree, the article wins. The user's explicit instruction in the current conversation wins over an article, for that instance only.
- **Humans:** point your agent's system prompt, `CLAUDE.md`, `AGENTS.md`, or equivalent at this repository.

The key words MUST, MUST NOT, SHOULD, and MAY are used as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119).

## Articles

| # | Article | Summary |
|---|---------|---------|
| I | [Repository Cloning](articles/01-repository-cloning.md) | Clone every GitHub repo to `/Users/Shared/agent/repos/clone/<ORG>/<repo>`; reuse existing clones; an explicit user path takes precedence. |
