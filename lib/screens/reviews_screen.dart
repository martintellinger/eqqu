import 'package:flutter/material.dart';
import 'package:eqqu/data/mock_conversations.dart';
import 'package:eqqu/models/review.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  static const _reviews = MockConversations.reviews;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: AppStrings.of(context).reviews, showBack: true),
          ),
          // Summary header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '4.2',
                  style: AppTextStyles.outfit(fontSize: 32, fontWeight: FontWeight.w500, color: cs.secondary, height: 40 / 32),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ...List.generate(
                          4,
                          (_) => const Icon(Icons.star,
                              size: 20, color: Color(0xFFFFD700)),
                        ),
                        Icon(Icons.star_border,
                            size: 20, color: cs.tertiary),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '12 hodnocení',
                      style: AppTextStyles.labelSmall(cs.tertiary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: cs.outlineVariant),
          // Reviews list
          Expanded(
            child: ListView.separated(
              addAutomaticKeepAlives: false,
              padding: const EdgeInsets.all(16),
              itemCount: _reviews.length,
              separatorBuilder: (_, __) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                    height: 1, thickness: 1, color: cs.outlineVariant),
              ),
              itemBuilder: (context, index) {
                return _buildReviewCard(context, cs, _reviews[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, ColorScheme cs, Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar + name + country row
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuyerViewSellerScreen()),
            );
          },
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  review.avatar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: AppTextStyles.actionLink(cs.secondary),
                    ),
                    Text(
                      review.country,
                      style: AppTextStyles.labelSmall(cs.tertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Stars + time
        Row(
          children: [
            ...List.generate(
              5,
              (i) => Icon(
                i < review.rating ? Icons.star : Icons.star_border,
                size: 16,
                color: i < review.rating
                    ? const Color(0xFFFFD700)
                    : cs.tertiary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              review.time,
              style: AppTextStyles.labelSmall(cs.tertiary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Review text
        Text(
          review.text,
          style: AppTextStyles.bodyMedium(cs.secondary),
        ),
      ],
    );
  }
}
