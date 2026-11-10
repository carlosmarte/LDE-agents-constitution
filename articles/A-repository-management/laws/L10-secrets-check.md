# A-L10 — Check staged changes for secrets

**Enforces:** A.8.2

Immediately before every commit, an agent MUST check the staged changes, for example with [A-P04](../procedures/P04-check-staged-secrets.sh). A staged change is a secret if either of these holds.

**Its file name matches:**

| Pattern | Covers |
|---|---|
| `.env`, `.env.*` (except `.env.example`, `.env.sample`, `.env.template`) | Environment files |
| `*.pem`, `*.key`, `*.p12`, `*.pfx` | Keys and certificates |
| `id_rsa*`, `id_ed25519*`, `id_ecdsa*`, `id_dsa*` (except `*.pub`) | SSH private keys |
| `.npmrc`, `.pypirc`, `.netrc` | Package registry and login credentials |

**Its added lines match:**

| Pattern | Covers |
|---|---|
| `-----BEGIN ... PRIVATE KEY-----` | Any private key |
| `AKIA` followed by 16 uppercase letters or digits | AWS access key IDs |
| `ghp_`, `gho_`, `ghu_`, `ghs_`, `ghr_`, or `github_pat_` followed by a token | GitHub tokens |
| `sk-` followed by 20 or more letters, digits, `-`, or `_` | OpenAI- and Anthropic-style API keys |
| `xox[abprs]-` followed by a token | Slack tokens |

If anything matches, the agent MUST NOT commit. It MUST report each file and pattern that matched, without printing the secret's value, and leave the changes staged.

A pattern match can be a false alarm, such as a test fixture or documentation example. This law decides only that the agent stops and reports; it does not decide who may tell it to continue.

**Test:** no commit made by an agent adds a file or line matching the patterns above.
