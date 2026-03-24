import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class FeaturedBanner extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const FeaturedBanner({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 370 / 240,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imageAsset, fit: BoxFit.cover),
              // Gradient overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.5, -0.3),
                    end: Alignment(-0.5, 1.0),
                    colors: [Colors.transparent, Color(0x80000000)],
                  ),
                ),
              ),
              // EQQU logo top-left
              Positioned(
                left: 16,
                top: 16,
                child: Text(
                  'EQQU',
                  style: AppTextStyles.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              // Content bottom-left
              Positioned(
                left: 16,
                right: 64,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: AppTextStyles.sectionTitle(Colors.white)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.bodyMedium(Colors.white)),
                  ],
                ),
              ),
              // Arrow button bottom-right
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 24,
                    color: cs.onSecondaryContainer,
                    semanticLabel: 'View details',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
