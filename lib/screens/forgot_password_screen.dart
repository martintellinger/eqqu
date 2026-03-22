import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/theme/app_text_styles.dart';

/// Handles all forgot password states from Figma:
/// - Empty (Zapomenuté heslo)
/// - Typing (Zapomenuté heslo - píšu)
/// - Error (Zapomenuté heslo - error)
/// - Valid (Zapomenuté heslo - valid)
/// - Sent (Zapomenuté heslo - odesláno)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

enum _ForgotPasswordState { input, sent }

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _screenState = _ForgotPasswordState.input;
  var _hasSubmitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool get _isEmailValid {
    final email = _emailController.text.trim();
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  bool get _isEmailEmpty => _emailController.text.trim().isEmpty;

  void _submit() {
    setState(() => _hasSubmitted = true);

    if (_isEmailValid) {
      setState(() => _screenState = _ForgotPasswordState.sent);
    }
  }

  void _resend() {
    // Re-send the email
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('E-mail byl znovu odeslán')),
    );
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
        title: Text(s.forgotPassword),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      body: SafeArea(
        child: _screenState == _ForgotPasswordState.input
            ? _buildInputState()
            : _buildSentState(),
      ),
    );
  }

  Widget _buildInputState() {
    final s = AppStrings.of(context);
    final showError = _hasSubmitted && !_isEmailValid && !_isEmailEmpty;

    return Column(
      children: [
        // Content section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: AppTextStyles.bodyLarge(Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: s.email,
                      errorText: showError ? 'Neplatný e-mail' : null,
                      suffixIcon: showError
                          ? Icon(Icons.error, color: Theme.of(context).colorScheme.error)
                          : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Submit button
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _isEmailEmpty ? null : _submit,
            style: FilledButton.styleFrom(
              backgroundColor: _isEmailEmpty
                  ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)
                  : Theme.of(context).colorScheme.primary,
              foregroundColor:
                  _isEmailEmpty ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38) : Colors.white,
            ),
            child: Text(
              s.sendResetLink,
              style: AppTextStyles.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.15,
              ),
            ),
          ),
        ),

        // Bottom navigation
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    s.rememberPassword,
                    style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.secondary),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  child: Text(
                    s.login,
                    style: AppTextStyles.actionLink(Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSentState() {
    return Column(
      children: [
        // Success message
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Odeslali jsme odkaz pro resetování hesla na zadanou e-mailovou adresu.',
                  style: AppTextStyles.bodyLarge(Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // Back to login button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zpět na přihlášení'),
          ),
        ),

        // Resend section
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    'Nedorazil mail?',
                    style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.secondary),
                  ),
                ),
                TextButton(
                  onPressed: _resend,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  child: Text(
                    'Poslat znova',
                    style: AppTextStyles.actionLink(Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
