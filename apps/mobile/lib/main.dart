import 'package:flutter/material.dart';

import 'app.dart';
import 'data/local/app_database.dart';
import 'data/repositories/content_repository.dart';
import 'data/sync/sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  final repository = DriftContentRepository(db);
  final syncService = SyncService(db: db);

  // Load persistent user language selection (Khmer default per AGENTS.md)
  final initialLang = await repository.getLanguagePreference();

  runApp(ScamPlayApp(
    repository: repository,
    syncService: syncService,
    initialLocale: Locale(initialLang),
  ));
}
