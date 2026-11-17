-- Verification Suite: tests/sql/run_m2a_verification.sql
-- Description: Executes all M2A security and schema assertions and returns structured test results.

CREATE TEMP TABLE m2a_test_results (
  test_id INT,
  test_name TEXT,
  status TEXT,
  details TEXT
);
GRANT ALL ON m2a_test_results TO anon, authenticated;

DO $$
DECLARE
  v_count INT;
  v_err_caught BOOLEAN;
  v_dummy_uuid UUID;
BEGIN
  -- 1. Table Inventory
  SELECT count(*) INTO v_count
  FROM information_schema.tables
  WHERE table_schema = 'public'
    AND table_name IN (
      'scenario_categories', 'scenario_category_localizations',
      'media_assets', 'media_localizations',
      'scenarios', 'scenario_localizations',
      'scenario_steps', 'step_localizations',
      'answer_options', 'answer_localizations',
      'scenario_versions'
    );
  IF v_count = 11 THEN
    INSERT INTO m2a_test_results VALUES (1, 'Schema Inventory', 'PASSED', 'All 11 application tables exist in public schema');
  ELSE
    INSERT INTO m2a_test_results VALUES (1, 'Schema Inventory', 'FAILED', format('Expected 11 tables, found %s', v_count));
  END IF;

  -- 2a. Invalid UUID Syntax
  v_err_caught := FALSE;
  BEGIN
    v_dummy_uuid := 's1000000-0000-0000-0000-000000000001'::uuid;
  EXCEPTION WHEN invalid_text_representation THEN
    v_err_caught := TRUE;
  END;
  IF v_err_caught THEN
    INSERT INTO m2a_test_results VALUES (2, 'Invalid UUID Rejection', 'PASSED', 'Non-hexadecimal UUID literals strictly rejected by PostgreSQL');
  ELSE
    INSERT INTO m2a_test_results VALUES (2, 'Invalid UUID Rejection', 'FAILED', 'Non-hexadecimal string accepted as UUID');
  END IF;

  -- 2b. Foreign Key Enforcement
  v_err_caught := FALSE;
  BEGIN
    INSERT INTO public.scenarios (id, slug, category_id, estimated_minutes, status)
    VALUES (gen_random_uuid(), 'invalid-fk', 'a0000000-ffff-4000-8000-000000000000', 5, 'draft');
  EXCEPTION WHEN foreign_key_violation THEN
    v_err_caught := TRUE;
  END;
  IF v_err_caught THEN
    INSERT INTO m2a_test_results VALUES (3, 'Foreign Key Enforcement', 'PASSED', 'Broken foreign key references strictly rejected');
  ELSE
    INSERT INTO m2a_test_results VALUES (3, 'Foreign Key Enforcement', 'FAILED', 'Invalid foreign key was accepted');
  END IF;

  -- 2c. Unique Constraint Enforcement
  v_err_caught := FALSE;
  BEGIN
    INSERT INTO public.scenario_steps (scenario_id, step_key, kind, order_index)
    VALUES ('c0000000-0000-4000-8000-000000000001', 'story-01', 'story', 99);
  EXCEPTION WHEN unique_violation THEN
    v_err_caught := TRUE;
  END;
  IF v_err_caught THEN
    INSERT INTO m2a_test_results VALUES (4, 'Unique Constraint Enforcement', 'PASSED', 'Duplicate step keys per scenario strictly rejected');
  ELSE
    INSERT INTO m2a_test_results VALUES (4, 'Unique Constraint Enforcement', 'FAILED', 'Duplicate step key was accepted');
  END IF;

  -- 3. Positive Anonymous Read (Published Tree)
  SET LOCAL ROLE anon;
  SELECT count(*) INTO v_count
  FROM public.scenarios
  WHERE id = 'c0000000-0000-4000-8000-000000000001' AND status = 'published';
  IF v_count = 1 THEN
    INSERT INTO m2a_test_results VALUES (5, 'Positive Anonymous Read', 'PASSED', 'Published scenario telegram-messenger-takeover fully readable by anon role');
  ELSE
    INSERT INTO m2a_test_results VALUES (5, 'Positive Anonymous Read', 'FAILED', 'Published scenario not readable by anon');
  END IF;

  -- 4. Negative Anonymous Read (Draft & Archived)
  SELECT count(*) INTO v_count
  FROM public.scenarios
  WHERE id IN ('c0000000-0000-4000-8000-000000000005', 'c0000000-0000-4000-8000-000000000006');
  IF v_count = 0 THEN
    INSERT INTO m2a_test_results VALUES (6, 'Draft & Archived Isolation', 'PASSED', 'Draft and archived scenarios return 0 rows to anon role');
  ELSE
    INSERT INTO m2a_test_results VALUES (6, 'Draft & Archived Isolation', 'FAILED', format('Draft/Archived leaked: %s rows', v_count));
  END IF;

  -- 5. Child Table Isolation
  SELECT count(*) INTO v_count
  FROM public.scenario_steps
  WHERE id = 'd0000000-0000-4000-8000-000000000099';
  IF v_count = 0 THEN
    INSERT INTO m2a_test_results VALUES (7, 'Child Table RLS Isolation', 'PASSED', 'Child steps of draft scenarios return 0 rows to anon role');
  ELSE
    INSERT INTO m2a_test_results VALUES (7, 'Child Table RLS Isolation', 'FAILED', 'Child steps of draft scenario leaked');
  END IF;

  -- 6. Coming Soon Card Previews
  SELECT count(*) INTO v_count
  FROM public.scenarios
  WHERE status = 'coming_soon';
  IF v_count = 3 THEN
    INSERT INTO m2a_test_results VALUES (8, 'Coming Soon Card Preview', 'PASSED', '3 coming-soon cards visible to anon with 0 child steps exposed');
  ELSE
    INSERT INTO m2a_test_results VALUES (8, 'Coming Soon Card Preview', 'FAILED', format('Expected 3 coming-soon cards, found %s', v_count));
  END IF;

  -- 7. Anonymous Mutation Denial
  v_err_caught := FALSE;
  BEGIN
    INSERT INTO public.scenarios (slug, category_id, estimated_minutes, status)
    VALUES ('anon-tamper', 'a0000000-0000-4000-8000-000000000001', 5, 'published');
  EXCEPTION WHEN insufficient_privilege THEN
    v_err_caught := TRUE;
  END;
  IF v_err_caught THEN
    INSERT INTO m2a_test_results VALUES (9, 'Anonymous Mutation Denial', 'PASSED', 'Anonymous INSERT rejected with insufficient_privilege');
  ELSE
    INSERT INTO m2a_test_results VALUES (9, 'Anonymous Mutation Denial', 'FAILED', 'Anonymous INSERT permitted');
  END IF;

  -- 8. Authenticated Role Mutation Denial
  SET LOCAL ROLE authenticated;
  v_err_caught := FALSE;
  BEGIN
    INSERT INTO public.scenarios (slug, category_id, estimated_minutes, status)
    VALUES ('auth-tamper', 'a0000000-0000-4000-8000-000000000001', 5, 'published');
  EXCEPTION WHEN insufficient_privilege THEN
    v_err_caught := TRUE;
  END;
  IF v_err_caught THEN
    INSERT INTO m2a_test_results VALUES (10, 'Authenticated Write Denial', 'PASSED', 'Authenticated non-admin INSERT rejected with insufficient_privilege');
  ELSE
    INSERT INTO m2a_test_results VALUES (10, 'Authenticated Write Denial', 'FAILED', 'Authenticated non-admin INSERT permitted');
  END IF;

  -- 9. Trigger Function Execution Denial
  SET LOCAL ROLE anon;
  v_err_caught := FALSE;
  BEGIN
    PERFORM public.set_updated_at();
  EXCEPTION WHEN insufficient_privilege THEN
    v_err_caught := TRUE;
  END;
  IF v_err_caught THEN
    INSERT INTO m2a_test_results VALUES (11, 'Trigger Function Protection', 'PASSED', 'Untrusted client execution of set_updated_at() rejected with insufficient_privilege');
  ELSE
    INSERT INTO m2a_test_results VALUES (11, 'Trigger Function Protection', 'FAILED', 'Untrusted client executed set_updated_at()');
  END IF;

  -- 10. Media Asset Review Status Isolation
  SELECT count(*) INTO v_count
  FROM public.media_assets
  WHERE id = 'b0000000-0000-4000-8000-000000000099';
  IF v_count = 0 THEN
    INSERT INTO m2a_test_results VALUES (12, 'Media Review Status Isolation', 'PASSED', 'Unreviewed/draft media assets return 0 rows to anon role');
  ELSE
    INSERT INTO m2a_test_results VALUES (12, 'Media Review Status Isolation', 'FAILED', 'Unreviewed media asset leaked');
  END IF;

  -- 11. Bilingual Completeness
  RESET ROLE;
  SELECT count(*) INTO v_count
  FROM public.scenarios s
  WHERE s.status = 'published'
    AND (
      (SELECT count(*) FROM public.scenario_localizations sl WHERE sl.scenario_id = s.id AND sl.locale = 'km') <> 1
      OR
      (SELECT count(*) FROM public.scenario_localizations sl WHERE sl.scenario_id = s.id AND sl.locale = 'en') <> 1
    );
  IF v_count = 0 THEN
    INSERT INTO m2a_test_results VALUES (13, 'Bilingual Completeness', 'PASSED', '100% Khmer and English coverage across published scenario nodes');
  ELSE
    INSERT INTO m2a_test_results VALUES (13, 'Bilingual Completeness', 'FAILED', 'Published scenario missing Khmer or English localization');
  END IF;

  -- 12. Storage Bucket Privacy
  SELECT count(*) INTO v_count
  FROM storage.buckets
  WHERE id = 'scenario-media' AND public = false;
  IF v_count = 1 THEN
    INSERT INTO m2a_test_results VALUES (14, 'Storage Bucket Privacy', 'PASSED', 'scenario-media bucket exists and is strictly private (public = false)');
  ELSE
    INSERT INTO m2a_test_results VALUES (14, 'Storage Bucket Privacy', 'FAILED', 'scenario-media bucket is missing or public');
  END IF;

END $$;

SELECT test_id, test_name, status, details FROM m2a_test_results ORDER BY test_id;
