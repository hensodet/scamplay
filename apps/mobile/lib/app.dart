import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/models/scenario_models.dart';
import 'data/repositories/content_repository.dart';
import 'data/sync/sync_service.dart';

class ScamPlayApp extends StatefulWidget {
  final ContentRepository repository;
  final SyncService syncService;
  final Locale initialLocale;

  const ScamPlayApp({
    super.key,
    required this.repository,
    required this.syncService,
    this.initialLocale = const Locale('km'),
  });

  @override
  State<ScamPlayApp> createState() => _ScamPlayAppState();
}

class _ScamPlayAppState extends State<ScamPlayApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.initialLocale;
  }

  void _setLocale(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
    // Persist language selection across app restarts in SQLite
    widget.repository.setLanguagePreference(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScamPlay',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      supportedLocales: const [
        Locale('km'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Deep Navy
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'KantumruyPro',
      ),
      home: HomeScreen(
        repository: widget.repository,
        syncService: widget.syncService,
        currentLocale: _currentLocale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final ContentRepository repository;
  final SyncService syncService;
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const HomeScreen({
    super.key,
    required this.repository,
    required this.syncService,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ScenarioCardModel> _scenarios = [];
  bool _isLoading = true;
  bool _isSyncing = false;
  String? _syncStatusMessage;
  DateTime? _lastSyncTime;

  bool get isKhmer => widget.currentLocale.languageCode == 'km';

  @override
  void initState() {
    super.initState();
    _loadLocalContent();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocale != widget.currentLocale) {
      _loadLocalContent();
    }
  }

  Future<void> _loadLocalContent() async {
    setState(() => _isLoading = true);
    final cards = await widget.repository.getScenarioCards(
      locale: widget.currentLocale.languageCode,
    );
    final lastSync = await widget.repository.getLastSyncTime();

    if (mounted) {
      setState(() {
        _scenarios = cards;
        _lastSyncTime = lastSync;
        _isLoading = false;
      });
    }
  }

  Future<void> _triggerSync() async {
    setState(() {
      _isSyncing = true;
      _syncStatusMessage = isKhmer ? 'កំពុងធ្វើសមកាលកម្ម...' : 'Syncing content...';
    });

    final result = await widget.syncService.synchronizeContent();

    if (mounted) {
      setState(() {
        _isSyncing = false;
        if (result.success) {
          _syncStatusMessage = isKhmer
              ? 'សមកាលកម្មជោគជ័យ (${result.scenariosCount} មេរៀន)'
              : 'Sync successful (${result.scenariosCount} scenarios)';
        } else {
          _syncStatusMessage = isKhmer
              ? 'សមកាលកម្មបរាជ័យ (ប្រើទិន្នន័យក្រៅបណ្តាញ)'
              : 'Sync failed (using offline data)';
        }
      });
      await _loadLocalContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isKhmer ? 'ScamPlay — សុវត្ថិភាពឌីជីថល' : 'ScamPlay — Digital Safety',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: _isSyncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.sync),
            tooltip: isKhmer ? 'ធ្វើសមកាលកម្មមាតិកា' : 'Sync Content',
            onPressed: _isSyncing ? null : _triggerSync,
          ),
          TextButton.icon(
            icon: const Icon(Icons.language),
            label: Text(
              isKhmer ? 'English' : 'ភាសាខ្មែរ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              widget.onLocaleChanged(
                isKhmer ? const Locale('en') : const Locale('km'),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _triggerSync,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Educational notice banner
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.amber),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          isKhmer
                              ? 'គម្រោងគំរូអប់រំឯករាជ្យ៖ រៀបចំឡើងដើម្បីបណ្តុះបណ្តាលការស្គាល់ល្បិចបោកប្រាស់តាមប្រព័ន្ធឌីជីថល។'
                              : 'Independent Educational Prototype: Designed to build awareness against digital fraud and social engineering.',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),

                // Offline & Sync Status Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.blueGrey.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _lastSyncTime != null ? Icons.cloud_done : Icons.cloud_off,
                        size: 16.0,
                        color: Colors.blueGrey.shade700,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          _syncStatusMessage ??
                              (_lastSyncTime != null
                                  ? (isKhmer
                                      ? 'ទិន្នន័យក្រៅបណ្តាញ (សមកាលកម្មចុងក្រោយ៖ ${_lastSyncTime!.toLocal().toString().split('.').first})'
                                      : 'Offline cache (Last synced: ${_lastSyncTime!.toLocal().toString().split('.').first})')
                                  : (isKhmer
                                      ? 'ទិន្នន័យក្រៅបណ្តាញក្នុងមូលដ្ឋាន'
                                      : 'Local offline mode')),
                          style: TextStyle(fontSize: 11.0, color: Colors.blueGrey.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                // Scenario Library Header
                Text(
                  isKhmer ? 'បណ្ណាល័យសេណារីយ៉ូ (Scenario Library)' : 'Scenario Library',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  isKhmer
                      ? 'ជ្រើសរើសមេរៀនដើម្បីចាប់ផ្តើមរៀន និងអនុវត្តជាក់ស្តែង'
                      : 'Choose a scenario to start learning and practicing safety decisions',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                const SizedBox(height: 16.0),

                // Scenario list or empty state
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_scenarios.isEmpty)
                  _buildEmptyState()
                else
                  ..._scenarios.map(_buildScenarioCard),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(Icons.inventory_2_outlined, size: 48.0, color: Colors.grey.shade400),
          const SizedBox(height: 12.0),
          Text(
            isKhmer
                ? 'មិនទាន់មានទិន្នន័យមេរៀនក្នុងឧបករណ៍នៅឡើយ'
                : 'No scenario content cached yet',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          const SizedBox(height: 6.0),
          Text(
            isKhmer
                ? 'សូមភ្ជាប់អ៊ីនធឺណិត ហើយចុចប៊ូតុងខាងក្រោមដើម្បីទាញយកមេរៀន។'
                : 'Please connect to internet and tap below to download scenarios.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: _isSyncing ? null : _triggerSync,
            icon: const Icon(Icons.download),
            label: Text(isKhmer ? 'ទាញយកមាតិកា' : 'Download Content'),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(ScenarioCardModel card) {
    final statusText = card.status == 'published'
        ? (isKhmer ? 'ដំណើរការក្នុង M4' : 'Playable after M4')
        : (isKhmer ? 'មកដល់ឆាប់ៗ' : 'Coming Soon');

    return Card(
      key: ValueKey(card.id),
      elevation: 2.0,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    card.categoryName,
                    style: const TextStyle(fontSize: 11.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: card.isPlayable ? Colors.blue.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: card.isPlayable ? Colors.blue.shade200 : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: card.isPlayable ? Colors.blue.shade900 : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              card.title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              card.summary,
              style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.schedule, size: 14.0, color: Colors.grey.shade500),
                const SizedBox(width: 4.0),
                Text(
                  isKhmer
                      ? '${card.estimatedMinutes} នាទី'
                      : '${card.estimatedMinutes} mins',
                  style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
