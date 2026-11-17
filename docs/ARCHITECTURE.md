# Architecture — target, boundaries, and phased execution

## Logical architecture
```
[Flutter Android/iOS public app] -- TLS --> [Supabase Data API: published read-only RLS]
      |                                    |
      | SQLite/Drift local cache           +--> [PostgreSQL: versioned content]
      | user-local progress                +--> [Storage: approved covers/audio/video]
      |
      +-- future controlled writes --> [Next.js API/service or narrowly scoped RPC]
                                        ^       |
[Private Next.js Admin] -- auth + RBAC --+       +--> [PostgreSQL + Storage]
```
- Central PostgreSQL authoritative for published content, approvals, roles and audit logs.
- Local SQLite authoritative only for offline device-local guest state/cache; not for admin roles or trusted completion/certification.
- Server logic authoritative for permissions, content publishing, AI billing/control, future identity-backed scores/certificates.
- Flutter presents cached scenario content, local provisional scoring and narration. No direct privileged mutations.
- Admin Next.js can initially share backend route handlers; no dedicated microservice required. If stronger separation needed later, propose and approve it.

## Target physical deployment (not provisioned)
```
User Android/iOS -> HTTPS -> Supabase project (prefer testing Singapore region)
                                   | Postgres + RLS + Storage
Admin browser -> HTTPS -> Next.js hosted admin/server (authenticated)
                                   | server-only privileged calls
Flutter device -> SQLite files (on-device, per installation)
CI/CD -> approved migrations/test builds -> controlled staging -> production
```
- Region and latency must be measured from Cambodia; no residency assumption.
- Separate dev/staging/prod environments before production launch; *do not provision without approval*.
- DNS/branding/owner, audit logging, secrets, media delivery, retention and backups must be assigned before public release.

## Repository layout (planned, not required to be created at M0)
```
ScamPlay/
  AGENTS.md
  docs/                 # decisions, acceptance, API spec, architecture
  prompts/              # single-milestone agent requests
  sample-content/       # unreviewed bilingual scenario + demo fixtures
  apps/mobile/           # Flutter Android/iOS
  apps/admin-web/        # Next.js administrator UI and API routes
  supabase/migrations/   # SQL versioned migrations, RLS, tests
  contracts/             # versioned JSON schema / OpenAPI contracts
  tests/                 # integration and release tests
```
The initial repository is a monorepo, but **do not build multiple deployed apps simultaneously**.

## Initial schema boundaries
Postgres: published scenario metadata, localized text/questions/options, covers/audio references, content versions, publishing status. Admin roles later. SQLite: downloaded scenario snapshots, asset manifests, local attempts, language preference. See `DATA_MODEL.md`.

## API decision matrix
- Published public content: Supabase Data API using only publishable key and enforced RLS. Every publicly exposed scenario-related table must enforce appropriate permissions and publication-state access rules, including child records and media (REVOKE ALL FROM public; GRANT SELECT ON specific tables TO anon; RLS enforcing status = 'published').
- Security verification: Database grants, RLS, Storage policies, and offline caching must be tested before declaring them secure or reliable. Both positive and negative automated tests are required before connecting mobile clients (confirming anon can read published content and cannot read drafts or execute any mutations).
- Performance verification: Supabase round-trip latency to Singapore must be empirically measured from target devices rather than assumed.
- Offline resilience: Offline caching and resilience in local SQLite (Drift) must be verified through real network interruption and offline reboot tests rather than described as guaranteed.
- Publishing/admin operations: authenticated server-side service, role and policy enforcement, audit.
- Future AI/news imports: background server jobs with egress/SSRF guards, quotas, review queue.
- Future user progress upload: authenticated service with idempotency, server-side scoring and consent checks.
