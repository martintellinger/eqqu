import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/theme/app_constants.dart';

class SellerCard extends StatelessWidget {
  final String name;
  final String avatarAsset;
  final int filledStars;
  final String ratingText;
  final String? messageCta;
  final VoidCallback? onTap;
  final VoidCallback? onMessageTap;

  const SellerCard({
    super.key,
    required this.name,
    required this.avatarAsset,
    this.filledStars = 4,
    this.ratingText = '4.2',
    this.messageCta,
    this.onTap,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                avatarAsset,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: AppTextStyles.labelMedium(cs.secondary)),
                      const SizedBox(width: 12),
                      ...List.generate(
                        filledStars,
                        (_) => const Icon(Icons.star, size: 20, color: AppConstants.starColor),
                      ),
                      ...List.generate(
                        5 - filledStars,
                        (_) => Icon(Icons.star_border, size: 20, color: cs.tertiary),
                      ),
                      const SizedBox(width: 8),
                      Text(ratingText, style: AppTextStyles.labelMedium(cs.tertiary)),
                    ],
                  ),
                  if (messageCta != null && onMessageTap != null)
                    GestureDetector(
                      onTap: onMessageTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chat_bubble_outline, size: 20, color: cs.surfaceTint),
                            const SizedBox(width: 4),
                            Text(messageCta!, style: AppTextStyles.actionLink(cs.surfaceTint)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
