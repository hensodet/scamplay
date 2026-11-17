import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ScamPlayApp extends StatefulWidget {
  const ScamPlayApp({super.key});

  @override
  State<ScamPlayApp> createState() => _ScamPlayAppState();
}

class _ScamPlayAppState extends State<ScamPlayApp> {
  Locale _currentLocale = const Locale('km'); // Default to Khmer

  void _setLocale(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
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
        currentLocale: _currentLocale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const HomeScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  bool get isKhmer => currentLocale.languageCode == 'km';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isKhmer ? 'ScamPlay — សុវត្ថិភាពឌីជីថល' : 'ScamPlay — Digital Safety',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.language),
            label: Text(
              isKhmer ? 'English' : 'ភាសាខ្មែរ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              onLocaleChanged(
                isKhmer ? const Locale('en') : const Locale('km'),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 24.0),
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
              Card(
                elevation: 2.0,
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
                              isKhmer ? 'មេរៀនទី ១' : 'Scenario 1',
                              style: const TextStyle(fontSize: 11.0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Text(
                              isKhmer ? 'ដំណើរការក្នុង M4' : 'Playable after M4',
                              style: TextStyle(fontSize: 11.0, color: Colors.blue.shade900),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        isKhmer
                            ? 'ល្បិចបោកយកគណនី Telegram'
                            : 'Telegram Account Takeover Trick',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        isKhmer
                            ? 'ស្វែងយល់ពីសារក្លែងបន្លំតាម Messenger ដែលព្យាយាមលួចលេខកូដ Telegram។'
                            : 'Learn how Messenger impersonators try to steal Telegram login codes.',
                        style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
