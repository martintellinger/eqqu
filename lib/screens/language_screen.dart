import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/main.dart';
import 'package:eqqu/utils/language_notifier.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = languageNotifier.selectedCode;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Jazyk', showBack: true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jazyk aplikace',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: cs.secondary,
                      height: 28 / 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...LanguageNotifier.languages.map((lang) {
                    final isSelected = lang.code == _selectedCode;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildLanguageOption(cs, lang, isSelected),
                    );
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).padding.bottom + 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: _selectedCode != languageNotifier.selectedCode
                    ? () {
                        languageNotifier.setLanguage(_selectedCode);
                        Navigator.pop(context);
                      }
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.1),
                  disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Uložit',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(ColorScheme cs, Language lang, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCode = lang.code),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? cs.surfaceTint : cs.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? cs.surfaceTint : cs.outlineVariant,
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              lang.flag,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 12),
            Text(
              lang.name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? cs.surfaceTint : cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
