import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_theme.dart';
import 'package:eqqu/screens/splash_screen.dart';
import 'package:eqqu/screens/registration_screen.dart';
import 'package:eqqu/screens/login_screen.dart';
import 'package:eqqu/screens/forgot_password_screen.dart';
import 'package:eqqu/screens/intro_screen.dart';

void main() {
  runApp(const EqquApp());
}

class EqquApp extends StatelessWidget {
  const EqquApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EQQU',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/intro': (context) => const IntroScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
