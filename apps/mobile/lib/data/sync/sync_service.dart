import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;

import '../local/app_database.dart';

class SyncValidationException implements Exception {
  final String message;
  const SyncValidationException(this.message);

  @override
  String toString() => 'SyncValidationException: $message';
}

class SyncResult {
  final bool success;
  final String? errorMessage;
  final int scenariosCount;
  final DateTime? syncedAt;

  const SyncResult({
    required this.success,
    this.errorMessage,
    this.scenariosCount = 0,
    this.syncedAt,
  });
}

class SyncService {
  final AppDatabase db;
  final http.Client _client;
  final String supabaseUrl;
  final String supabaseAnonKey;

  // Development Supabase Project scamplay-dev
  static const String defaultSupabaseUrl = 'https://ujpyanjnmtxpolhodzkl.supabase.co';
  static const String defaultPublishableKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVqcHlhbmpubXR4cG9saG9kemtsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTQ5MzQ2MTcsImV4cCI6MjExMDUxMDYxN30.H8q6pSTze4j_S6Bn4Hw8g-PgaU2rCCerkYPQwL8Skfo';

  SyncService({
    required this.db,
    http.Client? httpClient,
    String? supabaseUrl,
    String? supabaseAnonKey,
  })  : _client = httpClient ?? http.Client(),
        supabaseUrl = supabaseUrl ?? defaultSupabaseUrl,
        supabaseAnonKey = supabaseAnonKey ?? defaultPublishableKey;

  Map<String, String> get _headers => {
        'apikey': supabaseAnonKey,
        'Authorization': 'Bearer $supabaseAnonKey',
        'Accept': 'application/json',
      };

  Future<SyncResult> synchronizeContent() async {
    try {
      // 1. Fetch remote published content via public anon PostgREST endpoints
      final categoriesData = await _fetchTable('scenario_categories');
      final categoryLocData = await _fetchTable('scenario_category_localizations');
      final scenariosData = await _fetchTable('scenarios');
      final scenarioLocData = await _fetchTable('scenario_localizations');
      final stepsData = await _fetchTable('scenario_steps');
      final stepLocData = await _fetchTable('step_localizations');
      final optionsData = await _fetchTable('answer_options');
      final optionLocData = await _fetchTable('answer_localizations');
      final mediaData = await _fetchTable('media_assets');
      final mediaLocData = await _fetchTable('media_localizations');

      // 2. Validate bilingual completeness (km and en required for each item)
      _validateCompleteness(
        scenarios: scenariosData,
        scenarioLocs: scenarioLocData,
        steps: stepsData,
        stepLocs: stepLocData,
        options: optionsData,
        optionLocs: optionLocData,
      );

      // 3. Atomically update local cache within a single SQLite transaction
      final syncTimestamp = DateTime.now().toUtc();
      await db.transaction(() async {
        // Clear cached learning content tables in reverse dependency order
        // Note: GuestAttempts and AppPreferences are strictly preserved!
        await db.delete(db.cachedAnswerLocalizations).go();
        await db.delete(db.cachedAnswerOptions).go();
        await db.delete(db.cachedStepLocalizations).go();
        await db.delete(db.cachedScenarioSteps).go();
        await db.delete(db.cachedScenarioLocalizations).go();
        await db.delete(db.cachedScenarios).go();
        await db.delete(db.cachedMediaLocalizations).go();
        await db.delete(db.cachedMediaAssets).go();
        await db.delete(db.cachedScenarioCategoryLocalizations).go();
        await db.delete(db.cachedScenarioCategories).go();

        // Insert categories
        for (final item in categoriesData) {
          await db.into(db.cachedScenarioCategories).insert(
                CachedScenarioCategoriesCompanion.insert(
                  id: item['id'] as String,
                  slug: item['slug'] as String,
                  sortOrder: Value((item['sort_order'] as num?)?.toInt() ?? 0),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert category localizations
        for (final item in categoryLocData) {
          await db.into(db.cachedScenarioCategoryLocalizations).insert(
                CachedScenarioCategoryLocalizationsCompanion.insert(
                  categoryId: item['category_id'] as String,
                  locale: item['locale'] as String,
                  name: item['name'] as String,
                  description: Value(item['description'] as String? ?? ''),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert media assets
        for (final item in mediaData) {
          await db.into(db.cachedMediaAssets).insert(
                CachedMediaAssetsCompanion.insert(
                  id: item['id'] as String,
                  storagePath: item['storage_path'] as String,
                  mediaType: item['media_type'] as String,
                  mimeType: item['mime_type'] as String,
                  sizeBytes: Value((item['size_bytes'] as num?)?.toInt()),
                  contentHash: Value(item['content_hash'] as String?),
                  licenseStatus: item['license_status'] as String,
                  reviewStatus: item['review_status'] as String,
                  localPath: const Value(null),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert media localizations
        for (final item in mediaLocData) {
          await db.into(db.cachedMediaLocalizations).insert(
                CachedMediaLocalizationsCompanion.insert(
                  mediaAssetId: item['media_asset_id'] as String,
                  locale: item['locale'] as String,
                  altText: item['alt_text'] as String,
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert scenarios
        for (final item in scenariosData) {
          await db.into(db.cachedScenarios).insert(
                CachedScenariosCompanion.insert(
                  id: item['id'] as String,
                  slug: item['slug'] as String,
                  categoryId: item['category_id'] as String,
                  coverMediaId: Value(item['cover_media_id'] as String?),
                  estimatedMinutes: (item['estimated_minutes'] as num).toInt(),
                  status: item['status'] as String,
                  version: Value((item['version'] as num?)?.toInt() ?? 1),
                  publishedAt: Value(
                    item['published_at'] != null
                        ? DateTime.parse(item['published_at'] as String)
                        : null,
                  ),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert scenario localizations
        for (final item in scenarioLocData) {
          await db.into(db.cachedScenarioLocalizations).insert(
                CachedScenarioLocalizationsCompanion.insert(
                  scenarioId: item['scenario_id'] as String,
                  locale: item['locale'] as String,
                  title: item['title'] as String,
                  summary: item['summary'] as String,
                  intro: item['intro'] as String,
                  closingSummary: item['closing_summary'] as String,
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert scenario steps
        for (final item in stepsData) {
          await db.into(db.cachedScenarioSteps).insert(
                CachedScenarioStepsCompanion.insert(
                  id: item['id'] as String,
                  scenarioId: item['scenario_id'] as String,
                  stepKey: item['step_key'] as String,
                  kind: item['kind'] as String,
                  orderIndex: (item['order_index'] as num).toInt(),
                  mediaAssetId: Value(item['media_asset_id'] as String?),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert step localizations
        for (final item in stepLocData) {
          await db.into(db.cachedStepLocalizations).insert(
                CachedStepLocalizationsCompanion.insert(
                  stepId: item['step_id'] as String,
                  locale: item['locale'] as String,
                  bodyText: item['body_text'] as String,
                  narrationMediaId: Value(item['narration_media_id'] as String?),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert answer options
        for (final item in optionsData) {
          await db.into(db.cachedAnswerOptions).insert(
                CachedAnswerOptionsCompanion.insert(
                  id: item['id'] as String,
                  stepId: item['step_id'] as String,
                  optionKey: item['option_key'] as String,
                  orderIndex: (item['order_index'] as num).toInt(),
                  scoreValue: Value((item['score_value'] as num?)?.toInt() ?? 0),
                  safetyCategory: item['safety_category'] as String,
                  nextStepId: Value(item['next_step_id'] as String?),
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Insert answer localizations
        for (final item in optionLocData) {
          await db.into(db.cachedAnswerLocalizations).insert(
                CachedAnswerLocalizationsCompanion.insert(
                  optionId: item['option_id'] as String,
                  locale: item['locale'] as String,
                  label: item['label'] as String,
                  feedbackText: item['feedback_text'] as String,
                  createdAt: DateTime.parse(item['created_at'] as String),
                  updatedAt: DateTime.parse(item['updated_at'] as String),
                ),
              );
        }

        // Update sync metadata
        await db.setSyncMetadata(
          'content_last_synced_at',
          'success',
          syncTimestamp,
        );
      });

      return SyncResult(
        success: true,
        scenariosCount: scenariosData.length,
        syncedAt: syncTimestamp,
      );
    } catch (e) {
      return SyncResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<List<Map<String, dynamic>>> _fetchTable(String table) async {
    final uri = Uri.parse('$supabaseUrl/rest/v1/$table?select=*');
    final response = await _client.get(uri, headers: _headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is List) {
        return decoded.map((e) => e as Map<String, dynamic>).toList();
      }
      throw SyncValidationException('Expected list response for table $table');
    }

    throw SyncValidationException(
      'Failed to fetch table $table: HTTP ${response.statusCode} - ${utf8.decode(response.bodyBytes)}',
    );
  }

  void _validateCompleteness({
    required List<Map<String, dynamic>> scenarios,
    required List<Map<String, dynamic>> scenarioLocs,
    required List<Map<String, dynamic>> steps,
    required List<Map<String, dynamic>> stepLocs,
    required List<Map<String, dynamic>> options,
    required List<Map<String, dynamic>> optionLocs,
  }) {
    // 1. Every scenario must have both 'km' and 'en'
    final Map<String, Set<String>> scenarioLocMap = {};
    for (final loc in scenarioLocs) {
      final id = loc['scenario_id'] as String;
      final locale = loc['locale'] as String;
      scenarioLocMap.putIfAbsent(id, () => <String>{}).add(locale);
    }

    for (final s in scenarios) {
      final id = s['id'] as String;
      final locales = scenarioLocMap[id] ?? {};
      if (!locales.contains('km') || !locales.contains('en')) {
        throw SyncValidationException(
          'Scenario ${s['slug']} ($id) missing required bilingual localizations. Has: $locales',
        );
      }
    }

    // 2. Every step must have both 'km' and 'en'
    final Map<String, Set<String>> stepLocMap = {};
    for (final loc in stepLocs) {
      final id = loc['step_id'] as String;
      final locale = loc['locale'] as String;
      stepLocMap.putIfAbsent(id, () => <String>{}).add(locale);
    }

    for (final step in steps) {
      final id = step['id'] as String;
      final locales = stepLocMap[id] ?? {};
      if (!locales.contains('km') || !locales.contains('en')) {
        throw SyncValidationException(
          'Step ${step['step_key']} ($id) missing required bilingual localizations. Has: $locales',
        );
      }
    }

    // 3. Every option must have both 'km' and 'en'
    final Map<String, Set<String>> optionLocMap = {};
    for (final loc in optionLocs) {
      final id = loc['option_id'] as String;
      final locale = loc['locale'] as String;
      optionLocMap.putIfAbsent(id, () => <String>{}).add(locale);
    }

    for (final opt in options) {
      final id = opt['id'] as String;
      final locales = optionLocMap[id] ?? {};
      if (!locales.contains('km') || !locales.contains('en')) {
        throw SyncValidationException(
          'Option ${opt['option_key']} ($id) missing required bilingual localizations. Has: $locales',
        );
      }
    }
  }
}
