import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eqqu/app_state.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/theme/app_theme.dart';
import 'package:eqqu/theme/theme_notifier.dart';
import 'package:eqqu/utils/language_notifier.dart';
import 'package:eqqu/providers/favorites_provider.dart';
import 'package:eqqu/providers/cart_provider.dart';
import 'package:eqqu/providers/search_provider.dart';
import 'package:eqqu/screens/splash_screen.dart';
import 'package:eqqu/screens/registration_screen.dart';
import 'package:eqqu/screens/login_screen.dart';
import 'package:eqqu/screens/forgot_password_screen.dart';
import 'package:eqqu/screens/intro_screen.dart';
import 'package:eqqu/screens/home_screen.dart';

void main() {
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
        routes: {
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.intro: (context) => const IntroScreen(),
          AppRoutes.registration: (context) => const RegistrationScreen(),
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
          AppRoutes.home: (context) => const HomeScreen(),
        },
        ),
      ),
    );
  }
}
