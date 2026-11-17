# Supabase Development Environment Setup Guide

**Milestone:** M2A  
**Target Environment:** Development Only (Separate from future staging/production)  
**Cost Tier:** Free Tier ($0.00 / month) — *Do not enable paid add-ons or Pro compute.*

---

## 1. Project Creation Steps

1. **Sign in / Sign up to Supabase:**
   - Navigate to [https://supabase.com](https://supabase.com) and sign in using your development account.
2. **Create New Project:**
   - Click **"New Project"**.
   - Select your organization.
   - **Name:** `scamplay-dev` (clearly labeled development).
   - **Database Password:** Generate a strong, unique password and store it securely in a password manager. *(Never share this password in chat or commit it to Git).*
   - **Region:** Select **Southeast Asia (Singapore - ap-southeast-1)**.
     > *Note: While Singapore is geographically nearest to Cambodia, round-trip latency must be empirically measured from local mobile networks rather than assumed.*
   - **Pricing Plan:** Select **Free Tier** ($0/month).
3. **Wait for Provisioning:**
   - Supabase will take approximately 1–2 minutes to provision the PostgreSQL instance.

---

## 2. Migration Execution Order

Execute the following migrations in exact chronological order via the **Supabase Dashboard -> SQL Editor**:

1. **`supabase/migrations/20261118000001_create_scenario_schema.sql`**
   - Creates the 11 relational tables: `scenario_categories`, `scenario_category_localizations`, `media_assets`, `media_localizations`, `scenarios`, `scenario_localizations`, `scenario_steps`, `step_localizations`, `answer_options`, `answer_localizations`, `scenario_versions`.
   - Sets up indexes, updated_at triggers, and check constraints.
2. **`supabase/migrations/20261118000002_security_and_rls_policies.sql`**
   - Revokes broad public access.
   - Grants least-privilege `SELECT` on content tables to `anon` and `authenticated`.
   - Enables Row Level Security (RLS) on all tables.
   - Enforces publication gates: anonymous users can only retrieve scenarios with `status IN ('published', 'coming_soon')` for card metadata, and **only** `status = 'published'` for child steps, options, and explanations.
   - Configures storage bucket security policies.
3. **`supabase/migrations/20261118000003_seed_scenarios.sql`**
   - Seeds 1 complete published scenario (`telegram-messenger-takeover`) with bilingual content (Khmer and English).
   - Seeds 3 sample scenarios marked `coming_soon` (`fake-online-store`, `bank-impersonation`, `fake-investment`).
   - Seeds 1 draft scenario and 1 archived scenario used exclusively to verify negative RLS denial.

---

## 3. Security Verification Suite Execution

In the **Supabase Dashboard -> SQL Editor**:
1. Copy and paste the contents of `tests/sql/m2a_verification_suite.sql`.
2. Click **"Run"**.
3. Confirm that all 9 tests pass:
   - Schema integrity & table existence.
   - Foreign key constraint enforcement.
   - Unique key constraint enforcement.
   - Positive anonymous read for published tree.
   - Negative anonymous denial for draft & archived scenarios.
   - Negative anonymous denial for child tables on unpublished scenarios.
   - Negative anonymous denial of INSERT/UPDATE/DELETE mutations.
   - Media asset review status filtering.
   - Bilingual completeness across all published nodes.
4. The transaction terminates with `ROLLBACK;`, leaving the database clean and safe.

---

## 4. Environment Variables & Secret Handling

Once verified:
1. In the Supabase Dashboard, go to **Project Settings -> API**.
2. Locate:
   - **Project URL** (e.g. `https://xyzcompany.supabase.co`)
   - **Project API Keys -> anon (public)**
3. Copy `.env.example` to `.env.local` (which is in `.gitignore`):
   ```bash
   NEXT_PUBLIC_SUPABASE_URL=https://<your-project-ref>.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=<your-anon-key>
   ```
4. **CRITICAL SECURITY RULE:**
   - **NEVER** expose the `service_role` secret key to Flutter or mobile clients.
   - **NEVER** commit `.env` or `.env.local` to Git.
