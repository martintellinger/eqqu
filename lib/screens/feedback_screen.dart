import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/utils/app_snack_bar.dart';
import 'package:eqqu/widgets/app_header.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _messageController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      setState(() => _errorText = 'Zadejte zprávu');
      return;
    }

    setState(() => _errorText = null);

    AppSnackBar.show(context, message: 'Zpětná vazba byla odeslána');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.feedback, showBack: true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                    style: AppTextStyles.bodyLarge(cs.secondary),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 140,
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (_) {
                        if (_errorText != null) setState(() => _errorText = null);
                      },
                      style: AppTextStyles.bodyLarge(cs.onSurface),
                      decoration: InputDecoration(
                        labelText: 'Zpráva',
                        errorText: _errorText,
                        labelStyle: AppTextStyles.labelSmall(cs.onSurfaceVariant),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: cs.outline),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: cs.outline),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: cs.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: cs.error, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: cs.error, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating button at bottom
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Odeslat',
                    style: AppTextStyles.productTitle(Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
