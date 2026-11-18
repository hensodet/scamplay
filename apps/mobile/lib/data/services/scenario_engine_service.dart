import '../models/gameplay_models.dart';
import '../models/scenario_models.dart';
import '../repositories/content_repository.dart';

class ScenarioEngineService {
  final ContentRepository repository;

  ScenarioEngineService({required this.repository});

  /// Builds the 4-stage interactive branching storyline for Telegram Account Takeover
  List<GameplayStep> getTelegramTakeoverStory({required bool isKhmer}) {
    final senderName = isKhmer ? 'សុភាព (មិត្តភក្តិ)' : 'Sopheap (Friend)';
    final now = DateTime.now();

    return [
      // -------------------------------------------------------------
      // STAGE 1: Suspicious Contact
      // -------------------------------------------------------------
      GameplayStep(
        stepKey: 'stage_1_contact',
        stage: 1,
        stageTitle: isKhmer
            ? 'ដំណាក់កាលទី ១៖ ទំនាក់ទំនងគួរឱ្យសង្ស័យ'
            : 'Stage 1: Suspicious Contact',
        messages: [
          ChatMessage(
            id: 'msg_1_1',
            senderName: senderName,
            isUser: false,
            text: isKhmer
                ? 'សួស្តី! សុខសប្បាយទេ? ខ្ញុំកំពុងជួបបញ្ហាបន្ទាន់ខ្លាំងណាស់ ទូរស័ព្ទរបស់ខ្ញុំទើបតែខូច មិនអាចបើកកម្មវិធី Telegram បានទេ។ ខ្ញុំខ្ចីទូរស័ព្ទគេឆាតមកអ្នក។ តើអ្នកអាចជួយខ្ញុំបន្តិចបានទេ?'
                : 'Hi! How are you? I have an urgent issue, my phone broke and I cannot access Telegram. I borrowed someone else’s phone to message you. Could you help me for a moment?',
            timestamp: now.subtract(const Duration(minutes: 4)),
          ),
        ],
        educationalTakeaway: isKhmer
            ? 'ជនបោកប្រាស់តែងតែបន្លំខ្លួនជាមិត្តភក្តិ ឬអ្នកស្គាល់គ្នា ដើម្បីបង្កើតទំនុកចិត្តដំបូង។'
            : 'Scammers frequently impersonate friends or acquaintances to establish false trust.',
        options: [
          GameplayDecisionOption(
            id: 'opt_1_verify',
            optionKey: 'verify_call',
            orderIndex: 1,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់តាមលេខទូរស័ព្ទដែលធ្លាប់ស្គាល់'
                : 'Call them directly using their known phone number',
            feedbackText: isKhmer
                ? 'ល្អណាស់! នេះជាមធ្យោបាយផ្ទៀងផ្ទាត់ដោយផ្ទាល់ (Out-of-band Verification) ដ៏មានសុវត្ថិភាពបំផុត ដើម្បីដឹងថាគណនីមិត្តភក្តិពិតជាត្រូវបានគេលួចឬអត់។'
                : 'Excellent! Direct out-of-band phone verification is the safest method to confirm if a friend’s account was compromised.',
            nextStepKey: 'stage_2_urgency',
            simulatedReaction: isKhmer
                ? '«ខ្ញុំកំពុងជាប់រវល់ មិនអាចលើកទូរស័ព្ទបានទេ! ជួយឆាតតាមនេះវិញមក!»'
                : '“I am too busy and cannot pick up! Please chat here instead!”',
          ),
          GameplayDecisionOption(
            id: 'opt_1_question',
            optionKey: 'question_identity',
            orderIndex: 2,
            scoreValue: 50,
            safetyCategory: GameplaySafetyCategory.caution,
            label: isKhmer
                ? 'សួរពីព័ត៌មានផ្ទាល់ខ្លួនដែលដឹងតែពីរនាក់ ដើម្បីបញ្ជាក់អត្តសញ្ញាណ'
                : 'Ask personal questions only the real friend would know',
            feedbackText: isKhmer
                ? 'ជាវិធីសាស្ត្រល្អគួរសម ប៉ុន្តែជនបោកប្រាស់អាចមានព័ត៌មានពីប្រវត្តិរូបបណ្តាញសង្គមចាស់ៗ។ ការទូរស័ព្ទផ្ទាល់នៅតែមានសុវត្ថិភាពខ្ពស់ជាង។'
                : 'A fair precaution, but scammers might gather personal data from old social posts. A direct voice call is much safer.',
            nextStepKey: 'stage_2_urgency',
            simulatedReaction: isKhmer
                ? '«កុំទាន់អាលសួរច្រើនអី ពេលនេះម៉ាក់ខ្ញុំកំពុងមានអាសន្ន!»'
                : '“Don’t ask so many questions right now, my mother is in an emergency!”',
          ),
          GameplayDecisionOption(
            id: 'opt_1_trust',
            optionKey: 'immediate_trust',
            orderIndex: 3,
            scoreValue: 0,
            safetyCategory: GameplaySafetyCategory.unsafe,
            label: isKhmer
                ? 'ឆ្លើយតបភ្លាមៗថា៖ «បាន! តើមានការអ្វីឱ្យខ្ញុំជួយដែរ?»'
                : 'Immediately reply: “Sure! What do you need me to do?”',
            feedbackText: isKhmer
                ? 'គ្រោះថ្នាក់! ការជឿជាក់លើសារដោយមិនបានផ្ទៀងផ្ទាត់ អាចធ្វើឱ្យអ្នកធ្លាក់ចូលក្នុងអន្ទាក់វិស្វកម្មសង្គម (Social Engineering) យ៉ាងងាយស្រួល។'
                : 'Dangerous! Trusting requests without verification makes you vulnerable to social engineering tricks.',
            nextStepKey: 'stage_2_urgency',
            simulatedReaction: isKhmer
                ? '«អរគុណច្រើន! គឺម៉ាក់របស់ខ្ញុំកំពុងឈឺនៅពេទ្យបន្ទាន់!»'
                : '“Thank you so much! My mother was just rushed to the hospital!”',
          ),
        ],
      ),

      // -------------------------------------------------------------
      // STAGE 2: Urgency & Emotional Pressure
      // -------------------------------------------------------------
      GameplayStep(
        stepKey: 'stage_2_urgency',
        stage: 2,
        stageTitle: isKhmer
            ? 'ដំណាក់កាលទី ២៖ សម្ពាធបន្ទាន់ និងការលួងលោម'
            : 'Stage 2: Urgency & Pressure',
        messages: [
          ChatMessage(
            id: 'msg_2_1',
            senderName: senderName,
            isUser: false,
            text: isKhmer
                ? 'ម៉ាក់ខ្ញុំកំពុងឈឺនៅមន្ទីរពេទ្យ ឯកសារពេទ្យនិងលុយទាំងអស់នៅក្នុង Telegram របស់ខ្ញុំ! Telegram ស្នើសុំលេខទូរស័ព្ទអ្នកជិតស្និទ្ធដើម្បីផ្ញើលេខកូដជំនួយ។ ខ្ញុំបានដាក់លេខទូរស័ព្ទរបស់អ្នកហើយ ជួយមើលសារបន្តិច!'
                : 'My mother is in the hospital and all medical documents are stored in my Telegram! Telegram is asking for a trusted contact’s phone to send an emergency recovery code. I entered your phone number, please check your SMS now!',
            timestamp: now.subtract(const Duration(minutes: 2)),
          ),
        ],
        educationalTakeaway: isKhmer
            ? 'សម្ពាធបន្ទាន់ (Emotional Urgency) គឺជាល្បិចចម្បងដែលចោរប្រើ ដើម្បីបង្ខំឱ្យជនរងគ្រោះធ្វើសកម្មភាពទាំងភ័យស្លន់ស្លោ។'
            : 'Emotional urgency is the primary weapon used to force victims to react in panic without thinking.',
        options: [
          GameplayDecisionOption(
            id: 'opt_2_refuse_policy',
            optionKey: 'refuse_policy',
            orderIndex: 1,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'បដិសេធ និងពន្យល់ថា Telegram មិនដែលមានប្រព័ន្ធផ្ញើកូដឱ្យអ្នកដទៃបែបនេះឡើយ'
                : 'Refuse, noting that Telegram never sends account codes to third parties',
            feedbackText: isKhmer
                ? 'ត្រឹមត្រូវណាស់! Telegram មិនដែលមានគោលការណ៍ផ្ញើលេខកូដ Login របស់មនុស្សម្នាក់ទៅទូរស័ព្ទអ្នកផ្សេងឡើយ។ នេះជាសញ្ញាក្លែងបន្លំច្បាស់ក្រឡែត។'
                : 'Correct! Telegram never sends account login codes to a third party’s phone number. This is an unmistakable scam indicator.',
            nextStepKey: 'stage_3_code_request',
            simulatedReaction: isKhmer
                ? '«ខ្ញុំមិនកុហកទេ កូដនោះទើបតែលោតទៅលេខរបស់អ្នកហើយ សូមជួយមើលបន្តិច!»'
                : '“I am not lying, the code was just sent to your phone, please check!”',
          ),
          GameplayDecisionOption(
            id: 'opt_2_family_check',
            optionKey: 'family_check',
            orderIndex: 2,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'ផ្អាកការសន្ទនា ហើយទាក់ទងសមាជិកគ្រួសារគាត់ដើម្បីផ្ទៀងផ្ទាត់ដំណឹង'
                : 'Pause and contact their family members to verify the hospital emergency',
            feedbackText: isKhmer
                ? 'ឆ្លាតវៃណាស់! ការផ្ទៀងផ្ទាត់ដំណឹងជាមួយគ្រួសារផ្ទាល់ ជួយឱ្យអ្នកដឹងការពិត និងមិនធ្លាក់ក្នុងអន្ទាក់បោកប្រាស់។'
                : 'Smart move! Checking directly with family exposes false emergencies and stops the scam.',
            nextStepKey: 'stage_3_code_request',
            simulatedReaction: isKhmer
                ? '«កុំទាន់ទាក់ទងគេអី ផ្ញើកូដឱ្យខ្ញុំសិនមក ទើបដោះស្រាយទាន់!»'
                : '“Don’t call anyone yet, just send the code first so I can solve this!”',
          ),
          GameplayDecisionOption(
            id: 'opt_2_panic_check',
            optionKey: 'panic_check',
            orderIndex: 3,
            scoreValue: 0,
            safetyCategory: GameplaySafetyCategory.unsafe,
            label: isKhmer
                ? 'បើកមើលប្រអប់សារ SMS ភ្លាមៗព្រោះបារម្ភពីស្ថានភាពជំងឺ'
                : 'Immediately check SMS inbox out of worry for the family crisis',
            feedbackText: isKhmer
                ? 'ប្រុងប្រយ័ត្ន! សម្ពាធបន្ទាន់គឺជាអាវុធផ្លូវចិត្តដ៏ចម្បងរបស់ជនបោកប្រាស់។ កុំអនុញ្ញាតឱ្យការភ័យខ្លាចបិទបាំងការគិតបែបសុវត្ថិភាព។'
                : 'Be careful! Panicking under pressure leads directly into the scammer’s trap.',
            nextStepKey: 'stage_3_code_request',
            simulatedReaction: isKhmer
                ? '«ឃើញកូដហើយមែនទេ? ផ្ញើឱ្យខ្ញុំលឿនឡើង!»'
                : '“You see the code now right? Send it to me quickly!”',
          ),
        ],
      ),

      // -------------------------------------------------------------
      // STAGE 3: Verification Code Request (The Critical Attack)
      // -------------------------------------------------------------
      GameplayStep(
        stepKey: 'stage_3_code_request',
        stage: 3,
        stageTitle: isKhmer
            ? 'ដំណាក់កាលទី ៣៖ ការស្នើសុំលេខកូដផ្ទៀងផ្ទាត់'
            : 'Stage 3: Verification Code Request',
        messages: [
          ChatMessage(
            id: 'msg_3_sms',
            senderName: isKhmer ? 'ប្រព័ន្ធសារ SMS' : 'SMS System',
            isUser: false,
            isSystem: true,
            isCodeAlert: true,
            text: isKhmer
                ? '📩 [SMS ផ្លូវការពី Telegram]\nលេខកូដចូលគណនីរបស់អ្នកគឺ៖ 84920។\nហាមចែករំលែកលេខកូដនេះឱ្យអ្នកណាដាច់ខាត (Do not give this code to anyone)។'
                : '📩 [Official Telegram SMS]\nYour login code: 84920.\nDo not give this code to anyone, even if they claim to be Telegram.',
            timestamp: now.subtract(const Duration(seconds: 40)),
          ),
          ChatMessage(
            id: 'msg_3_scammer',
            senderName: senderName,
            isUser: false,
            text: isKhmer
                ? 'កូដ ៥ ខ្ទង់ទើបតែលោតទៅលេខរបស់អ្នកមែនទេ? ផ្ញើឱ្យខ្ញុំលឿនមក ពេទ្យកំពុងទារឯកសារបន្ទាន់!'
                : 'Did the 5-digit code just arrive on your phone? Send it to me quickly, the hospital needs the files immediately!',
            timestamp: now.subtract(const Duration(seconds: 20)),
          ),
        ],
        educationalTakeaway: isKhmer
            ? 'លេខកូដ OTP ឬ Login Code គឺជាសោរចូលគ្រប់គ្រងគណនីរបស់អ្នក។ អ្នកដែលសុំលេខកូដនេះ គឺជាអ្នកដែលកំពុងព្យាយាមលួចគណនីរបស់អ្នក។'
            : 'Login OTP codes grant complete control over your account. Anyone asking for your code is attempting to steal your account.',
        options: [
          GameplayDecisionOption(
            id: 'opt_3_refuse_code',
            optionKey: 'refuse_code',
            orderIndex: 1,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'ដាច់ខាតមិនចែករំលែកលេខកូដ ហើយអានការព្រមានក្នុងសារ Telegram ថា "Do not give this code to anyone"'
                : 'Never share the code, noting Telegram’s explicit warning “Do not give this code to anyone”',
            feedbackText: isKhmer
                ? 'ពូកែណាស់! លេខកូដ Login ឬ OTP គឺជាកូនសោចូលគ្រប់គ្រងគណនីរបស់អ្នក។ នៅពេលអ្នកបដិសេធមិនផ្ញើ អ្នកបានការពារគណនីរបស់អ្នកពីការលួចយកបានជោគជ័យ!'
                : 'Brilliant! Login codes grant complete control over your account. By refusing, you successfully defended your account!',
            nextStepKey: 'stage_4_recovery_safe',
            simulatedReaction: isKhmer
                ? '«ហេតុអ្វីមិនជួយខ្ញុំ? ខ្ញុំជាមិត្តភក្តិអ្នកតើ!» (ជនបោកប្រាស់បិទការសន្ទនា)'
                : '“Why won’t you help me? I thought we were friends!” (Scammer disconnects)',
          ),
          GameplayDecisionOption(
            id: 'opt_3_share_code',
            optionKey: 'share_code',
            orderIndex: 2,
            scoreValue: 0,
            safetyCategory: GameplaySafetyCategory.unsafe,
            label: isKhmer
                ? 'ថតរូបអេក្រង់ (Screenshot) ឬចម្លងលេខកូដ 84920 ផ្ញើទៅឱ្យគាត់ព្រោះអាណិត'
                : 'Screenshot or copy code 84920 and send it to them out of sympathy',
            feedbackText: isKhmer
                ? 'គ្រោះថ្នាក់ធ្ងន់ធ្ងរ! ការចែករំលែកលេខកូដ OTP ស្មើនឹងការប្រគល់គណនីរបស់អ្នកទៅឱ្យចោរ។ ជនបោកប្រាស់នឹងបណ្តេញ (Terminate) ឧបករណ៍របស់អ្នកចេញ ហើយប្រើគណនីអ្នកទៅបោកប្រាស់អ្នកដទៃបន្ត!'
                : 'Critical Danger! Sharing your OTP code handed over your account. The attacker can now log in, kick out your session, and impersonate you!',
            nextStepKey: 'stage_4_recovery_breach',
            simulatedReaction: isKhmer
                ? '⚠️ [ការជូនដំណឹងសុវត្ថិភាព]\nគណនី Telegram របស់អ្នកទើបតែត្រូវបាន Login ពីឧបករណ៍ថ្មីក្នុងប្រទេសរុស្ស៊ី ឬបរទេស!'
                : '⚠️ [Security Alert]\nYour Telegram account was just accessed from a new unfamiliar device abroad!',
          ),
          GameplayDecisionOption(
            id: 'opt_3_hesitate',
            optionKey: 'hesitate_warn',
            orderIndex: 3,
            scoreValue: 50,
            safetyCategory: GameplaySafetyCategory.caution,
            label: isKhmer
                ? 'សួរគាត់ថា៖ «ហេតុអ្វីបានជាសារនោះសរសេរថាហាមចែករំលែកឱ្យអ្នកដទៃ?»'
                : 'Ask: “Why does the SMS explicitly state never share this code with anyone?”',
            feedbackText: isKhmer
                ? 'ការសង្ស័យគឺជាជំហានល្អ ប៉ុន្តែជនបោកប្រាស់នឹងត្រៀមលេសបញ្ចុះបញ្ចូលភ្លាមៗ។ វិធានការសុវត្ថិភាពពិតប្រាកដគឺមិនចែករំលែកជាដាច់ខាត។'
                : 'Skepticism is good, but scammers prepare ready-made excuses. Absolute refusal to share is the only safe rule.',
            nextStepKey: 'stage_4_recovery_safe',
            simulatedReaction: isKhmer
                ? '«នោះជាសារស្វ័យប្រវត្តិធម្មតាទេ មិនអីទេ ផ្ញើមក!»'
                : '“That is just an automated generic text, don’t worry, send it!”',
          ),
        ],
      ),

      // -------------------------------------------------------------
      // STAGE 4A: Safe Response & Long-Term Account Protection
      // -------------------------------------------------------------
      GameplayStep(
        stepKey: 'stage_4_recovery_safe',
        stage: 4,
        stageTitle: isKhmer
            ? 'ដំណាក់កាលទី ៤៖ ការឆ្លើយតប និងការពង្រឹងសុវត្ថិភាព'
            : 'Stage 4: Safe Response & Protection',
        messages: [
          ChatMessage(
            id: 'msg_4_safe_status',
            senderName: isKhmer ? 'ប្រព័ន្ធសុវត្ថិភាព ScamPlay' : 'ScamPlay Safety Monitor',
            isUser: false,
            isSystem: true,
            text: isKhmer
                ? '🛡️ [ការវាយតម្លៃសុវត្ថិភាព]\nអ្នកបានការពារលេខកូដសម្ងាត់បានជោគជ័យ! ជនបោកប្រាស់បានឈប់ឆ្លើយតប។ ឥឡូវនេះ តើអ្នកគួរចាត់វិធានការអ្វីបន្តទៀត?'
                : '🛡️ [Safety Assessment]\nYou successfully protected your code! The scammer has ceased messaging. What proactive steps should you take next?',
            timestamp: now,
          ),
        ],
        educationalTakeaway: isKhmer
            ? 'ការបើក Two-Step Verification (ពាក្យសម្ងាត់ ២ ជាន់) គឺជាខែលការពារដ៏រឹងមាំបំផុតប្រឆាំងនឹងការលួចគណនី Telegram។'
            : 'Enabling Two-Step Verification is the strongest defense against Telegram account takeover.',
        options: [
          GameplayDecisionOption(
            id: 'opt_4_enable_2fa',
            optionKey: 'enable_2fa_alert',
            orderIndex: 1,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'បើក Two-Step Verification (ពាក្យសម្ងាត់ ២ ជាន់) ក្នុង Telegram និងប្រាប់មិត្តភក្តិដទៃទៀតឱ្យប្រយ័ត្ន'
                : 'Enable Two-Step Verification in Telegram and alert mutual friends',
            feedbackText: isKhmer
                ? 'ល្អឥតខ្ចោះ! នៅពេលបើក Two-Step Verification ទោះបីជាជនខិលខូចលួចបានកូដ SMS ក៏មិនអាចចូលគណនីអ្នកបានឡើយ បើគ្មានពាក្យសម្ងាត់ទីពីរ។'
                : 'Perfect! With Two-Step Verification enabled, an attacker cannot access your account even if they somehow intercept your SMS code.',
            nextStepKey: null, // Terminal step -> results
          ),
          GameplayDecisionOption(
            id: 'opt_4_block_report',
            optionKey: 'block_report',
            orderIndex: 2,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'រាយការណ៍ (Report) និងប្លុក (Block) គណនី Messenger ដែលត្រូវបានគេលួចនោះ'
                : 'Report and block the compromised Messenger account immediately',
            feedbackText: isKhmer
                ? 'ត្រឹមត្រូវណាស់! ការរាយការណ៍ជួយការពារអ្នកដទៃពីការចាញ់បោកគណនីដែលត្រូវគេលួចនោះបន្តទៀត។'
                : 'Correct! Reporting helps protect other contacts from falling victim to the compromised account.',
            nextStepKey: null,
          ),
        ],
      ),

      // -------------------------------------------------------------
      // STAGE 4B: Compromise Recovery (Incident Response)
      // -------------------------------------------------------------
      GameplayStep(
        stepKey: 'stage_4_recovery_breach',
        stage: 4,
        stageTitle: isKhmer
            ? 'ដំណាក់កាលទី ៤៖ ការសង្គ្រោះគណនីបន្ទាន់'
            : 'Stage 4: Emergency Account Recovery',
        messages: [
          ChatMessage(
            id: 'msg_4_breach_alert',
            senderName: isKhmer ? 'ការជូនដំណឹង Telegram' : 'Telegram System Alert',
            isUser: false,
            isSystem: true,
            isCodeAlert: true,
            text: isKhmer
                ? '🚨 [អាសន្នសុវត្ថិភាព]\nគណនីរបស់អ្នកទើបតែត្រូវបាន Login ពីឧបករណ៍ចម្លែកមួយ។ ជនបោកប្រាស់កំពុងស្ថិតក្នុងគណនីរបស់អ្នក! តើអ្នកត្រូវធ្វើអ្វីជាបន្ទាន់បំផុត?'
                : '🚨 [Security Emergency]\nYour account was accessed from an unrecognized device. The attacker is inside your account! What is your immediate action?',
            timestamp: now,
          ),
        ],
        educationalTakeaway: isKhmer
            ? 'ប្រសិនបើអ្នកច្រឡំចែករំលែកកូដ ត្រូវចូលទៅកាន់ Settings > Devices > Terminate All Other Sessions ភ្លាមៗដើម្បីបណ្តេញចោរចេញ។'
            : 'If an OTP was accidentally shared, immediately navigate to Settings > Devices > Terminate All Other Sessions to kick out the attacker.',
        options: [
          GameplayDecisionOption(
            id: 'opt_4_terminate_sessions',
            optionKey: 'terminate_sessions',
            orderIndex: 1,
            scoreValue: 100,
            safetyCategory: GameplaySafetyCategory.safe,
            label: isKhmer
                ? 'ចូល Settings > Devices > ចុច Terminate All Other Sessions ជាបន្ទាន់ និងបើក 2FA'
                : 'Go to Settings > Devices > Tap Terminate All Other Sessions immediately and enable 2FA',
            feedbackText: isKhmer
                ? 'ឆ្លើយតបបន្ទាន់បានល្អណាស់! សកម្មភាពនេះនឹងបណ្តេញជនបោកប្រាស់ចេញពីគណនីរបស់អ្នកភ្លាមៗ មុនពេលពួកគេអាចកាត់ផ្តាច់អ្នកបាន។'
                : 'Outstanding emergency response! This revokes the attacker’s access immediately before they can lock you out.',
            nextStepKey: null,
          ),
          GameplayDecisionOption(
            id: 'opt_4_wait_and_see',
            optionKey: 'wait_and_see',
            orderIndex: 2,
            scoreValue: 0,
            safetyCategory: GameplaySafetyCategory.unsafe,
            label: isKhmer
                ? 'រង់ចាំមើលបន្តិចសិន ក្រែងលោគាត់ប្រើរួចហើយប្រគល់គណនីមកវិញ'
                : 'Wait and see, hoping they finish and return the account',
            feedbackText: isKhmer
                ? 'គ្រោះថ្នាក់ធ្ងន់ធ្ងរ! ជនបោកប្រាស់នឹងមិនប្រគល់គណនីមកវិញឡើយ។ ពួកគេនឹងប្តូរពាក្យសម្ងាត់ ឬបណ្តេញអ្នកចេញជារៀងរហូត។'
                : 'Critical mistake! Scammers will never return a hijacked account; they will immediately change credentials to lock you out forever.',
            nextStepKey: null,
          ),
        ],
      ),
    ];
  }

  /// Initialize a fresh gameplay session or resume an existing one
  Future<GameplaySessionState> initializeSession({
    required String scenarioId,
    required String locale,
    bool forceNew = false,
  }) async {
    final isKhmer = locale == 'km';

    // 1. Attempt to load generic scenario definition from local cache / repository
    List<GameplayStep>? loadedSteps;
    String scenarioTitle =
        isKhmer ? 'ការលួចយកគណនី Telegram' : 'Telegram Account Takeover';

    try {
      final detail =
          await repository.getScenarioDetail(scenarioId, locale: locale);
      if (detail != null) {
        scenarioTitle = detail.title;
        if (detail.steps.isNotEmpty &&
            detail.steps.any((s) => s.options.isNotEmpty)) {
          loadedSteps = parseScenarioDetailToSteps(detail, isKhmer: isKhmer);
        }
      }
    } catch (_) {
      // Fallback to bundled scenario content package
    }

    final storySteps =
        loadedSteps ?? getTelegramTakeoverStory(isKhmer: isKhmer);

    // Check for existing uncompleted attempt
    if (!forceNew) {
      final attempts = await repository.getGuestAttempts();
      final activeAttempt = attempts
          .where((a) => a.scenarioId == scenarioId && !a.completed)
          .toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      if (activeAttempt.isNotEmpty) {
        final existing = activeAttempt.first;
        final rawJson = existing.answers;
        if (rawJson.isNotEmpty && rawJson.containsKey('currentStepKey')) {
          try {
            final stepKey = rawJson['currentStepKey'] as String;
            final stage = rawJson['currentStage'] as int? ?? 1;
            final historyRaw = rawJson['history'] as List<dynamic>? ?? [];
            final history = historyRaw
                .map((h) =>
                    GameplayHistoryRecord.fromJson(h as Map<String, dynamic>))
                .toList();

            final chatRaw = rawJson['chatMessages'] as List<dynamic>? ?? [];
            final chat = chatRaw
                .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
                .toList();

            final score = existing.scoreLocal;

            return GameplaySessionState(
              attemptId: existing.attemptId,
              scenarioId: scenarioId,
              scenarioVersion: existing.scenarioVersion,
              scenarioTitle: scenarioTitle,
              currentStepKey: stepKey,
              currentStage: stage,
              chatMessages: chat,
              history: history,
              totalScorePercent: score,
              createdAt: existing.createdAt,
            );
          } catch (_) {
            // Fall back to clean session if corrupted
          }
        }
      }
    }

    // Fresh session
    final initialStep = storySteps.first;
    final attemptId = 'att-${DateTime.now().millisecondsSinceEpoch}';

    final session = GameplaySessionState(
      attemptId: attemptId,
      scenarioId: scenarioId,
      scenarioVersion: 1,
      scenarioTitle: scenarioTitle,
      currentStepKey: initialStep.stepKey,
      currentStage: initialStep.stage,
      chatMessages: List.from(initialStep.messages),
      history: [],
      totalScorePercent: 0,
      createdAt: DateTime.now().toUtc(),
    );

    // Save initial attempt in SQLite
    await _persistAttempt(session);
    return session;
  }

  /// Process a player's decision, evaluate educational outcome, calculate score,
  /// record simulated responses, and persist state in SQLite
  Future<GameplaySessionState> submitDecision({
    required GameplaySessionState currentState,
    required GameplayDecisionOption option,
    required bool isKhmer,
  }) async {
    final storySteps = getTelegramTakeoverStory(isKhmer: isKhmer);
    final currentStep = storySteps.firstWhere(
      (s) => s.stepKey == currentState.currentStepKey,
      orElse: () => storySteps.first,
    );

    // 1. Add user chat message reflecting their chosen response
    final userMessage = ChatMessage(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      senderName: isKhmer ? 'ខ្ញុំ (អ្នក)' : 'Me (You)',
      isUser: true,
      text: option.label,
      timestamp: DateTime.now(),
    );

    final updatedChat = List<ChatMessage>.from(currentState.chatMessages)
      ..add(userMessage);

    // 2. Add simulated scammer reaction if present
    if (option.simulatedReaction != null) {
      final reactionMessage = ChatMessage(
        id: 'rxn_${DateTime.now().millisecondsSinceEpoch}',
        senderName: option.simulatedReaction!.contains('[')
            ? (isKhmer ? 'ប្រព័ន្ធសុវត្ថិភាព' : 'System Alert')
            : (isKhmer ? 'សុភាព (មិត្តភក្តិ)' : 'Sopheap (Friend)'),
        isUser: false,
        isSystem: option.simulatedReaction!.contains('['),
        isCodeAlert: option.simulatedReaction!.contains('⚠️') ||
            option.simulatedReaction!.contains('🚨'),
        text: option.simulatedReaction!,
        timestamp: DateTime.now().add(const Duration(seconds: 1)),
      );
      updatedChat.add(reactionMessage);
    }

    // 3. Record decision in history
    final historyRecord = GameplayHistoryRecord(
      stepKey: currentStep.stepKey,
      stage: currentStep.stage,
      stepPrompt: currentStep.stageTitle,
      selectedOptionId: option.id,
      selectedOptionLabel: option.label,
      safetyCategory: option.safetyCategory,
      scoreEarned: option.scorePercent,
      feedbackText: option.feedbackText,
      timestamp: DateTime.now().toUtc(),
    );

    final updatedHistory =
        List<GameplayHistoryRecord>.from(currentState.history)
          ..add(historyRecord);

    // 4. Calculate aggregate score percent
    final totalEarned =
        updatedHistory.map((h) => h.scoreEarned).fold(0, (a, b) => a + b);
    final averageScore = (totalEarned / updatedHistory.length).round();

    // 5. Determine next state / step
    final nextKey = option.nextStepKey;
    final isFinalStep = nextKey == null;

    final GameplaySessionState nextState;

    if (isFinalStep) {
      // Completed scenario
      nextState = currentState.copyWith(
        chatMessages: updatedChat,
        history: updatedHistory,
        isAwaitingDecision: false,
        isShowingFeedback: true,
        lastDecision: option,
        isCompleted: true,
        totalScorePercent: averageScore,
        completedAt: DateTime.now().toUtc(),
      );
    } else {
      // In-progress, find next step
      final nextStep = storySteps.firstWhere(
        (s) => s.stepKey == nextKey,
        orElse: () => storySteps.first,
      );

      // Append messages from next step
      final nextChatWithNewStep = List<ChatMessage>.from(updatedChat)
        ..addAll(nextStep.messages);

      nextState = currentState.copyWith(
        currentStepKey: nextStep.stepKey,
        currentStage: nextStep.stage,
        chatMessages: nextChatWithNewStep,
        history: updatedHistory,
        isAwaitingDecision: true,
        isShowingFeedback: true,
        lastDecision: option,
        totalScorePercent: averageScore,
      );
    }

    // Persist to Drift SQLite
    await _persistAttempt(nextState);
    return nextState;
  }

  /// Dismisses the feedback overlay to reveal the new chat state or navigate to results
  GameplaySessionState dismissFeedback(GameplaySessionState state) {
    return state.copyWith(isShowingFeedback: false);
  }

  /// Converts a cached or published ScenarioDetailModel into executable GameplaySteps
  List<GameplayStep> parseScenarioDetailToSteps(
    ScenarioDetailModel detail, {
    required bool isKhmer,
  }) {
    return detail.steps.map((stepModel) {
      final stepMessages = [
        ChatMessage(
          id: 'msg_${stepModel.id}',
          senderName: isKhmer ? 'សារសេណារីយ៉ូ' : 'Scenario Message',
          isUser: false,
          isSystem: stepModel.kind == 'feedback',
          text: stepModel.bodyText,
          timestamp: DateTime.now(),
        ),
      ];

      final options = stepModel.options.map((opt) {
        final category = switch (opt.safetyCategory.toLowerCase()) {
          'safe' => GameplaySafetyCategory.safe,
          'caution' => GameplaySafetyCategory.caution,
          _ => GameplaySafetyCategory.unsafe,
        };

        return GameplayDecisionOption(
          id: opt.id,
          optionKey: opt.optionKey,
          orderIndex: opt.orderIndex,
          scoreValue: opt.scoreValue,
          safetyCategory: category,
          label: opt.label,
          feedbackText: opt.feedbackText,
          nextStepKey: opt.nextStepId,
        );
      }).toList();

      return GameplayStep(
        stepKey: stepModel.stepKey,
        stage: stepModel.orderIndex,
        stageTitle: isKhmer
            ? 'ដំណាក់កាលទី ${stepModel.orderIndex}'
            : 'Stage ${stepModel.orderIndex}',
        messages: stepMessages,
        educationalTakeaway: '',
        options: options,
      );
    }).toList();
  }

  /// Fully re-translates an active session when the language changes
  /// Updates all chat messages, history records, active decision/feedback, and scenario title
  /// while preserving attempt ID, branching, scoring, and progress.
  GameplaySessionState retranslateSession({
    required GameplaySessionState state,
    required bool isKhmer,
  }) {
    final storySteps = getTelegramTakeoverStory(isKhmer: isKhmer);
    final title =
        isKhmer ? 'ការលួចយកគណនី Telegram' : 'Telegram Account Takeover';

    // 1. Rebuild history with localized labels, prompt titles, and feedback text
    final List<GameplayHistoryRecord> updatedHistory =
        state.history.map<GameplayHistoryRecord>((record) {
      final step = storySteps.firstWhere(
        (s) => s.stepKey == record.stepKey,
        orElse: () => storySteps.first,
      );
      final opt = step.options.firstWhere(
        (o) =>
            o.id == record.selectedOptionId ||
            o.optionKey == record.selectedOptionId,
        orElse: () => step.options.first,
      );
      return record.copyWith(
        stepPrompt: step.stageTitle,
        selectedOptionLabel: opt.label,
        feedbackText: opt.feedbackText,
      );
    }).toList();

    // 2. Rebuild chat messages from the story progression up to the current state
    final updatedChat = <ChatMessage>[];

    // Initial step's incoming messages
    final initialStep = storySteps.first;
    updatedChat.addAll(initialStep.messages);

    // Replay each decision from history
    for (int i = 0; i < updatedHistory.length; i++) {
      final record = updatedHistory[i];
      final step = storySteps.firstWhere(
        (s) => s.stepKey == record.stepKey,
        orElse: () => storySteps.first,
      );
      final opt = step.options.firstWhere(
        (o) =>
            o.id == record.selectedOptionId ||
            o.optionKey == record.selectedOptionId,
        orElse: () => step.options.first,
      );

      // User's response message
      updatedChat.add(ChatMessage(
        id: 'usr_${record.stepKey}',
        senderName: isKhmer ? 'ខ្ញុំ (អ្នក)' : 'Me (You)',
        isUser: true,
        text: opt.label,
        timestamp: record.timestamp,
      ));

      // Reaction message if any
      if (opt.simulatedReaction != null) {
        final isAlert = opt.simulatedReaction!.contains('[') ||
            opt.simulatedReaction!.contains('⚠️') ||
            opt.simulatedReaction!.contains('🚨');
        updatedChat.add(ChatMessage(
          id: 'rxn_${record.stepKey}',
          senderName: opt.simulatedReaction!.contains('[')
              ? (isKhmer ? 'ប្រព័ន្ធសុវត្ថិភាព' : 'System Alert')
              : (isKhmer ? 'សុភាព (មិត្តភក្តិ)' : 'Sopheap (Friend)'),
          isUser: false,
          isSystem: opt.simulatedReaction!.contains('['),
          isCodeAlert: isAlert,
          text: opt.simulatedReaction!,
          timestamp: record.timestamp.add(const Duration(seconds: 1)),
        ));
      }

      // If there is a next step that followed this decision:
      if (opt.nextStepKey != null) {
        final nextStep = storySteps.firstWhere(
          (s) => s.stepKey == opt.nextStepKey,
          orElse: () => storySteps.first,
        );
        updatedChat.addAll(nextStep.messages);
      }
    }

    // 3. Localize last decision option if showing feedback
    GameplayDecisionOption? localizedLastDecision;
    if (state.lastDecision != null) {
      for (final step in storySteps) {
        for (final opt in step.options) {
          if (opt.id == state.lastDecision!.id ||
              opt.optionKey == state.lastDecision!.optionKey) {
            localizedLastDecision = opt;
            break;
          }
        }
        if (localizedLastDecision != null) break;
      }
    }

    final retranslatedState = state.copyWith(
      scenarioTitle: title,
      chatMessages: updatedChat,
      history: updatedHistory,
      lastDecision: localizedLastDecision ?? state.lastDecision,
    );

    // Persist re-localized attempt in SQLite asynchronously
    _persistAttempt(retranslatedState);

    return retranslatedState;
  }

  /// Re-localizes active session when language toggle is pressed
  GameplaySessionState switchLanguage({
    required GameplaySessionState state,
    required bool toKhmer,
  }) {
    return retranslateSession(state: state, isKhmer: toKhmer);
  }

  /// Save attempt progress or completion state to SQLite
  Future<void> _persistAttempt(GameplaySessionState state) async {
    final attemptModel = GuestAttemptModel(
      attemptId: state.attemptId,
      scenarioId: state.scenarioId,
      scenarioVersion: state.scenarioVersion,
      answers: state.toAttemptJson(),
      scoreLocal: state.totalScorePercent,
      completed: state.isCompleted,
      completedAt: state.completedAt,
      createdAt: state.createdAt,
      updatedAt: DateTime.now().toUtc(),
    );

    await repository.saveGuestAttempt(attemptModel);
  }
}
