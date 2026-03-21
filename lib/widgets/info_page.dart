import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

/// Shared layout for informational pages (Jak funguje, Nápověda, O nás, EQQU platforma).
/// AppHeader + headline + body paragraphs + image, all scrollable.
class InfoPage extends StatelessWidget {
  final String title;
  final String headline;
  final List<String> paragraphs;
  final String imagePath;

  const InfoPage({
    super.key,
    required this.title,
    required this.headline,
    required this.paragraphs,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: title, showBack: true),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: cs.secondary,
                      height: 32 / 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (int i = 0; i < paragraphs.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    Text(
                      paragraphs[i],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: cs.secondary,
                        letterSpacing: 0.5,
                        height: 24 / 16,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
