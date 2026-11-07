# A-L13 — Push only the current branch

**Enforces:** A.10.1

To push, an agent MUST name the branch:

```bash
git push -u origin <branch>   # first push: sets the upstream
git push origin <branch>      # later pushes
```

An agent MUST NOT run any of these unless the task asks for that exact effect:

- `git push --all`
- `git push --tags` or `git push --follow-tags`
- `git push --mirror`
- `git push` with a refspec that names a different branch (`HEAD:main`, `+refs/heads/*`)

A task that asks to publish a release tag MAY push that one tag by name: `git push origin <tag>`.

**Test:** each push an agent made updated only the branch it was working on, or a tag the task named.
