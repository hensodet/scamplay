# Permanent agent rules — ScamPlay

## Instruction precedence
1. Explicit, latest **single-milestone** user approval.
2. `docs/PRD_PILOT.md` and active milestone acceptance criteria.
3. `docs/ARCHITECTURE.md`, `docs/DATA_MODEL.md`, `docs/DECISIONS_AND_RISKS.md`.
4. `docs/PRODUCT_VISION.md` (vision only; not authorized work).
If conflicting, describe conflict and **STOP** rather than choose silently. Never treat a previous approval as blanket consent.

## Mandatory gates
- Only execute **one authorized milestone/submilestone**. M0 is analysis-only.
- Before action: announce objective, exact changes, commands, cloud costs, relevant risks, and verification plan.
- After action: report changed files, commands/tests actually executed with output, tests not run, failures, security/privacy notes, and next-step recommendation; update milestone tracker.
- **STOP and await explicit approval** after each milestone or when blocked. No automatic continuation and no background work.
- Never deploy, publish, create paid cloud resources, change production infrastructure, write secrets, delete data, run destructive SQL, or connect a real account without specific explicit approval.
- Do not treat 'continue' as authorization for multiple stages; ask to identify the next stage when ambiguous.

## Product boundaries
- Flutter Android/iOS = only general-user frontend. Next.js = private administrator UI and suitable API routes. No public web/PWA product unless formally changed.
- Khmer (`km`) default, English (`en`) complete for active content; no silent fallback that hides missing translations in a published item.
- First interactive scam: Messenger impersonation leading to attempted Telegram takeover.
- Scenario library **visually displays cards** (cover images, title, category, estimated duration, status); only genuinely playable cards must appear enabled.
- Create **real functional first scenario**; video/news can initially be clearly labeled licensed/demo fixtures. Never fabricate current scam news or contacts.
- Early PostgreSQL+SQLite integration is approved **as an architectural direction**, NOT permission to create resources now.

## Engineering and security
- Prefer minimal modular monorepo. No premature microservices. Flutter, Next.js, Supabase migrations, Drift SQL/local persistence.
- Document and test authorization, RLS, anonymous read restrictions, data integrity. Flutter may hold a *publishable* key but NEVER a service-role/secret key. Server secrets never shipped in app bundles.
- State who owns business rules: backend authoritative for security-sensitive writes and certificates; client handles local lesson UI and provisional guest scoring.
- No indiscriminate full database synchronization. Versioned published content downloaded into local cache. User progress synced only after consent/account feature approval.
- No real victim data, OTPs, passwords, restricted case evidence, official seals, government-endorsed claims or unverified phone numbers.
- No automatic fetching of unsafe links for AI Lab. Requires separately approved threat model including SSRF, injection, privacy, cost, reputation limitations.
- No claims of tests passed unless actually run; label simulated/demo content visibly. Review generated dependencies for vulnerabilities before distribution.
- Use official docs and pin supported stable versions during implementation; avoid inventing exact current package versions.

## Rules for quality and design
- Khmer/English semantic parity. Use appropriate Khmer fonts, line-height, actual handset testing; user-initiated narration and text alternatives.
- Images/media must be created, purchased, or licensed with rights recorded; placeholders clearly marked.
- Keep accessibly labeled large touch targets and readable typography; test offline/slow network and low-end Android.
- Save documentation and progress updates in `docs/TASKS.md`; include a concise changelog and decision record.
- No `SKILLS.md` needed yet. Introduce `.agents/skills/<name>/SKILL.md` for repeated, verified operations only, never as a substitute for clear project rules.
