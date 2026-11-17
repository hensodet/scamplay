# Decision log / risk register (as of 17 November 2026)

## Confirmed user decisions
- Name: ScamPlay (trademark/domain clearance not completed).
- Public frontend: **Flutter Android/iOS only**, no public website.
- Admin frontend: secured Next.js web.
- Early integration: PostgreSQL via Supabase and local SQLite via Drift.
- Two languages: Khmer default and English throughout released content.
- Library: illustrated scenario cards, user-selected order, clear disabled previews.
- First case: Messenger/Telegram account takeover.
- Early demo video/news interfaces are desired; not to be confused with live functionality.
- Antigravity stage-by-stage implementation with explicit approval.
- Ownership: **undecided**. No authority implied; no public release until a responsible publisher is designated.

## High-priority unresolved matters (proposed defaults, not user decisions)
1. **Publisher & rights holder**: independent or institutional? Default: neutral non-affiliated development only, no official seals or claims.
2. **Account access / infrastructure**: Supabase project belongs to whom? Default: user controls own project, grants least-privilege access; never paste secret keys in chat.
3. **Media rights**: default original visuals and prerecorded rights-cleared audio; don't claim production audio exists if none supplied.
4. **Case approval**: default all sample scenario dialogue is fictional, educational and awaiting expert bilingual review.
5. **Pilot distribution**: user previously favored public prototype link, but mobile-only now means test via approved Android build/internal distribution; re-confirm method and signing. No anonymous open download before release gate.
6. **iOS development**: requires Apple-compatible build/signing infrastructure; Android-first device tests on Windows, never claim iOS build validation without appropriate host.
7. **Regional compliance**: get locally qualified advice on privacy, publication, official contacts, laws, data location and copyright before launch.
8. **Operating budget and support**: assign people for contacts, incident guidance, security, backups, media, editorial review and takedown.
9. **Scoring and media versioning**: M0 must choose schema approach. No certificate trust model at pilot.
10. **User demographics/accessibility**: conduct informed consent-based studies, diverse devices/ages, avoid collecting sensitive victim details.

## Technical risks and mitigations
- **RLS error/leak:** deny writes to anon; run role matrix and adversarial access tests before publishing.
- **Lost guest progress:** local SQLite not guaranteed if user clears app data or uninstalls; communicate it.
- **Incorrect Khmer text/audio:** native-speaker review, font/device test, user-initiated audio; ensure translation completeness.
- **Official misinformation:** verified source, review dates, correction channel and withdrawal process.
- **False AI safety confidence:** AI Lab later with guardrails, third-party data policies and quotas.
- **Brand spoofing:** control official domain/app-store publisher, verify brand assets, phishing/takedown response.
- **Misuse of public scenario:** omit real OTPs, actual victim data, clickable malicious links.
- **Operating costs/latency:** inspect region, quotas, CDN media, budgets and alerting.
