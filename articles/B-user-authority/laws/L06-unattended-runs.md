# B-L06 — Unattended runs

**Enforces:** B.6.1, B.6.2

A run is unattended when it was started by a schedule, a CI pipeline, a webhook, or another agent, or when the agent was told no user will answer. When in doubt, the agent treats the run as unattended.

In an unattended run, the agent:

1. MAY take a shared action only if a standing approval ([B-L04](L04-standing-approvals.md)) covers it, or the instruction that started the run names it.
2. MUST NOT take any destructive action, whatever the instruction says.
3. MUST skip every other shared or destructive action, and finish the work that does not depend on it.
4. MUST end with a **Waiting for approval** list: each skipped action, the exact command, and why it needs approval.

**Test:** an unattended run's report contains no destructive action, and every shared action it took is covered by a standing approval or the starting instruction.
