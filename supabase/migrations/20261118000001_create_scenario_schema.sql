-- Migration: 20261118000001_create_scenario_schema.sql
-- Description: Core relational schema for ScamPlay scenario library, localizations, steps, answers, media, and version audit.
-- Milestone: M2A (PostgreSQL / Supabase Schema)
-- Engine: PostgreSQL 15+

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Generic updated_at trigger function
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = clock_timestamp();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 1. Scenario Categories
CREATE TABLE public.scenario_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9_\-]+$'),
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp()
);

CREATE TRIGGER trg_scenario_categories_updated_at
BEFORE UPDATE ON public.scenario_categories
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 2. Scenario Category Localizations (km, en)
CREATE TABLE public.scenario_category_localizations (
  category_id UUID NOT NULL REFERENCES public.scenario_categories(id) ON DELETE CASCADE,
  locale TEXT NOT NULL CHECK (locale IN ('km', 'en')),
  name TEXT NOT NULL CHECK (length(trim(name)) > 0),
  description TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  PRIMARY KEY (category_id, locale)
);

CREATE TRIGGER trg_scenario_category_localizations_updated_at
BEFORE UPDATE ON public.scenario_category_localizations
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 3. Media Assets
CREATE TABLE public.media_assets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  storage_path TEXT NOT NULL UNIQUE,
  media_type TEXT NOT NULL CHECK (media_type IN ('image', 'audio', 'video')),
  mime_type TEXT NOT NULL CHECK (length(trim(mime_type)) > 0),
  size_bytes BIGINT CHECK (size_bytes >= 0),
  content_hash TEXT CHECK (content_hash IS NULL OR length(trim(content_hash)) > 0),
  license_status TEXT NOT NULL CHECK (license_status IN ('licensed_demo', 'original', 'unreviewed_placeholder')),
  review_status TEXT NOT NULL CHECK (review_status IN ('approved', 'pending_review', 'rejected')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp()
);

CREATE TRIGGER trg_media_assets_updated_at
BEFORE UPDATE ON public.media_assets
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 4. Media Localizations (Alt text / Captions)
CREATE TABLE public.media_localizations (
  media_asset_id UUID NOT NULL REFERENCES public.media_assets(id) ON DELETE CASCADE,
  locale TEXT NOT NULL CHECK (locale IN ('km', 'en')),
  alt_text TEXT NOT NULL CHECK (length(trim(alt_text)) > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  PRIMARY KEY (media_asset_id, locale)
);

CREATE TRIGGER trg_media_localizations_updated_at
BEFORE UPDATE ON public.media_localizations
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 5. Scenarios (Master Metadata)
CREATE TABLE public.scenarios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9_\-]+$'),
  category_id UUID NOT NULL REFERENCES public.scenario_categories(id) ON DELETE RESTRICT,
  cover_media_id UUID REFERENCES public.media_assets(id) ON DELETE SET NULL,
  estimated_minutes INT NOT NULL CHECK (estimated_minutes > 0),
  status TEXT NOT NULL CHECK (status IN ('draft', 'published', 'archived', 'coming_soon')),
  version INT NOT NULL DEFAULT 1 CHECK (version >= 1),
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  created_by UUID,
  updated_by UUID
);

CREATE TRIGGER trg_scenarios_updated_at
BEFORE UPDATE ON public.scenarios
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE INDEX idx_scenarios_status ON public.scenarios(status);
CREATE INDEX idx_scenarios_category_id ON public.scenarios(category_id);

-- 6. Scenario Localizations (km, en)
CREATE TABLE public.scenario_localizations (
  scenario_id UUID NOT NULL REFERENCES public.scenarios(id) ON DELETE CASCADE,
  locale TEXT NOT NULL CHECK (locale IN ('km', 'en')),
  title TEXT NOT NULL CHECK (length(trim(title)) > 0),
  summary TEXT NOT NULL CHECK (length(trim(summary)) > 0),
  intro TEXT NOT NULL CHECK (length(trim(intro)) > 0),
  closing_summary TEXT NOT NULL CHECK (length(trim(closing_summary)) > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  PRIMARY KEY (scenario_id, locale)
);

CREATE TRIGGER trg_scenario_localizations_updated_at
BEFORE UPDATE ON public.scenario_localizations
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 7. Scenario Steps
CREATE TABLE public.scenario_steps (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  scenario_id UUID NOT NULL REFERENCES public.scenarios(id) ON DELETE CASCADE,
  step_key TEXT NOT NULL CHECK (step_key ~ '^[a-z0-9_\-]+$'),
  kind TEXT NOT NULL CHECK (kind IN ('story', 'decision', 'feedback')),
  order_index INT NOT NULL CHECK (order_index > 0),
  media_asset_id UUID REFERENCES public.media_assets(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  UNIQUE (scenario_id, step_key),
  UNIQUE (scenario_id, order_index)
);

CREATE TRIGGER trg_scenario_steps_updated_at
BEFORE UPDATE ON public.scenario_steps
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE INDEX idx_scenario_steps_scenario_order ON public.scenario_steps(scenario_id, order_index);

-- 8. Step Localizations (km, en)
CREATE TABLE public.step_localizations (
  step_id UUID NOT NULL REFERENCES public.scenario_steps(id) ON DELETE CASCADE,
  locale TEXT NOT NULL CHECK (locale IN ('km', 'en')),
  body_text TEXT NOT NULL CHECK (length(trim(body_text)) > 0),
  narration_media_id UUID REFERENCES public.media_assets(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  PRIMARY KEY (step_id, locale)
);

CREATE TRIGGER trg_step_localizations_updated_at
BEFORE UPDATE ON public.step_localizations
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 9. Answer Options
CREATE TABLE public.answer_options (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  step_id UUID NOT NULL REFERENCES public.scenario_steps(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL CHECK (option_key ~ '^[a-z0-9_\-]+$'),
  order_index INT NOT NULL CHECK (order_index > 0),
  score_value INT NOT NULL DEFAULT 0 CHECK (score_value >= 0),
  safety_category TEXT NOT NULL CHECK (safety_category IN ('safe', 'unsafe', 'caution')),
  next_step_id UUID REFERENCES public.scenario_steps(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  UNIQUE (step_id, option_key),
  UNIQUE (step_id, order_index)
);

CREATE TRIGGER trg_answer_options_updated_at
BEFORE UPDATE ON public.answer_options
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE INDEX idx_answer_options_step_order ON public.answer_options(step_id, order_index);

-- 10. Answer Localizations (km, en)
CREATE TABLE public.answer_localizations (
  option_id UUID NOT NULL REFERENCES public.answer_options(id) ON DELETE CASCADE,
  locale TEXT NOT NULL CHECK (locale IN ('km', 'en')),
  label TEXT NOT NULL CHECK (length(trim(label)) > 0),
  feedback_text TEXT NOT NULL CHECK (length(trim(feedback_text)) > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  PRIMARY KEY (option_id, locale)
);

CREATE TRIGGER trg_answer_localizations_updated_at
BEFORE UPDATE ON public.answer_localizations
FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 11. Scenario Content Version Snapshots (Immutable archival)
CREATE TABLE public.scenario_versions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  scenario_id UUID NOT NULL REFERENCES public.scenarios(id) ON DELETE CASCADE,
  version INT NOT NULL CHECK (version >= 1),
  snapshot_payload JSONB NOT NULL,
  published_at TIMESTAMPTZ NOT NULL,
  archived_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
  created_by UUID,
  UNIQUE (scenario_id, version)
);

CREATE INDEX idx_scenario_versions_lookup ON public.scenario_versions(scenario_id, version);
