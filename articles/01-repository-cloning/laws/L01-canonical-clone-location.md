# I-L01 — Canonical clone location

**Enforces:** I.1.1

The clone root is:

```
/Users/Shared/agent/repos/clone
```

A repository's canonical location is `/Users/Shared/agent/repos/clone/<ORG>/<repo>`.

- `<ORG>` and `<repo>` MUST match the repository URL exactly, including letter case.
- A trailing `.git`, a trailing `/`, and any path after the repository name (such as `/tree/main`) MUST be dropped.

| Source URL | Canonical location |
|---|---|
| `https://github.com/carlosmarte/LDE-agents-constitution` | `/Users/Shared/agent/repos/clone/carlosmarte/LDE-agents-constitution` |
| `git@github.com:octo-org/my-service.git` | `/Users/Shared/agent/repos/clone/octo-org/my-service` |
| `https://github.com/octo-org/my-service/tree/main` | `/Users/Shared/agent/repos/clone/octo-org/my-service` |

**Test:** for each clone under the clone root, the path relative to the clone root equals `<ORG>/<repo>` of its `origin` remote. [I-P02](../procedures/P02-check-clone-locations.sh) checks this.
