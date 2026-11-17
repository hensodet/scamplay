# Content Versioning & Migration Architecture

**Milestone:** M2A Architecture & Specifications  
**Status:** Approved Specification  

---

## 1. Stable Identifier Strategy

To prevent broken references, orphaned assets, and analytics fragmentation across content revisions, ScamPlay enforces a dual-identifier strategy:

| Level | Physical Primary Key | Logical Semantic Key | Purpose |
| :--- | :--- | :--- | :--- |
| **Scenario** | `id` (UUIDv4) | `slug` (e.g. `telegram-messenger-takeover`) | Stable cross-platform URL and bundle reference. |
| **Step** | `id` (UUIDv4) | `step_key` (e.g. `story-01`, `decision-01`) | Deterministic node ordering and branching target. |
| **Option** | `id` (UUIDv4) | `option_key` (e.g. `verify`, `share`, `ignore`) | User decision tracking and analytical aggregation. |
| **Media** | `id` (UUIDv4) | `storage_path` (e.g. `covers/telegram_takeover.webp`) | Content-hashed file path in Supabase Storage. |

---

## 2. Publication Lifecycle & State Transitions

Scenarios transition through a strict, controlled state machine:

```
[draft] 
   │
   ├── (Optional library preview card) ──> [coming_soon]
   │                                              │
   └── (Admin publication after review) ──────────┴─────> [published]
                                                              │
                                                              └── (Withdrawal) ──> [archived]
```

- **`draft`**: Invisible to public clients (`anon` returns 0 rows). Child steps, options, and localizations are strictly shielded.
- **`coming_soon`**: Exposes only high-level card metadata (title, summary, estimated minutes) in the Scenario Library with a disabled badge. Child steps and questions return 0 rows.
- **`published`**: Fully readable by public clients. Enables playback, questions, options, and explanations.
- **`archived`**: Withdrawn from the active library. Public queries return 0 rows. Historical attempt records remain preserved.

---

## 3. Immutable Version Archival (`scenario_versions`)

When an administrator updates a published scenario:
1. The master record `scenarios.version` is incremented (`version = version + 1`).
2. The previous version payload is frozen as an immutable JSONB document in `scenario_versions`:
   ```sql
   INSERT INTO public.scenario_versions (scenario_id, version, snapshot_payload, published_at)
   VALUES (..., previous_version, payload_json, previous_published_at);
   ```
3. This creates a permanent, tamper-evident audit trail of all published curriculum versions.

---

## 4. Mobile SQLite Synchronization & Attempt Preservation (Future M2B)

When the mobile app updates its local cache:

1. **Manifest Comparison:**
   - The mobile client queries the published manifest. If `remote_version > cached_version`, an update is flagged.
2. **Atomic Cache Replacement:**
   - The new scenario payload is validated against `contracts/scenario.schema.json` and inserted into SQLite within a single database transaction.
3. **Preservation of User Guest Attempts:**
   - User progress in SQLite is stored in `guest_attempts`:
     - `attempt_id` (UUID)
     - `scenario_id` (Text slug)
     - `scenario_version` (Integer)
     - `answers_json` (Map of `option_key` -> selected)
     - `score_local` (Integer)
     - `completed_at` (Timestamp)
   - **Critical Rule:** Updating scenario content to `version 2` **never** alters or overwrites historical attempts recorded under `version 1`. The user's past completion certificates and lesson history remain intact.
