# Content workflow — stories, illustrations, audio, video, news, law, contacts

## Editorial ownership
For each item record: `content_id`, `content_version`, source/license, Khmer author/reviewer, English reviewer, subject-matter reviewer, approver, reviewed_at, publication status. **Do not self-approve AI-generated guidance**.

## Scenario steps
1. Write fiction inspired by typical tactics; do not reproduce restricted police case data or identifiable victims without explicit authorization.
2. Khmer story written/checked by Cambodian native-language reviewer; English translated and checked for meaning parity.
3. An expert validates each decision, explanation and recovery recommendation against official Telegram/Meta guidance where applicable.
4. Illustrations are original/rights-cleared, with alt text and no actual victim screenshots. Provide fallback placeholder in demo.
5. Audio: choose human narration or validated Khmer/English TTS; store rights, narrator consent, voice/version, transcript. Pre-render where possible. Play only after user gesture; text always available.
6. Confirm audio/text correspondence, file sizes, accessibility and correct language selection before publishing.
7. Record version, reviewer, testing date. Any significant change increments version so local attempts remain attributable.

## Scenario library / media
- Cards: cover, bilingual title, category, duration, level/status, progress when available.
- One playable Telegram/Facebook story; sample shopping/banking/investment cards must read **Coming Soon** and be nonfunctional.
- Asset names: `scenarios/<id>/v<version>/<locale>/<asset>`. Don't embed base64 assets into the database.

## Educational video demo
- Show a *clearly labeled demo* thumbnail/card before real video exists. If producing a demo clip, use original/authorized material (e.g., a short self-produced verification-code lesson), consent, caption/subtitle tracks, and validated playback on devices.
- Avoid downloading copyrighted news clips or screenshots without rights.

## News demo and later automation
- Initial fixture is marked `DEMO — fictional sample, not real news`; do not label it 'latest' or assign a fabricated publication date.
- Later authorized sources: RSS/API/manual URL, license compliance, deduplication, timestamp/provenance, AI summary/translation, editorial approval, then publish. Retract/correct workflows and image rights checks.

## Emergency/contact/law
- Contacts have exact source, last verified, locale, jurisdiction, correct reporting category, assigned reviewer; never fabricate phone numbers.
- Emergency guidance reviewed for consequences and urgency; not an official police report submission.
- Law files track official provenance, version/effective date and reviewer; educational explanations are not legal advice or official certification.
