-- Migration: 20261118000003_seed_scenarios.sql
-- Description: Seed demonstration content for ScamPlay M2A.
-- Content: 1 published scenario, 3 coming soon scenarios, 1 draft scenario (for RLS test), 1 archived scenario (for RLS test).
-- Note: All content is educational, fictional, and rights-neutral. Real victim data/OTPs are strictly excluded.
-- Milestone: M2A (PostgreSQL / Supabase Schema & Security)

-- 1. Categories
INSERT INTO public.scenario_categories (id, slug, sort_order)
VALUES
  ('c1000000-0000-0000-0000-000000000001', 'account_takeover', 1),
  ('c1000000-0000-0000-0000-000000000002', 'fake_online_store', 2),
  ('c1000000-0000-0000-0000-000000000003', 'bank_impersonation', 3),
  ('c1000000-0000-0000-0000-000000000004', 'fake_investment', 4),
  ('c1000000-0000-0000-0000-000000000005', 'internal_test', 99)
ON CONFLICT (id) DO UPDATE SET slug = EXCLUDED.slug, sort_order = EXCLUDED.sort_order;

INSERT INTO public.scenario_category_localizations (category_id, locale, name, description)
VALUES
  ('c1000000-0000-0000-0000-000000000001', 'km', 'ការបន្លំដណ្ដើមគណនី', 'ល្បិចក្លែងបន្លំដើម្បីលួចយកគណនីទំនាក់ទំនងសង្គម'),
  ('c1000000-0000-0000-0000-000000000001', 'en', 'Account Takeover', 'Impersonation tactics used to hijack social communication accounts'),
  ('c1000000-0000-0000-0000-000000000002', 'km', 'ហាងអនឡាញក្លែងក្លាយ', 'ការបោកប្រាស់តាមរយៈការលក់ទំនិញក្លែងក្លាយ'),
  ('c1000000-0000-0000-0000-000000000002', 'en', 'Fake Online Store', 'Scams involving counterfeit e-commerce listings and fraudulent sellers'),
  ('c1000000-0000-0000-0000-000000000003', 'km', 'ការក្លែងបន្លំធនាគារ', 'ល្បិចបន្លំជាបុគ្គលិកធនាគារឬស្ថាប័នហិរញ្ញវត្ថុ'),
  ('c1000000-0000-0000-0000-000000000003', 'en', 'Bank Impersonation', 'Scams impersonating banking or financial institution staff'),
  ('c1000000-0000-0000-0000-000000000004', 'km', 'ការវិនិយោគក្លែងក្លាយ', 'ការសន្យាផ្ដល់ប្រាក់ចំណេញខ្ពស់មិនពិតប្រាកដ'),
  ('c1000000-0000-0000-0000-000000000004', 'en', 'Fake Investment', 'Fraudulent schemes offering unrealistic investment returns'),
  ('c1000000-0000-0000-0000-000000000005', 'km', 'ការធ្វើតេស្តផ្ទៃក្នុង', 'ទិន្នន័យសម្រាប់ធ្វើតេស្តសុវត្ថិភាព'),
  ('c1000000-0000-0000-0000-000000000005', 'en', 'Internal Testing', 'Category used exclusively for security RLS denial tests')
ON CONFLICT (category_id, locale) DO UPDATE
SET name = EXCLUDED.name, description = EXCLUDED.description;

-- 2. Media Assets
INSERT INTO public.media_assets (id, storage_path, media_type, mime_type, size_bytes, license_status, review_status)
VALUES
  ('m1000000-0000-0000-0000-000000000001', 'covers/telegram_takeover.webp', 'image', 'image/webp', 102400, 'licensed_demo', 'approved'),
  ('m1000000-0000-0000-0000-000000000002', 'covers/fake_online_store.webp', 'image', 'image/webp', 102400, 'unreviewed_placeholder', 'approved'),
  ('m1000000-0000-0000-0000-000000000003', 'covers/bank_impersonation.webp', 'image', 'image/webp', 102400, 'unreviewed_placeholder', 'approved'),
  ('m1000000-0000-0000-0000-000000000004', 'covers/fake_investment.webp', 'image', 'image/webp', 102400, 'unreviewed_placeholder', 'approved'),
  ('m1000000-0000-0000-0000-000000000099', 'internal/unreviewed_evidence.webp', 'image', 'image/webp', 51200, 'unreviewed_placeholder', 'pending_review')
ON CONFLICT (id) DO UPDATE SET storage_path = EXCLUDED.storage_path, review_status = EXCLUDED.review_status;

INSERT INTO public.media_localizations (media_asset_id, locale, alt_text)
VALUES
  ('m1000000-0000-0000-0000-000000000001', 'km', 'រូបតំណាងសុវត្ថិភាពគណនី Telegram'),
  ('m1000000-0000-0000-0000-000000000001', 'en', 'Telegram account security illustration'),
  ('m1000000-0000-0000-0000-000000000002', 'km', 'រូបតំណាងហាងអនឡាញក្លែងក្លាយ'),
  ('m1000000-0000-0000-0000-000000000002', 'en', 'Fake online store illustration'),
  ('m1000000-0000-0000-0000-000000000003', 'km', 'រូបតំណាងការក្លែងបន្លំធនាគារ'),
  ('m1000000-0000-0000-0000-000000000003', 'en', 'Bank impersonation illustration'),
  ('m1000000-0000-0000-0000-000000000004', 'km', 'រូបតំណាងការវិនិយោគក្លែងក្លាយ'),
  ('m1000000-0000-0000-0000-000000000004', 'en', 'Fake investment illustration'),
  ('m1000000-0000-0000-0000-000000000099', 'km', 'ភស្តុតាងដែលមិនទាន់ត្រួតពិនិត្យ'),
  ('m1000000-0000-0000-0000-000000000099', 'en', 'Unreviewed evidence placeholder')
ON CONFLICT (media_asset_id, locale) DO UPDATE SET alt_text = EXCLUDED.alt_text;

-- 3. Scenarios (Master Metadata)
-- Scenario 1: Published Telegram Takeover
-- Scenario 2-4: Coming Soon sample scenarios for library cards
-- Scenario 5: Draft scenario (must be invisible to anon)
-- Scenario 6: Archived scenario (must be invisible to anon)
INSERT INTO public.scenarios (id, slug, category_id, cover_media_id, estimated_minutes, status, version, published_at)
VALUES
  ('s1000000-0000-0000-0000-000000000001', 'telegram-messenger-takeover', 'c1000000-0000-0000-0000-000000000001', 'm1000000-0000-0000-0000-000000000001', 6, 'published', 1, clock_timestamp()),
  ('s1000000-0000-0000-0000-000000000002', 'fake-online-store', 'c1000000-0000-0000-0000-000000000002', 'm1000000-0000-0000-0000-000000000002', 6, 'coming_soon', 1, NULL),
  ('s1000000-0000-0000-0000-000000000003', 'bank-impersonation', 'c1000000-0000-0000-0000-000000000003', 'm1000000-0000-0000-0000-000000000003', 5, 'coming_soon', 1, NULL),
  ('s1000000-0000-0000-0000-000000000004', 'fake-investment', 'c1000000-0000-0000-0000-000000000004', 'm1000000-0000-0000-0000-000000000004', 7, 'coming_soon', 1, NULL),
  ('s1000000-0000-0000-0000-000000000005', 'draft-phishing-test', 'c1000000-0000-0000-0000-000000000005', NULL, 5, 'draft', 1, NULL),
  ('s1000000-0000-0000-0000-000000000006', 'archived-old-case', 'c1000000-0000-0000-0000-000000000005', NULL, 5, 'archived', 1, clock_timestamp() - INTERVAL '30 days')
ON CONFLICT (id) DO UPDATE SET
  slug = EXCLUDED.slug,
  status = EXCLUDED.status,
  version = EXCLUDED.version,
  published_at = EXCLUDED.published_at;

-- 4. Scenario Localizations
INSERT INTO public.scenario_localizations (scenario_id, locale, title, summary, intro, closing_summary)
VALUES
  -- 1. Telegram Takeover (Published)
  ('s1000000-0000-0000-0000-000000000001', 'km',
   'ល្បិចបោកយកគណនី Telegram',
   'ស្វែងយល់ពីសារក្លែងបន្លំតាម Messenger ដែលព្យាយាមយកលេខកូដចូល Telegram។',
   'អ្នកទទួលបានសារពីគណនី Messenger មួយដែលមើលទៅដូចជាមិត្តភក្តិរបស់អ្នក។',
   'កុំចែករំលែកលេខកូដចូលគណនី។ ផ្ទៀងផ្ទាត់ការស្នើសុំតាមមធ្យោបាយទំនាក់ទំនងដែលអ្នកទុកចិត្ត។'),
  ('s1000000-0000-0000-0000-000000000001', 'en',
   'Telegram Account Takeover Trick',
   'Learn how Messenger impersonators try to steal Telegram login codes.',
   'You receive a Messenger message from an account that appears to belong to a friend.',
   'Never share account login codes. Verify unusual requests through a separate trusted channel.'),

  -- 2. Fake Online Store (Coming Soon)
  ('s1000000-0000-0000-0000-000000000002', 'km',
   'ល្បិចហាងអនឡាញក្លែងក្លាយ',
   'ការបោកប្រាស់តាមទំព័រលក់ទំនិញអនឡាញដែលមានតម្លៃទាបខុសពីធម្មតា។',
   'អ្នកឃើញការផ្សាយពាណិជ្ជកម្មទំនិញបញ្ចុះតម្លៃ ៨០% លើបណ្តាញសង្គម។',
   'ត្រួតពិនិត្យភាពស្របច្បាប់នៃអ្នកលក់មុនពេលផ្ទេរប្រាក់។'),
  ('s1000000-0000-0000-0000-000000000002', 'en',
   'Fake Online Shop',
   'Scams involving fake online storefronts offering unrealistically cheap items.',
   'You see an online advertisement offering an 80% discount on luxury electronics.',
   'Always verify vendor credibility and official registration before making payments.'),

  -- 3. Bank Impersonation (Coming Soon)
  ('s1000000-0000-0000-0000-000000000003', 'km',
   'ល្បិចក្លែងបន្លំធនាគារ',
   'ការទូរស័ព្ទឬផ្ញើសារបន្លំជាបុគ្គលិកធនាគារស្នើសុំព័ត៌មានសម្ងាត់។',
   'ជនបោកប្រាស់ទូរស័ព្ទមកអះអាងថាគណនីធនាគាររបស់អ្នកមានបញ្ហាសុវត្ថិភាព។',
   'ធនាគារពិតប្រាកដមិនដែលទូរស័ព្ទទារលេខសម្ងាត់ ឬ OTP ឡើយ។'),
  ('s1000000-0000-0000-0000-000000000003', 'en',
   'Bank Impersonation',
   'Fraudulent phone calls or SMS messages claiming to be bank staff asking for credentials.',
   'A caller claims to represent your bank and warns of an urgent security freeze.',
   'Legitimate banks will never phone you to request your password, PIN, or OTP.'),

  -- 4. Fake Investment (Coming Soon)
  ('s1000000-0000-0000-0000-000000000004', 'km',
   'ល្បិចវិនិយោគក្លែងក្លាយ',
   'ការបោកបញ្ឆោតឱ្យវិនិយោគដោយសន្យាផ្ដល់ប្រាក់ចំណេញខ្ពស់ក្នុងរយៈពេលខ្លី។',
   'ការអញ្ជើញចូលរួមក្នុងក្រុមតេឡេក្រាមវិនិយោគដែលមានការធានាប្រាក់ចំណេញ ១០០%។',
   'គ្មានការវិនិយោគស្របច្បាប់ណាដែលមានប្រាក់ចំណេញខ្ពស់ដោយគ្មានហានិភ័យនោះទេ។'),
  ('s1000000-0000-0000-0000-000000000004', 'en',
   'Fake Investment',
   'Fraudulent schemes promising guaranteed high returns in an impossibly short timeframe.',
   'You are invited to an exclusive investment chat channel promising 100% guaranteed daily returns.',
   'There are no legitimate high-return investments with zero risk.'),

  -- 5. Draft Phishing Test (Draft - Internal)
  ('s1000000-0000-0000-0000-000000000005', 'km',
   'សេណារីយ៉ូព្រាងសាកល្បង',
   'ខ្លឹមសារព្រាងមិនទាន់អនុម័ត មិនត្រូវបង្ហាញដល់សាធារណជនឡើយ។',
   'ការផ្ទៀងផ្ទាត់តេស្ត RLS ផ្ទៃក្នុង។',
   'បញ្ចប់ការធ្វើតេស្ត។'),
  ('s1000000-0000-0000-0000-000000000005', 'en',
   'Draft Test Scenario',
   'Unapproved draft content that must remain completely invisible to anonymous clients.',
   'Internal RLS security test scenario.',
   'End of internal draft test.'),

  -- 6. Archived Old Case (Archived - Internal)
  ('s1000000-0000-0000-0000-000000000006', 'km',
   'សេណារីយ៉ូប័ណ្ណសារចាស់',
   'សេណារីយ៉ូដែលត្រូវបានដកចេញពីការបោះពុម្ព។',
   'ខ្លឹមសារប័ណ្ណសារចាស់។',
   'បញ្ចប់។'),
  ('s1000000-0000-0000-0000-000000000006', 'en',
   'Archived Old Case',
   'Scenario that has been withdrawn from publication and must not be returned to clients.',
   'Archived content.',
   'End.')
ON CONFLICT (scenario_id, locale) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  intro = EXCLUDED.intro,
  closing_summary = EXCLUDED.closing_summary;

-- 5. Scenario Steps (For published Telegram takeover)
INSERT INTO public.scenario_steps (id, scenario_id, step_key, kind, order_index)
VALUES
  ('st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000001', 'story-01', 'story', 1),
  ('st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000001', 'decision-01', 'decision', 2),
  ('st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000001', 'story-02', 'story', 3),
  ('st000000-0000-0000-0000-000000000004', 's1000000-0000-0000-0000-000000000001', 'decision-02', 'decision', 4),
  -- Step in Draft scenario (for child denial test)
  ('st000000-0000-0000-0000-000000000099', 's1000000-0000-0000-0000-000000000005', 'draft-step-01', 'story', 1)
ON CONFLICT (id) DO UPDATE SET step_key = EXCLUDED.step_key, kind = EXCLUDED.kind, order_index = EXCLUDED.order_index;

-- 6. Step Localizations
INSERT INTO public.step_localizations (step_id, locale, body_text)
VALUES
  ('st000000-0000-0000-0000-000000000001', 'km', 'សារ​មួយនិយាយថា៖ «ខ្ញុំមានបញ្ហាបន្ទាន់ សូមជួយខ្ញុំបន្តិច!»'),
  ('st000000-0000-0000-0000-000000000001', 'en', 'A message says: “I have an urgent problem. Can you help me?”'),
  ('st000000-0000-0000-0000-000000000002', 'km', 'មនុស្សនោះសុំលេខកូដចូល Telegram ដែលអ្នកទើបតែទទួល។ តើអ្នកគួរធ្វើអ្វី?'),
  ('st000000-0000-0000-0000-000000000002', 'en', 'The sender asks for the Telegram login code you just received. What should you do?'),
  ('st000000-0000-0000-0000-000000000003', 'km', 'អ្នកផ្ញើសារបន្តថា៖ «សូមផ្ញើឱ្យលឿន! បើមិនដូច្នោះទេ ខ្ញុំនឹងមានបញ្ហាធំ!»'),
  ('st000000-0000-0000-0000-000000000003', 'en', 'The sender adds: “Please hurry! I will be in serious trouble if you delay!”'),
  ('st000000-0000-0000-0000-000000000004', 'km', 'អ្នកផ្ញើបន្តដាក់សម្ពាធ។ តើអ្នកគួរធ្វើអ្វីបន្ទាប់?'),
  ('st000000-0000-0000-0000-000000000004', 'en', 'The sender keeps pressuring you. What should you do next?'),
  -- Draft step localization
  ('st000000-0000-0000-0000-000000000099', 'km', 'សារព្រាងសម្ងាត់'),
  ('st000000-0000-0000-0000-000000000099', 'en', 'Secret draft step text')
ON CONFLICT (step_id, locale) DO UPDATE SET body_text = EXCLUDED.body_text;

-- 7. Answer Options (For decision steps)
INSERT INTO public.answer_options (id, step_id, option_key, order_index, score_value, safety_category)
VALUES
  -- Decision 1 Options
  ('op000000-0000-0000-0000-000000000001', 'st000000-0000-0000-0000-000000000002', 'share', 1, 0, 'unsafe'),
  ('op000000-0000-0000-0000-000000000002', 'st000000-0000-0000-0000-000000000002', 'verify', 2, 1, 'safe'),
  ('op000000-0000-0000-0000-000000000003', 'st000000-0000-0000-0000-000000000002', 'ignore', 3, 1, 'safe'),
  -- Decision 2 Options
  ('op000000-0000-0000-0000-000000000004', 'st000000-0000-0000-0000-000000000004', 'rush', 1, 0, 'unsafe'),
  ('op000000-0000-0000-0000-000000000005', 'st000000-0000-0000-0000-000000000004', 'check', 2, 1, 'safe'),
  ('op000000-0000-0000-0000-000000000006', 'st000000-0000-0000-0000-000000000004', 'link', 3, 0, 'unsafe'),
  -- Draft Option
  ('op000000-0000-0000-0000-000000000099', 'st000000-0000-0000-0000-000000000099', 'draft-opt', 1, 0, 'unsafe')
ON CONFLICT (id) DO UPDATE SET
  option_key = EXCLUDED.option_key,
  order_index = EXCLUDED.order_index,
  score_value = EXCLUDED.score_value,
  safety_category = EXCLUDED.safety_category;

-- 8. Answer Localizations
INSERT INTO public.answer_localizations (option_id, locale, label, feedback_text)
VALUES
  -- Decision 1 Option 1 (share)
  ('op000000-0000-0000-0000-000000000001', 'km',
   'ផ្ញើលេខកូដឱ្យគាត់',
   'នេះមានហានិភ័យខ្ពស់។ ការចែករំលែកលេខកូដអាចឱ្យអ្នកផ្សេងចូលគណនីរបស់អ្នកបាន។'),
  ('op000000-0000-0000-0000-000000000001', 'en',
   'Send them the code',
   'High risk. Sharing a login code can let someone else access your account.'),

  -- Decision 1 Option 2 (verify)
  ('op000000-0000-0000-0000-000000000002', 'km',
   'ទាក់ទងមិត្តភក្តិតាមមធ្យោបាយផ្សេងដែលទុកចិត្តបាន',
   'ជាជម្រើសមានសុវត្ថិភាពជាង។ កុំផ្ញើលេខកូដ ទោះបីមើលទៅជាមិត្តភក្តិក៏ដោយ។'),
  ('op000000-0000-0000-0000-000000000002', 'en',
   'Verify with your friend using a separate trusted channel',
   'A safer choice. Never share the code, even if the message looks like it came from a friend.'),

  -- Decision 1 Option 3 (ignore)
  ('op000000-0000-0000-0000-000000000003', 'km',
   'មិនផ្ញើលេខកូដ ហើយបិទការសន្ទនា',
   'ការមិនផ្ញើលេខកូដជួយការពារគណនី។ ការផ្ទៀងផ្ទាត់តាមផ្លូវផ្សេងក៏អាចជួយបញ្ជាក់ថាមិត្តភក្តិត្រូវបានក្លែងបន្លំឬអត់។'),
  ('op000000-0000-0000-0000-000000000003', 'en',
   'Do not send the code and close the conversation',
   'Not sharing the code protects your account. Independent verification can also reveal impersonation.'),

  -- Decision 2 Option 1 (rush)
  ('op000000-0000-0000-0000-000000000004', 'km',
   'ផ្ញើលេខកូដព្រោះគាត់ថាបន្ទាន់',
   'ការបង្កើតភាពបន្ទាន់គឺជាល្បិចទូទៅ។ កុំបង្ហាញលេខកូដចូលគណនី។'),
  ('op000000-0000-0000-0000-000000000004', 'en',
   'Share the code because it is urgent',
   'Urgency is a common manipulation tactic. Do not reveal login codes.'),

  -- Decision 2 Option 2 (check)
  ('op000000-0000-0000-0000-000000000005', 'km',
   'ឈប់ឆ្លើយ ហើយផ្ទៀងផ្ទាត់អត្តសញ្ញាណអ្នកផ្ញើ',
   'ល្អ! ការផ្ទៀងផ្ទាត់ដោយឡែក និងការមិនចែករំលែកលេខកូដជាការឆ្លើយតបមានសុវត្ថិភាព។'),
  ('op000000-0000-0000-0000-000000000005', 'en',
   'Pause and verify the sender independently',
   'Good! Independent verification without sharing the code is a safer response.'),

  -- Decision 2 Option 3 (link)
  ('op000000-0000-0000-0000-000000000006', 'km',
   'ចុចតំណភ្ជាប់ដែលគាត់ផ្ញើ ដើម្បីពិនិត្យ',
   'តំណដែលអ្នកមិនទុកចិត្តអាចនាំទៅកាន់ទំព័រក្លែងក្លាយ។ ប្រើកម្មវិធីផ្លូវការ និងឆានែលផ្ទៀងផ្ទាត់ដែលទុកចិត្ត។'),
  ('op000000-0000-0000-0000-000000000006', 'en',
   'Open the link they sent to check',
   'Untrusted links can lead to phishing pages. Use official apps and trusted verification channels.'),

  -- Draft Option Localization
  ('op000000-0000-0000-0000-000000000099', 'km',
   'ជម្រើសព្រាង',
   'មតិកែលម្អព្រាងសម្ងាត់។'),
  ('op000000-0000-0000-0000-000000000099', 'en',
   'Draft Option',
   'Secret draft feedback.')
ON CONFLICT (option_id, locale) DO UPDATE SET
  label = EXCLUDED.label,
  feedback_text = EXCLUDED.feedback_text;

-- 9. Initial Version Archive for Published Scenario
INSERT INTO public.scenario_versions (scenario_id, version, snapshot_payload, published_at)
VALUES
  ('s1000000-0000-0000-0000-000000000001', 1, jsonb_build_object(
    'id', 'telegram-messenger-takeover',
    'version', 1,
    'status', 'published',
    'category', 'account_takeover',
    'estimated_minutes', 6,
    'steps_count', 4
  ), clock_timestamp())
ON CONFLICT (scenario_id, version) DO NOTHING;
