import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/services/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hasSubmitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() => _hasSubmitted = true);

    if (_formKey.currentState!.validate()) {
      final s = AppStrings.of(context);
      AppSnackBar.show(context, message: s.loginSuccessful);
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(s.login),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Form fields centered vertically
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _hasSubmitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: s.email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: s.password,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return s.enterPassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.forgotPassword);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          child: Text(
                            s.forgotPassword,
                            style: AppTextStyles.actionLink(Theme.of(context).colorScheme.secondary).copyWith(height: null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Buttons section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FilledButton(
                    onPressed: _login,
                    child: Text(s.login),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                      },
                      child: Text(
                        s.continueWithoutLogin,
                        style: AppTextStyles.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom registration prompt
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        s.noAccountYet,
                        style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.registration);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      child: Text(
                        s.createAccount,
                        style: AppTextStyles.actionLink(Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
