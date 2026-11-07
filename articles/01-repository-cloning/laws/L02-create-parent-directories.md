# I-L02 — Create parent directories

**Enforces:** I.2.1

Before cloning, an agent MUST run the equivalent of:

```bash
mkdir -p "/Users/Shared/agent/repos/clone/<ORG>"
```

If creating the directory fails (for example, a permissions error), the agent MUST stop and report the error to the user. It MUST NOT fall back to another location.

**Test:** no clone of a GitHub repository exists outside the clone root unless the user gave an explicit destination for it.
