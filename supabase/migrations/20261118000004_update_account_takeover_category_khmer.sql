-- Migration: 20261118000004_update_account_takeover_category_khmer.sql
-- Description: Update Khmer display name for Account Takeover category to 'ការលួចយកគណនី'.
-- Original value: 'ការបន្លំដណ្ដើមគណនី'
-- Target table: public.scenario_category_localizations
-- Category ID: a0000000-0000-4000-8000-000000000001 (slug: account_takeover)
-- Environment: Development project (scamplay-dev)
--
-- Safe Rollback Statement:
--   UPDATE public.scenario_category_localizations
--   SET name = 'ការបន្លំដណ្ដើមគណនី', updated_at = clock_timestamp()
--   WHERE category_id = 'a0000000-0000-4000-8000-000000000001' AND locale = 'km';

UPDATE public.scenario_category_localizations
SET name = 'ការលួចយកគណនី',
    updated_at = clock_timestamp()
WHERE category_id = 'a0000000-0000-4000-8000-000000000001'
  AND locale = 'km';
