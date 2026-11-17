-- Verification Suite: tests/sql/m2a_verification_suite.sql
-- Description: Rigorous PostgreSQL automated security, schema, and RLS test harness for ScamPlay M2A.
-- Milestone: M2A (PostgreSQL / Supabase Schema & Security)
-- Execution: Run in Supabase SQL Editor or psql connected to the development database.

BEGIN;

DO $$
DECLARE
  v_count INT;
  v_err_caught BOOLEAN;
  v_test_name TEXT;
BEGIN
  RAISE NOTICE '============================================================';
  RAISE NOTICE 'BEGINNING SCAMPLAY M2A AUTOMATED VERIFICATION SUITE';
  RAISE NOTICE '============================================================';

  ----------------------------------------------------------------------------
  -- TEST 1: Schema Integrity & Table Existence
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 1: Schema Integrity & Table Existence';
  SELECT count(*) INTO v_count
  FROM information_schema.tables
  WHERE table_schema = 'public'
    AND table_name IN (
      'scenario_categories',
      'scenario_category_localizations',
      'media_assets',
      'media_localizations',
      'scenarios',
      'scenario_localizations',
      'scenario_steps',
      'step_localizations',
      'answer_options',
      'answer_localizations',
      'scenario_versions'
    );

  IF v_count <> 11 THEN
    RAISE EXCEPTION '% FAILED: Expected 11 tables in public schema, found %', v_test_name, v_count;
  END IF;
  RAISE NOTICE '  [PASS] %: All 11 relational tables exist.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 2: Foreign Key Constraints & Data Integrity
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 2: Foreign Key Constraint Enforcement';
  v_err_caught := FALSE;
  BEGIN
    -- Attempt to insert scenario with non-existent category
    INSERT INTO public.scenarios (id, slug, category_id, estimated_minutes, status)
    VALUES (gen_random_uuid(), 'invalid-fk-test', gen_random_uuid(), 5, 'draft');
  EXCEPTION WHEN foreign_key_violation THEN
    v_err_caught := TRUE;
  END;

  IF NOT v_err_caught THEN
    RAISE EXCEPTION '% FAILED: Foreign key violation was not triggered for invalid category_id.', v_test_name;
  END IF;
  RAISE NOTICE '  [PASS] %: Foreign key integrity strictly enforced.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 3: Uniqueness Constraints (Step Key per Scenario)
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 3: Unique Constraint Enforcement';
  v_err_caught := FALSE;
  BEGIN
    -- Attempt duplicate step_key in same scenario
    INSERT INTO public.scenario_steps (scenario_id, step_key, kind, order_index)
    VALUES ('s1000000-0000-0000-0000-000000000001', 'story-01', 'story', 99);
  EXCEPTION WHEN unique_violation THEN
    v_err_caught := TRUE;
  END;

  IF NOT v_err_caught THEN
    RAISE EXCEPTION '% FAILED: Unique constraint on (scenario_id, step_key) not enforced.', v_test_name;
  END IF;
  RAISE NOTICE '  [PASS] %: Unique step constraint strictly enforced.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 4: Positive Anonymous Read — Published Scenario & Tree
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 4: Positive Anonymous Read (Published Tree)';
  -- Impersonate anon client
  SET LOCAL ROLE anon;

  -- 4a: Scenario Master
  SELECT count(*) INTO v_count
  FROM public.scenarios
  WHERE id = 's1000000-0000-0000-0000-000000000001' AND status = 'published';
  IF v_count <> 1 THEN
    RAISE EXCEPTION '% FAILED: Published scenario not readable by anon role.', v_test_name;
  END IF;

  -- 4b: Scenario Localizations (km, en)
  SELECT count(*) INTO v_count
  FROM public.scenario_localizations
  WHERE scenario_id = 's1000000-0000-0000-0000-000000000001';
  IF v_count <> 2 THEN
    RAISE EXCEPTION '% FAILED: Expected 2 scenario localizations (km, en), found %', v_test_name, v_count;
  END IF;

  -- 4c: Scenario Steps
  SELECT count(*) INTO v_count
  FROM public.scenario_steps
  WHERE scenario_id = 's1000000-0000-0000-0000-000000000001';
  IF v_count <> 4 THEN
    RAISE EXCEPTION '% FAILED: Expected 4 steps for published scenario, found %', v_test_name, v_count;
  END IF;

  -- 4d: Step Localizations (4 steps * 2 locales = 8)
  SELECT count(*) INTO v_count
  FROM public.step_localizations sl
  JOIN public.scenario_steps ss ON ss.id = sl.step_id
  WHERE ss.scenario_id = 's1000000-0000-0000-0000-000000000001';
  IF v_count <> 8 THEN
    RAISE EXCEPTION '% FAILED: Expected 8 step localizations, found %', v_test_name, v_count;
  END IF;

  -- 4e: Answer Options (6 options across 2 decision steps)
  SELECT count(*) INTO v_count
  FROM public.answer_options ao
  JOIN public.scenario_steps ss ON ss.id = ao.step_id
  WHERE ss.scenario_id = 's1000000-0000-0000-0000-000000000001';
  IF v_count <> 6 THEN
    RAISE EXCEPTION '% FAILED: Expected 6 answer options, found %', v_test_name, v_count;
  END IF;

  -- 4f: Answer Localizations (6 options * 2 locales = 12)
  SELECT count(*) INTO v_count
  FROM public.answer_localizations al
  JOIN public.answer_options ao ON ao.id = al.option_id
  JOIN public.scenario_steps ss ON ss.id = ao.step_id
  WHERE ss.scenario_id = 's1000000-0000-0000-0000-000000000001';
  IF v_count <> 12 THEN
    RAISE EXCEPTION '% FAILED: Expected 12 answer localizations, found %', v_test_name, v_count;
  END IF;
  RAISE NOTICE '  [PASS] %: Complete published scenario tree accessible to anon role.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 5: Negative Anonymous Read — Draft & Archived Scenarios
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 5: Negative Anonymous Read (Draft & Archived Isolation)';
  -- 5a: Draft scenario must not appear in anon SELECT
  SELECT count(*) INTO v_count
  FROM public.scenarios
  WHERE id = 's1000000-0000-0000-0000-000000000005'; -- Draft ID
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Draft scenario leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;

  -- 5b: Archived scenario must not appear in anon SELECT
  SELECT count(*) INTO v_count
  FROM public.scenarios
  WHERE id = 's1000000-0000-0000-0000-000000000006'; -- Archived ID
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Archived scenario leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;

  -- 5c: Localizations of draft/archived scenarios must not leak
  SELECT count(*) INTO v_count
  FROM public.scenario_localizations
  WHERE scenario_id IN ('s1000000-0000-0000-0000-000000000005', 's1000000-0000-0000-0000-000000000006');
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Draft/Archived localizations leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;
  RAISE NOTICE '  [PASS] %: Draft and Archived scenarios completely shielded from anon.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 6: Negative Anonymous Read — Child Tables for Unpublished/Coming-Soon
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 6: Negative Anonymous Read (Child Table Isolation)';
  -- 6a: Direct query on scenario_steps for draft step
  SELECT count(*) INTO v_count
  FROM public.scenario_steps
  WHERE id = 'st000000-0000-0000-0000-000000000099';
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Draft step leaked directly to anon role! Found % rows.', v_test_name, v_count;
  END IF;

  -- 6b: Direct query on step_localizations for draft step
  SELECT count(*) INTO v_count
  FROM public.step_localizations
  WHERE step_id = 'st000000-0000-0000-0000-000000000099';
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Draft step localization leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;

  -- 6c: Direct query on answer_options for draft option
  SELECT count(*) INTO v_count
  FROM public.answer_options
  WHERE id = 'op000000-0000-0000-0000-000000000099';
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Draft answer option leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;

  -- 6d: Coming Soon scenarios must have ZERO child steps accessible
  SELECT count(*) INTO v_count
  FROM public.scenario_steps ss
  JOIN public.scenarios s ON s.id = ss.scenario_id
  WHERE s.status = 'coming_soon';
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Coming soon scenario child steps leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;
  RAISE NOTICE '  [PASS] %: Child table RLS policies cannot be bypassed.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 7: Negative Anonymous Mutation Denial (INSERT/UPDATE/DELETE)
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 7: Negative Anonymous Mutation Denial';
  -- 7a: INSERT rejection
  v_err_caught := FALSE;
  BEGIN
    INSERT INTO public.scenarios (slug, category_id, estimated_minutes, status)
    VALUES ('anon-tamper-scenario', 'c1000000-0000-0000-0000-000000000001', 5, 'published');
  EXCEPTION WHEN insufficient_privilege THEN
    v_err_caught := TRUE;
  END;
  IF NOT v_err_caught THEN
    RAISE EXCEPTION '% FAILED: Anonymous INSERT into scenarios was permitted!', v_test_name;
  END IF;

  -- 7b: UPDATE rejection
  v_err_caught := FALSE;
  BEGIN
    UPDATE public.scenarios
    SET status = 'draft'
    WHERE id = 's1000000-0000-0000-0000-000000000001';
  EXCEPTION WHEN insufficient_privilege THEN
    v_err_caught := TRUE;
  END;
  IF NOT v_err_caught THEN
    RAISE EXCEPTION '% FAILED: Anonymous UPDATE on scenarios was permitted!', v_test_name;
  END IF;

  -- 7c: DELETE rejection
  v_err_caught := FALSE;
  BEGIN
    DELETE FROM public.scenarios
    WHERE id = 's1000000-0000-0000-0000-000000000001';
  EXCEPTION WHEN insufficient_privilege THEN
    v_err_caught := TRUE;
  END;
  IF NOT v_err_caught THEN
    RAISE EXCEPTION '% FAILED: Anonymous DELETE on scenarios was permitted!', v_test_name;
  END IF;
  RAISE NOTICE '  [PASS] %: Anonymous INSERT, UPDATE, DELETE strictly rejected by PostgreSQL privileges.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 8: Media Asset Access Control (review_status filtering)
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 8: Media Asset Access Control';
  -- Approved media must be readable
  SELECT count(*) INTO v_count
  FROM public.media_assets
  WHERE id = 'm1000000-0000-0000-0000-000000000001' AND review_status = 'approved';
  IF v_count <> 1 THEN
    RAISE EXCEPTION '% FAILED: Approved media asset not readable by anon role.', v_test_name;
  END IF;

  -- Unreviewed / Pending media must NOT be readable
  SELECT count(*) INTO v_count
  FROM public.media_assets
  WHERE id = 'm1000000-0000-0000-0000-000000000099';
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Pending review media leaked to anon role! Found % rows.', v_test_name, v_count;
  END IF;
  RAISE NOTICE '  [PASS] %: Only approved media assets readable by anon.', v_test_name;

  ----------------------------------------------------------------------------
  -- TEST 9: Bilingual Data Completeness Verification
  ----------------------------------------------------------------------------
  v_test_name := 'TEST 9: Bilingual Parity Verification';
  -- Switch back to postgres role for full completeness scan
  RESET ROLE;

  -- Verify each published scenario has both km and en localizations
  SELECT count(*) INTO v_count
  FROM public.scenarios s
  WHERE s.status = 'published'
    AND (
      (SELECT count(*) FROM public.scenario_localizations sl WHERE sl.scenario_id = s.id AND sl.locale = 'km') <> 1
      OR
      (SELECT count(*) FROM public.scenario_localizations sl WHERE sl.scenario_id = s.id AND sl.locale = 'en') <> 1
    );
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Published scenario lacks complete km/en localization pair.', v_test_name;
  END IF;

  -- Verify each step in published scenario has both km and en localizations
  SELECT count(*) INTO v_count
  FROM public.scenario_steps ss
  JOIN public.scenarios s ON s.id = ss.scenario_id
  WHERE s.status = 'published'
    AND (
      (SELECT count(*) FROM public.step_localizations sl WHERE sl.step_id = ss.id AND sl.locale = 'km') <> 1
      OR
      (SELECT count(*) FROM public.step_localizations sl WHERE sl.step_id = ss.id AND sl.locale = 'en') <> 1
    );
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Published scenario step lacks complete km/en localization pair.', v_test_name;
  END IF;

  -- Verify each answer option in published scenario has both km and en localizations
  SELECT count(*) INTO v_count
  FROM public.answer_options ao
  JOIN public.scenario_steps ss ON ss.id = ao.step_id
  JOIN public.scenarios s ON s.id = ss.scenario_id
  WHERE s.status = 'published'
    AND (
      (SELECT count(*) FROM public.answer_localizations al WHERE al.option_id = ao.id AND al.locale = 'km') <> 1
      OR
      (SELECT count(*) FROM public.answer_localizations al WHERE al.option_id = ao.id AND al.locale = 'en') <> 1
    );
  IF v_count <> 0 THEN
    RAISE EXCEPTION '% FAILED: Published answer option lacks complete km/en localization pair.', v_test_name;
  END IF;
  RAISE NOTICE '  [PASS] %: 100%% bilingual parity verified across all published scenario content.', v_test_name;

  RAISE NOTICE '============================================================';
  RAISE NOTICE 'ALL 9 M2A VERIFICATION TESTS PASSED SUCCESSFULLY!';
  RAISE NOTICE '============================================================';
END $$;

ROLLBACK;
