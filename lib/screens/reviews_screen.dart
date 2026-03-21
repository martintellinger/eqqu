import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  static const _reviews = [
    {
      'name': 'Anna K.',
      'avatar': 'assets/images/avatar_2.png',
      'country': 'Česká republika',
      'rating': 5,
      'time': 'před 2 dny',
      'text':
          'Skvělá komunikace a rychlé odeslání. Sedlo odpovídá popisu, jsem velmi spokojená!',
    },
    {
      'name': 'Markéta P.',
      'avatar': 'assets/images/avatar_3.png',
      'country': 'Slovensko',
      'rating': 4,
      'time': 'před 5 dny',
      'text':
          'Vše v pořádku, jen doručení trvalo trochu déle. Jinak super prodejce.',
    },
    {
      'name': 'Jan N.',
      'avatar': 'assets/images/avatar_4.png',
      'country': 'Česká republika',
      'rating': 5,
      'time': 'před 1 týdnem',
      'text':
          'Výborná kvalita, přesně jak bylo popsáno. Doporučuji!',
    },
    {
      'name': 'Petra S.',
      'avatar': 'assets/images/avatar_5.png',
      'country': 'Česká republika',
      'rating': 3,
      'time': 'před 2 týdny',
      'text':
          'Produkt ok, ale komunikace mohla být lepší. Odpovědi přicházely se zpožděním.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Hodnocení', showBack: true),
          ),
          // Summary header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '4.2',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: cs.secondary,
                    height: 40 / 32,
                  ),
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
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: cs.tertiary,
                        letterSpacing: 0.4,
                        height: 16 / 12,
                      ),
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

  Widget _buildReviewCard(BuildContext context, ColorScheme cs, Map<String, dynamic> review) {
    final rating = review['rating'] as int;

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
                  review['avatar'] as String,
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
                      review['name'] as String,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.secondary,
                        letterSpacing: 0.1,
                        height: 20 / 14,
                      ),
                    ),
                    Text(
                      review['country'] as String,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: cs.tertiary,
                        letterSpacing: 0.4,
                        height: 16 / 12,
                      ),
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
                i < rating ? Icons.star : Icons.star_border,
                size: 16,
                color: i < rating
                    ? const Color(0xFFFFD700)
                    : cs.tertiary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              review['time'] as String,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: cs.tertiary,
                letterSpacing: 0.4,
                height: 16 / 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Review text
        Text(
          review['text'] as String,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.secondary,
            letterSpacing: 0.25,
            height: 20 / 14,
          ),
        ),
      ],
    );
  }
}
