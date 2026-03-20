import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Zapomenuté heslo'),
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
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    height: 24 / 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      errorText: showError ? 'Neplatný e-mail' : null,
                      suffixIcon: showError
                          ? const Icon(Icons.error, color: Color(0xFFFFB4A8))
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
                  ? Colors.white.withValues(alpha: 0.1)
                  : const Color(0xFF006535),
              foregroundColor:
                  _isEmailEmpty ? Colors.white.withValues(alpha: 0.38) : Colors.white,
            ),
            child: const Text(
              'Odeslat',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
                    'Pamatujete si heslo?',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 0.25,
                    ),
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
                  child: const Text(
                    'Zpět na přihlášení',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.1,
                    ),
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
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    height: 24 / 16,
                  ),
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
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 0.25,
                    ),
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
                  child: const Text(
                    'Poslat znova',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.1,
                    ),
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
