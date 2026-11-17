# How the user signs off every milestone

## Agent report template
```
Milestone: Mx — Title
Scope actually delivered:
Files created/modified/deleted:
Architectural changes/decisions:
Commands executed + results (not guesses):
Tests actually run (PASS/FAIL with output):
Tests not executed (reason):
Security/privacy and content concerns:
Known issues/blockers:
Acceptance criteria result:
Suggested next milestone (NOT approved yet):
STOP — awaiting specific milestone approval.
```

## Approval words
- `I approve M1 — environment setup only. Do not start M2.`
- `I approve M2A — development PostgreSQL schema and RLS only. Do not start M2B.`
- `I approve M2B — Flutter local SQLite and approved read integration only. Do not start M3.`
- `Revise the current milestone only; do not proceed.`
- `Stop. No further commands or edits.`

## Gate control notes
A text instruction is not a technical security boundary. Review external tool permissions and every proposed destructive, network, account, or billing action. For cloud projects, require the user to control ownership and credentials. Keep Git commits per milestone when suitable; do not auto-push or deploy.
