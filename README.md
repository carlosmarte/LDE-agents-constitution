# LDE-agents-constitution

The constitution for AI agents working in this local development environment (LDE). Every AI system — Claude, Copilot, Cursor, Codex, custom agents, scripts — MUST read and follow these articles.

## How to use this document

- **AI systems:** treat every article marked **Adopted** as a hard rule. Where an article and a general default disagree, the article wins. The user's explicit instruction in the current conversation wins over an article, for that instance only.
- **Editing this repository:** follow [AGENTS.md](AGENTS.md), which defines how articles, laws, procedures, amendments, and definitions are laid out.
- **Humans:** point your agent's system prompt, `CLAUDE.md`, `AGENTS.md`, or equivalent at this repository.

The key words MUST, MUST NOT, SHOULD, and MAY are used as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119).

## Articles

Articles are lettered `A` to `Z`, so the constitution can never have more than 26. It is the base: detail belongs in each article's laws and procedures, not in more articles. Amendments are cited by the article's letter plus a number: `A1` adopted Article A, and `A2` is its second amendment.

| Letter | Article | Summary |
|---|---------|---------|
| A | [Repository Management](articles/A-repository-management/ARTICLE.md) | How agents manage Git repositories for local development. Today: clone every GitHub repo to `/Users/Shared/agent/repos/clone/<ORG>/<repo>`; reuse existing clones; an explicit user path takes precedence. |
