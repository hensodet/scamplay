# Incremental database model + synchronization contract

## PostgreSQL — proposed M2 minimum
- `scenarios`: `id` (stable slug/UUID), `category`, `cover_asset_id` or reviewed cover URL, `estimated_minutes`, `status` (`draft|published|archived`), `version` integer, `published_at`, `updated_at`.
- `scenario_localizations`: `(scenario_id, locale)` PK, `title`, `summary`, `intro`, `closing_summary`; locale `km|en`.
- `scenario_steps`: `(scenario_id, step_id)` PK; `sort_order`, `kind` (`story|decision|feedback`), `image_asset_id`, audio references, `version`.
- `step_localizations`: `(scenario_id, step_id, locale)` PK, `body`, `question`, `narration_text`.
- `answer_options`: `(scenario_id, step_id, option_id)` PK, `sort_order`, `safety_category`, `score_value`, optional `next_step_id`.
- `answer_localizations`: `(scenario_id, step_id, option_id, locale)` PK, `label`, `feedback`.
- `media_assets`: `id`, `kind`, `storage_path`, `license_status`, `review_status`, `locale`, `alt_text`, `content_hash`.

Define actual types/FKs/checks based on the reviewed scenario spec. A migration may initially use a versioned JSONB scenario payload to reduce complexity, provided it is schema-validated and can be migrated later. Document the chosen tradeoff before coding; do not build all tables blindly.

### Privileges
Public/mobile client may SELECT **only published, approved, fully bilingual** scenario data and approved media metadata. Drafts, audit logs, contacts awaiting verification, admin records and users' private information must not be globally readable. 
- Every publicly exposed scenario-related table must enforce appropriate permissions and publication-state access rules, including child records and media.
- PostgreSQL privilege statements must use valid SQL syntax and explicit table/schema targets (e.g. `REVOKE ALL ON ALL TABLES IN SCHEMA public FROM public; GRANT SELECT ON TABLE public.scenarios, public.scenario_localizations, public.scenario_steps, public.step_localizations, public.answer_options, public.answer_localizations, public.media_assets TO anon;`).
- Database grants, RLS, Storage policies, and offline caching must be tested before declaring them secure or reliable. RLS and Storage permissions require rigorous positive and negative automated tests before connecting mobile clients (verifying anon read of published data, denial of draft reads, and denial of all insert/update/delete operations).
- No service-role key in Flutter; publishable key only.

### Local SQLite / Drift
- `cached_scenarios`: `scenario_id`, `version`, `locale`, `payload_json`, `fetched_at`, `schema_version`.
- `cached_assets`: `asset_id`, `local_path`, `content_hash`, `download_status`, `last_accessed`.
- `guest_attempts`: `attempt_id`, `scenario_id`, `scenario_version`, `answers_json` by `option_id`, `score_local`, `updated_at`.
- `app_preferences`: `key`, `value` (locale, narration enabled, etc.).
Do not store OTPs, passwords, raw private chats or recovery codes. App uninstall/storage clearing may delete guest progress.

### Content synchronization
1. Online fetch approved version manifest. Supabase connection latency must be measured from Cambodian devices rather than assumed.
2. Validate payload schema, locale completeness and media hashes; download selected scenario and associated assets to cache.
3. Atomically replace cached version after download validation within a single database transaction. Failed update leaves previous valid version available.
4. On offline launch, load cached approved version; if none (first launch offline), show translated offline message and retry button.
5. Offline caching and resilience must be verified through real empirical tests (interrupted downloads, airplane mode launches, database corruptions) rather than described as guaranteed.
6. Keep attempts associated with scenario/version even if content changes.
7. Never upload guest attempts without opt-in user accounts and approved privacy/sync architecture.
8. When data updates, don't merge partial answers from different scenario versions silently.

### Future tables by module (not now)
- `news_sources`, `articles`, `article_translations`, `import_jobs`, `review_events`.
- `videos`, `video_localizations`, `video_assets`, `video_transcripts`.
- `emergency_flows`, `response_steps`, `jurisdiction_reviews`.
- `contacts`, `contact_verifications`, `organization_categories`.
- `safety_assessments`, `assessment_questions`, `answers`, `recommendations`.
- `legal_sources`, `legal_documents`, `document_versions`, `law_questions`.
- `profiles`, `consents`, `progress_events`, `certificates`, `certificate_verifications`.
- `ai_requests` metadata with privacy/retention, `usage_quotas`, `model_config`.
- `audit_logs`, `scheduled_jobs`, `backup_job_records`.
No personal data collection or automatic onboarding just because these future tables are planned.
