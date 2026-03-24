import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eqqu/app_state.dart';
import 'package:eqqu/cache/cache_manager.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/theme/app_theme.dart';
import 'package:eqqu/theme/theme_notifier.dart';
import 'package:eqqu/utils/language_notifier.dart';
import 'package:eqqu/providers/favorites_provider.dart';
import 'package:eqqu/providers/cart_provider.dart';
import 'package:eqqu/providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await CacheManager.init();
  } catch (e) {
    debugPrint('CacheManager.init failed: $e');
  }

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exceptionAsString()}');
  };

  runApp(const EqquApp());
}

class EqquApp extends StatefulWidget {
  const EqquApp({super.key});

  @override
  State<EqquApp> createState() => _EqquAppState();
}

class _EqquAppState extends State<EqquApp> {
  final _themeNotifier = ThemeNotifier();
  final _languageNotifier = LanguageNotifier();

  @override
  void initState() {
    super.initState();
    _themeNotifier.addListener(() => setState(() {}));
    _languageNotifier.addListener(() => setState(() {}));
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      await Future.wait([
        _themeNotifier.load(),
        _languageNotifier.load(),
      ]);
    } catch (e) {
      debugPrint('Failed to load preferences: $e');
    }
  }

  @override
  void dispose() {
    _themeNotifier.dispose();
    _languageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeNotifier),
        ChangeNotifierProvider.value(value: _languageNotifier),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: AppState(
        themeNotifier: _themeNotifier,
        languageNotifier: _languageNotifier,
        child: MaterialApp(
        title: 'EQQU',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeNotifier.themeMode,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
