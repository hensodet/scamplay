-- Migration: 20261118000002_security_and_rls_policies.sql
-- Description: Explicit PostgreSQL privileges, publication-gated Row Level Security (RLS) policies, and storage security.
-- Milestone: M2A (PostgreSQL / Supabase Schema & Security)
-- Engine: PostgreSQL 15+

-- 1. Explicit Privileges (Least Privilege Principle)
-- Safely revoke all permissions from public, anon, and authenticated on ScamPlay application tables
REVOKE ALL ON TABLE
  public.scenario_categories,
  public.scenario_category_localizations,
  public.media_assets,
  public.media_localizations,
  public.scenarios,
  public.scenario_localizations,
  public.scenario_steps,
  public.step_localizations,
  public.answer_options,
  public.answer_localizations,
  public.scenario_versions
FROM public, anon, authenticated;

-- Grant explicit least-privilege SELECT to anon and authenticated clients for published content
GRANT SELECT ON TABLE
  public.scenario_categories,
  public.scenario_category_localizations,
  public.media_assets,
  public.media_localizations,
  public.scenarios,
  public.scenario_localizations,
  public.scenario_steps,
  public.step_localizations,
  public.answer_options,
  public.answer_localizations,
  public.scenario_versions
TO anon, authenticated;

-- Allow execution of trigger functions for timestamp tracking
GRANT EXECUTE ON FUNCTION public.set_updated_at() TO anon, authenticated, service_role;

-- CRITICAL SECURITY RULE: NO INSERT, UPDATE, DELETE permissions are granted to anon or authenticated clients.
-- Authenticated users do NOT automatically receive administrative rights.
-- Mutations are strictly reserved for service_role / backend administration.

-- 2. Enable Row Level Security (RLS) on all 11 application tables
ALTER TABLE public.scenario_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scenario_category_localizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.media_assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.media_localizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scenarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scenario_localizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scenario_steps ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.step_localizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.answer_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.answer_localizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scenario_versions ENABLE ROW LEVEL SECURITY;

-- 3. RLS Policies: scenario_categories
-- Readable if at least one associated scenario is published or coming_soon
CREATE POLICY "anon_select_scenario_categories"
ON public.scenario_categories
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenarios s
    WHERE s.category_id = scenario_categories.id
      AND s.status IN ('published', 'coming_soon')
  )
);

-- 4. RLS Policies: scenario_category_localizations
CREATE POLICY "anon_select_scenario_category_localizations"
ON public.scenario_category_localizations
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenarios s
    WHERE s.category_id = scenario_category_localizations.category_id
      AND s.status IN ('published', 'coming_soon')
  )
);

-- 5. RLS Policies: media_assets
-- Only approved media assets are readable
CREATE POLICY "anon_select_media_assets"
ON public.media_assets
FOR SELECT
TO anon, authenticated
USING (review_status = 'approved');

-- 6. RLS Policies: media_localizations
CREATE POLICY "anon_select_media_localizations"
ON public.media_localizations
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.media_assets ma
    WHERE ma.id = media_localizations.media_asset_id
      AND ma.review_status = 'approved'
  )
);

-- 7. RLS Policies: scenarios (Parent Table)
-- Only published and coming_soon scenarios are visible in the library
CREATE POLICY "anon_select_scenarios"
ON public.scenarios
FOR SELECT
TO anon, authenticated
USING (status IN ('published', 'coming_soon'));

-- 8. RLS Policies: scenario_localizations
CREATE POLICY "anon_select_scenario_localizations"
ON public.scenario_localizations
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenarios s
    WHERE s.id = scenario_localizations.scenario_id
      AND s.status IN ('published', 'coming_soon')
  )
);

-- 9. RLS Policies: scenario_steps (Child Table)
-- CRITICAL SECURITY RULE: Child steps are accessible ONLY if the parent scenario is 'published'.
-- 'coming_soon', 'draft', and 'archived' scenarios NEVER expose steps!
CREATE POLICY "anon_select_scenario_steps"
ON public.scenario_steps
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenarios s
    WHERE s.id = scenario_steps.scenario_id
      AND s.status = 'published'
  )
);

-- 10. RLS Policies: step_localizations (Child Table)
CREATE POLICY "anon_select_step_localizations"
ON public.step_localizations
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenario_steps st
    JOIN public.scenarios s ON s.id = st.scenario_id
    WHERE st.id = step_localizations.step_id
      AND s.status = 'published'
  )
);

-- 11. RLS Policies: answer_options (Child Table)
CREATE POLICY "anon_select_answer_options"
ON public.answer_options
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenario_steps st
    JOIN public.scenarios s ON s.id = st.scenario_id
    WHERE st.id = answer_options.step_id
      AND s.status = 'published'
  )
);

-- 12. RLS Policies: answer_localizations (Child Table)
CREATE POLICY "anon_select_answer_localizations"
ON public.answer_localizations
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.answer_options ao
    JOIN public.scenario_steps st ON st.id = ao.step_id
    JOIN public.scenarios s ON s.id = st.scenario_id
    WHERE ao.id = answer_localizations.option_id
      AND s.status = 'published'
  )
);

-- 13. RLS Policies: scenario_versions
CREATE POLICY "anon_select_scenario_versions"
ON public.scenario_versions
FOR SELECT
TO anon, authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.scenarios s
    WHERE s.id = scenario_versions.scenario_id
      AND s.status = 'published'
  )
);

-- 14. Storage Bucket Configuration (Conditional on Supabase storage schema presence)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'storage' AND tablename = 'buckets') THEN
    INSERT INTO storage.buckets (id, name, public)
    VALUES ('scenario-media', 'scenario-media', false)
    ON CONFLICT (id) DO NOTHING;
  END IF;

  IF EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'storage' AND tablename = 'objects') THEN
    DROP POLICY IF EXISTS "anon_select_approved_scenario_media" ON storage.objects;

    CREATE POLICY "anon_select_approved_scenario_media"
    ON storage.objects
    FOR SELECT
    TO anon, authenticated
    USING (
      bucket_id = 'scenario-media'
      AND EXISTS (
        SELECT 1 FROM public.media_assets ma
        WHERE ma.storage_path = storage.objects.name
          AND ma.review_status = 'approved'
      )
    );
  END IF;
END $$;
