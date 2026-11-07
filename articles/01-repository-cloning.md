# Article I — Repository Cloning

**Status:** Binding
**Applies to:** Every AI agent, assistant, automation, or tool that clones a Git repository from GitHub on this machine.

---

## Section 1 — Canonical location

Every GitHub repository MUST be cloned to:

```
/Users/Shared/agent/repos/clone/<ORG>/<repo>
```

| Placeholder | Meaning | Example |
|-------------|---------|---------|
| `<ORG>` | The GitHub owner: a user or an organization, exactly as it appears in the URL | `carlosmarte` |
| `<repo>` | The repository name, exactly as it appears in the URL, without a `.git` suffix | `LDE-agents-constitution` |

**Example**

| Source URL | Clone path |
|------------|------------|
| `https://github.com/carlosmarte/LDE-agents-constitution` | `/Users/Shared/agent/repos/clone/carlosmarte/LDE-agents-constitution` |
| `git@github.com:octo-org/my-service.git` | `/Users/Shared/agent/repos/clone/octo-org/my-service` |

## Section 2 — Parent directories

An agent MUST create any missing parent directories (`/Users/Shared/agent/repos/clone/<ORG>`) before cloning. It MUST NOT treat a missing parent directory as a reason to clone somewhere else.

## Section 3 — Reuse, do not re-clone

If `/Users/Shared/agent/repos/clone/<ORG>/<repo>` already holds a Git repository, the agent MUST reuse it:

1. Do **not** delete it, move it, or clone again beside it (no `-2`, `-copy`, or temporary-folder clones).
2. Run `git fetch` to update it. Run `git pull` only when the working tree is clean and the user's task needs the latest commits.
3. If the working tree has uncommitted changes, leave them in place and tell the user before doing anything that could affect them.

## Section 4 — Explicit paths take precedence

When the user gives an explicit destination path for a clone, that path wins over Section 1. The user's instruction applies to that clone only; it does not change the default for later clones.

## Section 5 — Scope

- This Article covers repositories hosted on GitHub (`github.com`).
- It applies whether the clone is made with `git clone`, `gh repo clone`, an IDE, or any other tool.
- It applies to every agent session, including scratch or temporary sessions. A temporary working directory is not a reason to clone elsewhere.

## Section 6 — Reference procedure

```bash
URL="https://github.com/<ORG>/<repo>"
DEST="/Users/Shared/agent/repos/clone/<ORG>/<repo>"

if [ -d "$DEST/.git" ]; then
  git -C "$DEST" fetch --all --prune
else
  mkdir -p "$(dirname "$DEST")"
  git clone "$URL" "$DEST"
fi
```

## Rationale

A single, predictable location means every agent and every person on this machine can find any cloned repository without searching, the same repository is never cloned twice in different places, and work in one session is visible to the next.
