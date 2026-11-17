import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:drift/native.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/repositories/content_repository.dart';
import 'package:mobile/data/sync/sync_service.dart';
import 'package:mobile/data/models/scenario_models.dart';

class MockHttpClient extends http.BaseClient {
  final Future<http.Response> Function(http.Request request) handler;
  MockHttpClient(this.handler);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await handler(request as http.Request);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
    );
  }
}

http.Response jsonResponse(dynamic body, [int status = 200]) {
  return http.Response.bytes(
    utf8.encode(jsonEncode(body)),
    status,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

void main() {
  late AppDatabase db;
  late DriftContentRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftContentRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SyncService Unit & Integration Tests', () {
    test('1. Successful sync populates database atomically with bilingual data', () async {
      final mockClient = MockHttpClient((request) async {
        final path = request.url.path;

        if (path.endsWith('/scenario_categories')) {
          return jsonResponse([
            {
              'id': 'cat-001',
              'slug': 'impersonation',
              'sort_order': 1,
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/scenario_category_localizations')) {
          return jsonResponse([
            {
              'category_id': 'cat-001',
              'locale': 'km',
              'name': 'ការបន្លំខ្លួន',
              'description': '',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            },
            {
              'category_id': 'cat-001',
              'locale': 'en',
              'name': 'Impersonation',
              'description': '',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/scenarios')) {
          return jsonResponse([
            {
              'id': 'scen-001',
              'slug': 'telegram-takeover',
              'category_id': 'cat-001',
              'cover_media_id': null,
              'estimated_minutes': 5,
              'status': 'published',
              'version': 1,
              'published_at': '2026-11-18T00:00:00Z',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/scenario_localizations')) {
          return jsonResponse([
            {
              'scenario_id': 'scen-001',
              'locale': 'km',
              'title': 'ល្បិចលួចគណនី Telegram',
              'summary': 'សង្ខេបមេរៀនជាភាសាខ្មែរ',
              'intro': 'សេចក្តីផ្តើម',
              'closing_summary': 'សេចក្តីបញ្ចប់',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            },
            {
              'scenario_id': 'scen-001',
              'locale': 'en',
              'title': 'Telegram Takeover Trick',
              'summary': 'Summary in English',
              'intro': 'Intro',
              'closing_summary': 'Closing',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/scenario_steps')) {
          return jsonResponse([
            {
              'id': 'step-001',
              'scenario_id': 'scen-001',
              'step_key': 'step-1',
              'kind': 'decision',
              'order_index': 1,
              'media_asset_id': null,
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/step_localizations')) {
          return jsonResponse([
            {
              'step_id': 'step-001',
              'locale': 'km',
              'body_text': 'តើអ្នកគួរឆ្លើយយ៉ាងណា?',
              'narration_media_id': null,
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            },
            {
              'step_id': 'step-001',
              'locale': 'en',
              'body_text': 'How should you answer?',
              'narration_media_id': null,
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/answer_options')) {
          return jsonResponse([
            {
              'id': 'opt-001',
              'step_id': 'step-001',
              'option_key': 'opt-safe',
              'order_index': 1,
              'score_value': 100,
              'safety_category': 'safe',
              'next_step_id': null,
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/answer_localizations')) {
          return jsonResponse([
            {
              'option_id': 'opt-001',
              'locale': 'km',
              'label': 'បដិសេធ',
              'feedback_text': 'ជម្រើសសុវត្ថិភាព',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            },
            {
              'option_id': 'opt-001',
              'locale': 'en',
              'label': 'Refuse',
              'feedback_text': 'Safe choice',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/media_assets') || path.endsWith('/media_localizations')) {
          return jsonResponse([]);
        }

        return http.Response('Not Found', 404);
      });

      final syncService = SyncService(
        db: db,
        httpClient: mockClient,
      );

      final result = await syncService.synchronizeContent();
      expect(result.success, isTrue, reason: result.errorMessage);
      expect(result.scenariosCount, equals(1));
      expect(result.syncedAt, isNotNull);

      // Verify cached scenarios exist in database
      final cardsKm = await repository.getScenarioCards(locale: 'km');
      expect(cardsKm.length, equals(1));
      expect(cardsKm.first.title, equals('ល្បិចលួចគណនី Telegram'));

      final cardsEn = await repository.getScenarioCards(locale: 'en');
      expect(cardsEn.length, equals(1));
      expect(cardsEn.first.title, equals('Telegram Takeover Trick'));
    });

    test('2. Missing translation fails completeness validation and aborts sync', () async {
      final mockClient = MockHttpClient((request) async {
        final path = request.url.path;

        if (path.endsWith('/scenario_categories')) {
          return jsonResponse([]);
        } else if (path.endsWith('/scenario_category_localizations')) {
          return jsonResponse([]);
        } else if (path.endsWith('/scenarios')) {
          return jsonResponse([
            {
              'id': 'scen-broken',
              'slug': 'broken-scenario',
              'category_id': 'cat-001',
              'estimated_minutes': 3,
              'status': 'published',
              'version': 1,
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else if (path.endsWith('/scenario_localizations')) {
          // Only Khmer provided, English missing!
          return jsonResponse([
            {
              'scenario_id': 'scen-broken',
              'locale': 'km',
              'title': 'មានតែខ្មែរ',
              'summary': 'អត់មានអង់គ្លេស',
              'intro': 'intro',
              'closing_summary': 'closing',
              'created_at': '2026-11-18T00:00:00Z',
              'updated_at': '2026-11-18T00:00:00Z',
            }
          ]);
        } else {
          return jsonResponse([]);
        }
      });

      final syncService = SyncService(
        db: db,
        httpClient: mockClient,
      );

      final result = await syncService.synchronizeContent();
      expect(result.success, isFalse);
      expect(result.errorMessage, contains('missing required bilingual localizations'));

      // Ensure cache remains completely empty
      final count = await repository.getCachedScenarioCount();
      expect(count, equals(0));
    });

    test('3. Failed network request rolls back and preserves existing cache', () async {
      // First populate valid cache manually
      final now = DateTime.utc(2026, 11, 18, 10, 0, 0);
      await db.into(db.cachedScenarioCategories).insert(
            CachedScenarioCategoriesCompanion.insert(
              id: 'cat-old',
              slug: 'old-cat',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedScenarioCategoryLocalizations).insert(
            CachedScenarioCategoryLocalizationsCompanion.insert(
              categoryId: 'cat-old',
              locale: 'km',
              name: 'ចាស់',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedScenarios).insert(
            CachedScenariosCompanion.insert(
              id: 'scen-old',
              slug: 'old-scen',
              categoryId: 'cat-old',
              estimatedMinutes: 5,
              status: 'published',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedScenarioLocalizations).insert(
            CachedScenarioLocalizationsCompanion.insert(
              scenarioId: 'scen-old',
              locale: 'km',
              title: 'មេរៀនចាស់',
              summary: 'សង្ខេបចាស់',
              intro: 'ផ្តើម',
              closingSummary: 'បញ្ចប់',
              createdAt: now,
              updatedAt: now,
            ),
          );

      expect(await repository.getCachedScenarioCount(), equals(1));

      // Mock client that fails with 500 error
      final mockClient = MockHttpClient((request) async {
        return http.Response('Server Internal Error', 500);
      });

      final syncService = SyncService(
        db: db,
        httpClient: mockClient,
      );

      final result = await syncService.synchronizeContent();
      expect(result.success, isFalse);
      expect(result.errorMessage, contains('500'));

      // Verify the old cached scenario is STILL present (zero corruption)
      expect(await repository.getCachedScenarioCount(), equals(1));
      final cards = await repository.getScenarioCards(locale: 'km');
      expect(cards.first.title, equals('មេរៀនចាស់'));
    });

    test('4. Guest attempts are preserved across sync execution', () async {
      // Record guest attempt
      final attempt = GuestAttemptModel(
        attemptId: 'guest-att-999',
        scenarioId: 'scen-001',
        scenarioVersion: 1,
        answers: {'q': 'a'},
        scoreLocal: 90,
        completed: true,
        completedAt: DateTime.now().toUtc(),
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      );
      await repository.saveGuestAttempt(attempt);

      // Run failing sync
      final failingClient = MockHttpClient((request) async {
        throw Exception('Connection reset by peer');
      });
      final syncService = SyncService(db: db, httpClient: failingClient);
      final result = await syncService.synchronizeContent();
      expect(result.success, isFalse);

      // Verify attempt is intact
      final attempts = await repository.getGuestAttempts();
      expect(attempts.length, equals(1));
      expect(attempts.first.attemptId, equals('guest-att-999'));
    });
  });
}
