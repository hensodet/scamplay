import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/models/scenario_models.dart';
import 'data/repositories/content_repository.dart';
import 'data/sync/sync_service.dart';
import 'ui/screens/scenario_detail_screen.dart';
import 'ui/theme/app_typography.dart';
import 'ui/widgets/coming_soon_sheet.dart';
import 'ui/widgets/scenario_card_widget.dart';

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
        fontFamily: AppTypography.fontKantumruyPro,
        fontFamilyFallback: AppTypography.khmerHeadingFallback,
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
  List<ScenarioCardModel> _allScenarios = [];
  List<ScenarioCardModel> _filteredScenarios = [];
  String? _selectedCategorySlug; // null = all
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
        _allScenarios = cards;
        _applyFilter();
        _lastSyncTime = lastSync;
        _isLoading = false;
      });
    }
  }

  void _applyFilter() {
    if (_selectedCategorySlug == null) {
      _filteredScenarios = List.from(_allScenarios);
    } else {
      _filteredScenarios = _allScenarios
          .where((card) => card.categorySlug == _selectedCategorySlug)
          .toList();
    }
  }

  void _onCategorySelected(String? categorySlug) {
    setState(() {
      _selectedCategorySlug = categorySlug;
      _applyFilter();
    });
  }

  Future<void> _triggerSync() async {
    setState(() {
      _isSyncing = true;
      _syncStatusMessage = isKhmer ? 'កំពុងធ្វើបច្ចុប្បន្នភាពមាតិកា...' : 'Syncing content...';
    });

    final result = await widget.syncService.synchronizeContent();

    if (mounted) {
      setState(() {
        _isSyncing = false;
        if (result.success) {
          _syncStatusMessage = isKhmer
              ? 'បានធ្វើបច្ចុប្បន្នភាពជោគជ័យ (${result.scenariosCount} សេណារីយ៉ូ)'
              : 'Sync successful (${result.scenariosCount} scenarios)';
        } else {
          _syncStatusMessage = isKhmer
              ? 'មិនអាចធ្វើបច្ចុប្បន្នភាពបានទេ (ប្រើទិន្នន័យក្រៅបណ្តាញ)'
              : 'Sync unavailable (using offline data)';
        }
      });
      await _loadLocalContent();
    }
  }

  void _onCardTapped(ScenarioCardModel card) {
    if (card.isPlayable) {
      // Navigate to Scenario Preview / Detail Screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ScenarioDetailScreen(
            scenarioId: card.id,
            categorySlug: card.categorySlug,
            repository: widget.repository,
            currentLocale: widget.currentLocale,
            onLocaleChanged: widget.onLocaleChanged,
          ),
        ),
      );
    } else {
      // Show friendly Coming Soon sheet
      ComingSoonSheet.show(context, card, isKhmer);
    }
  }

  String _formatDateTime(DateTime dt) {
    final local = dt.toLocal();
    final y = local.year.toString();
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    final hh = local.hour.toString().padLeft(2, '0');
    final mm = local.minute.toString().padLeft(2, '0');
    return '$y-$m-$d $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Compact brand title in AppBar avoiding portrait truncation
        title: const Text(
          'ScamPlay',
          style: TextStyle(
            fontFamily: AppTypography.fontKantumruyPro,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: 0.2,
            color: Color(0xFF0F172A),
          ),
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
            tooltip: isKhmer ? 'ធ្វើបច្ចុប្បន្នភាពមាតិកា' : 'Sync Content',
            style: IconButton.styleFrom(
              minimumSize: const Size(48, 48),
            ),
            onPressed: _isSyncing ? null : _triggerSync,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 48),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              icon: const Icon(Icons.language, size: 18),
              label: Text(
                isKhmer ? 'English' : 'ភាសាខ្មែរ',
                style: AppTypography.button(isKhmer: isKhmer, fontSize: 13),
              ),
              onPressed: () {
                widget.onLocaleChanged(
                  isKhmer ? const Locale('en') : const Locale('km'),
                );
              },
            ),
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
                // 1. Compact Educational Disclaimer Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB), // Amber 50
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 16.0, color: Color(0xFFB45309)),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          isKhmer
                              ? 'គម្រោងគំរូអប់រំឯករាជ្យ៖ ដើម្បីបង្កើនការយល់ដឹងអំពីល្បិចបោកប្រាស់ និងសុវត្ថិភាពឌីជីថល (ពុំមែនជាស្ថាប័នរដ្ឋ ឬសមត្ថកិច្ចឡើយ)។'
                              : 'Independent Educational Prototype: Building awareness against digital fraud and social engineering (Not an official authority).',
                          style: AppTypography.body(
                            isKhmer: isKhmer,
                            fontSize: 11.5,
                            height: 1.35,
                            color: const Color(0xFF78350F), // Amber 900
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),

                // 2. Offline & Sync Status Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // Slate 50
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _lastSyncTime != null
                            ? Icons.cloud_done_outlined
                            : Icons.cloud_off_outlined,
                        size: 16.0,
                        color: const Color(0xFF1E3A8A),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          _syncStatusMessage ??
                              (_lastSyncTime != null
                                  ? (isKhmer
                                      ? 'មាតិការក្សាទុកក្រៅបណ្តាញ • ធ្វើបច្ចុប្បន្នភាពចុងក្រោយ៖ ${_formatDateTime(_lastSyncTime!)}'
                                      : 'Available offline • Last updated: ${_formatDateTime(_lastSyncTime!)}')
                                  : (isKhmer
                                      ? 'ទិន្នន័យក្រៅបណ្តាញក្នុងមូលដ្ឋាន'
                                      : 'Local offline data')),
                          style: AppTypography.body(
                            isKhmer: isKhmer,
                            fontSize: 11.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18.0),

                // 3. Scenario Library Page Header inside body (Kantumruy Pro)
                Text(
                  isKhmer ? 'បណ្ណាល័យសេណារីយ៉ូ' : 'Scenario Library',
                  style: AppTypography.pageTitle(isKhmer: isKhmer),
                ),
                const SizedBox(height: 4.0),
                Text(
                  isKhmer
                      ? 'ជ្រើសរើសសេណារីយ៉ូឆបោក ដើម្បីអនុវត្តការសម្រេចចិត្តប្រកបដោយសុវត្ថិភាព'
                      : 'Choose a scam scenario to practice safer digital decisions',
                  style: AppTypography.caption(isKhmer: isKhmer, fontSize: 13.5),
                ),
                const SizedBox(height: 16.0),

                // 4. Category Filter Pills
                if (_allScenarios.isNotEmpty) _buildCategoryFilterPills(),

                const SizedBox(height: 16.0),

                // 5. Scenario list or empty state
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_allScenarios.isEmpty)
                  _buildEmptyState()
                else if (_filteredScenarios.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        isKhmer
                            ? 'មិនមានសេណារីយ៉ូក្នុងប្រភេទនេះនៅឡើយ'
                            : 'No scenarios found in this category',
                        style: AppTypography.caption(isKhmer: isKhmer),
                      ),
                    ),
                  )
                else
                  ..._filteredScenarios.map(
                    (card) => ScenarioCardWidget(
                      key: ValueKey('scenario_card_${card.id}'),
                      card: card,
                      isKhmer: isKhmer,
                      onTap: () => _onCardTapped(card),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilterPills() {
    // Collect distinct categories from scenarios
    final Map<String, String> categories = {};
    for (final s in _allScenarios) {
      categories[s.categorySlug] = s.categoryName;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // All category pill
          ChoiceChip(
            key: const ValueKey('category_filter_all'),
            label: Text(
              isKhmer ? 'ទាំងអស់' : 'All',
              style: AppTypography.chip(
                isKhmer: isKhmer,
                isSelected: _selectedCategorySlug == null,
              ),
            ),
            selected: _selectedCategorySlug == null,
            onSelected: (_) => _onCategorySelected(null),
            selectedColor: const Color(0xFF1E3A8A).withValues(alpha: 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
          const SizedBox(width: 8),
          // Category pills
          ...categories.entries.map((entry) {
            final isSelected = _selectedCategorySlug == entry.key;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                key: ValueKey('category_filter_${entry.key}'),
                label: Text(
                  entry.value,
                  style: AppTypography.chip(
                    isKhmer: isKhmer,
                    isSelected: isSelected,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  _onCategorySelected(selected ? entry.key : null);
                },
                selectedColor: const Color(0xFF1E3A8A).withValues(alpha: 0.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          const Icon(Icons.inventory_2_outlined, size: 48.0, color: Color(0xFF94A3B8)),
          const SizedBox(height: 12.0),
          Text(
            isKhmer
                ? 'មិនទាន់មានទិន្នន័យសេណារីយ៉ូក្នុងឧបករណ៍នៅឡើយ'
                : 'No scenario content cached yet',
            style: AppTypography.sectionHeading(isKhmer: isKhmer),
          ),
          const SizedBox(height: 6.0),
          Text(
            isKhmer
                ? 'សូមភ្ជាប់អ៊ីនធឺណិត ហើយចុចប៊ូតុងខាងក្រោមដើម្បីទាញយកសេណារីយ៉ូ។'
                : 'Please connect to internet and tap below to download scenarios.',
            textAlign: TextAlign.center,
            style: AppTypography.body(isKhmer: isKhmer, fontSize: 12.5),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: _isSyncing ? null : _triggerSync,
            icon: const Icon(Icons.download),
            label: Text(
              isKhmer ? 'ទាញយកសេណារីយ៉ូ' : 'Download Scenarios',
              style: AppTypography.button(isKhmer: isKhmer),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(180, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
