import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_theme.dart';
import 'package:eqqu/theme/theme_notifier.dart';
import 'package:eqqu/screens/splash_screen.dart';
import 'package:eqqu/screens/registration_screen.dart';
import 'package:eqqu/screens/login_screen.dart';
import 'package:eqqu/screens/forgot_password_screen.dart';
import 'package:eqqu/screens/intro_screen.dart';
import 'package:eqqu/screens/home_screen.dart';

final themeNotifier = ThemeNotifier();

void main() {
  runApp(const EqquApp());
}

class EqquApp extends StatefulWidget {
  const EqquApp({super.key});

  @override
  State<EqquApp> createState() => _EqquAppState();
}

class _EqquAppState extends State<EqquApp> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EQQU',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/intro': (context) => const IntroScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
