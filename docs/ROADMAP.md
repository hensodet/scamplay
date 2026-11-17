# Work plan — one approval per milestone

Every milestone: **plan → approve → implement → execute tests → review evidence → approve next**. Each one is bounded. Do not work on multiple future milestones just because their names appear below.

| Milestone | Work | Exit artifact / gate |
|---|---|---|
| **M0 (NOW)** | Verify requirements, risks, architecture decisions, realistic schedule and approvals; NO code/cloud resources | Written architecture and M1 commands; approval |
| **M1** | Install/validate Windows toolchain, initialize Git and Flutter/Next.js skeleton **without connected secrets** | `flutter doctor -v`, app boots on Android, Next.js admin shell boots locally, repo status; approval |
| **M2A** | Supabase dev project/migrations for **minimum public scenario**; verified anon read-only RLS, no admin publication yet | migration diff, database/RLS tests; approval |
| **M2B** | Flutter Drift SQLite cache and online/offline content sync of one approved seed fixture | fetch/cache/offline test logs, DB migrations; approval |
| **M3** | Bilingual Flutter home + illustrated Scenario Library cards (1 playable, 3 clearly Coming Soon) | screenshots on Android, lang toggle + offline list; approval |
| **M4** | Complete Telegram/Facebook takeover story, decision nodes, score, replay, local progress, narration assets/placeholders | Android demo and test output; content review; approval |
| **M5A** | Admin auth, restricted roles, publication workflow, asset uploading, audit logging | permission and API tests incl. denials; approval |
| **M5B** | End-to-end admin publish → approved PostgreSQL → Flutter auto refresh/cache | evidence: new card appears and usable offline; approval |
| **M6** | Victim-help decision tree and verified directory with correction channel | SME-reviewed safe content; contact provenance; approval |
| **M7** | Video library, news draft management and moderated ingestion | 1 rights-cleared sample video; labeled demo news, then verified published articles; approval |
| **M8** | Safety health check and legal education modules | reviewed questions and lawful source references, usable audio; approval |
| **M9** | Optional accounts, protected progress sync, scoring/certificates | privacy/identity/security review, anti-tamper tests; approval |
| **M10** | AI Lab with analysis pipeline, privacy safeguards, quotas, injection/SSRF threat model | red-team tests, cost limits, explicit uncertainty; approval |
| **M11** | Android/iOS device QA, app-store preparation, backups/recovery, security independent review | public-release gate signed; approval |
| **M12** | Ongoing monitoring, content review/maintenance/expansion | assigned operations owner, budget, review cadence |

## Do not confuse demo and complete
- Only M4 completes the first scenario, M5B makes admin publication functional, M7 delivers actual video/news workflows.
- All eight features are roadmapped in `PRODUCT_VISION.md`. Preview screens are **not** complete features.
- User may alter order via a new written decision in `DECISIONS_AND_RISKS.md` before starting the affected milestone.
