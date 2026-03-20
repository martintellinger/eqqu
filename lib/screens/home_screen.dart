import 'package:flutter/material.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/widgets/bottom_sheets.dart';

// Figma asset URLs (valid for 7 days from export)
const _productImages = [
  'https://www.figma.com/api/mcp/asset/7f36f390-311b-48ef-8b85-385080d7b047',
  'https://www.figma.com/api/mcp/asset/57b7072a-caa9-4f5a-b20f-8f6481ab9c1e',
  'https://www.figma.com/api/mcp/asset/722e5f69-4e57-4a0d-80e5-adbd9704ce09',
  'https://www.figma.com/api/mcp/asset/ff5f8c04-3e0d-4356-ac18-ec773436a0c8',
  'https://www.figma.com/api/mcp/asset/db14c726-b9a2-4f36-875b-4ede45c0b8ce',
  'https://www.figma.com/api/mcp/asset/32b0435d-93b3-402a-9fb0-ab41fc36a7a7',
];

const _featuredImages = [
  'https://www.figma.com/api/mcp/asset/9aac7644-f8b5-4742-8add-17645af1a355',
  'https://www.figma.com/api/mcp/asset/a27d0d7f-2da7-47dc-88f6-2aea851a8ac2',
];

const _featuredProductImages = [
  'https://www.figma.com/api/mcp/asset/0e106366-459b-497a-85b8-9fe1c4c48112',
  'https://www.figma.com/api/mcp/asset/ea9c0688-f2c7-4d09-a063-99521c69fff6',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? const _HomeBody() : _buildPlaceholder(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildPlaceholder() {
    final labels = ['Domů', 'Chat', 'Prodat', 'Oblíbené', 'Profil'];
    return Center(
      child: Text(
        labels[_currentIndex],
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          top: BorderSide(color: cs.outline, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              _navItem(cs, 0, Icons.home_outlined, Icons.home, 'Domů'),
              _navItem(cs, 1, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
              _navItem(cs, 2, Icons.add_circle_outline, Icons.add_circle, 'Prodat'),
              _navItem(cs, 3, Icons.favorite_border, Icons.favorite, 'Oblíbené'),
              _navItem(cs, 4, Icons.person_outline, Icons.person, 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(ColorScheme cs, int index, IconData icon, IconData activeIcon, String label) {
    final isActive = _currentIndex == index;
    final color = isActive ? cs.surfaceTint : cs.tertiary;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _currentIndex = index),
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isActive ? activeIcon : icon, size: 24, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                  letterSpacing: 0.5,
                  height: 16 / 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  final Set<int> _favorites = {};

  static const _products = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Comfy Brand / Fair / 18"',
      'oldPrice': '120 €',
      'newPrice': '135 €',
    },
    {
      'title': 'Red Racing type saddle',
      'subtitle': 'Speedy Brand / Excellent / 15"',
      'oldPrice': '200 €',
      'newPrice': '230 €',
    },
    {
      'title': 'Green Mountain type saddle',
      'subtitle': 'Rugged Brand / Very Good / 16"',
      'oldPrice': '180 €',
      'newPrice': '199 €',
    },
    {
      'title': 'White Cruiser type saddle',
      'subtitle': 'Cruiser Co. / Fair / 19"',
      'oldPrice': '160 €',
      'newPrice': '175 €',
    },
    {
      'title': 'Shires Velociti bridle',
      'subtitle': 'Shires / New / Cob',
      'oldPrice': '42 €',
      'newPrice': '49 €',
    },
  ];

  static const _featuredProducts = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Shires / New / Cob',
      'oldPrice': '42 €',
      'newPrice': '49 €',
    },
  ];

  static const _chips = ['Cavalleria Toscana', 'Animo', 'Kingsland', 'Kingsland'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Search bar + filter button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: Icon(Icons.search, color: cs.onSurfaceVariant, size: 24),
                          ),
                          Text(
                            'Hledat',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: cs.onSurfaceVariant,
                              letterSpacing: 0.5,
                              height: 24 / 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Material(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => showFilterSheet(context),
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.tune, color: cs.onSecondaryContainer, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Suggestion chips
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: _chips.asMap().entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(left: entry.key > 0 ? 4 : 0),
                    child: _buildChip(cs, entry.value),
                  );
                }).toList(),
              ),
            ),
          ),

          // Product grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.58,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildProductCard(cs, index, _products[index], _productImages[index]),
                childCount: _products.length,
              ),
            ),
          ),

          // Featured heading
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                  height: 32 / 24,
                ),
              ),
            ),
          ),

          // Featured cards + products
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < 2) {
                    return _buildFeaturedCard(_featuredImages[index]);
                  }
                  final pIndex = index - 2;
                  return _buildProductCard(
                    cs,
                    100 + pIndex,
                    _featuredProducts[pIndex],
                    _featuredProductImages[pIndex],
                  );
                },
                childCount: 4,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildChip(ColorScheme cs, String label) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.1,
            height: 20 / 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ColorScheme cs, int index, Map<String, String> product, String imageUrl) {
    final isFav = _favorites.contains(index);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              brand: product['subtitle']!.split(' / ').first,
              name: product['title']!,
              condition: 'Used',
              price: product['newPrice']!,
              oldPrice: product['oldPrice']!,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image with heart
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(Icons.image_outlined, size: 48, color: cs.tertiary.withValues(alpha: 0.3)),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      if (isFav) {
                        _favorites.remove(index);
                      } else {
                        _favorites.add(index);
                      }
                    }),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: cs.secondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: isFav ? Colors.red : cs.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            product['title']!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: cs.secondary,
              letterSpacing: 0.15,
              height: 24 / 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Subtitle
          Text(
            product['subtitle']!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cs.tertiary,
              letterSpacing: 0.25,
              height: 20 / 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          // Price row
          Row(
            children: [
              Text(
                '${product['oldPrice']}  ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: cs.tertiary,
                  letterSpacing: 0.4,
                  height: 16 / 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${product['newPrice']}  ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                  letterSpacing: 0.5,
                  height: 24 / 16,
                ),
              ),
              Text(
                'vč.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.verified_user, size: 16, color: cs.surfaceTint),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFF006535),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'EQQU',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Lorem ipsum',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.25,
                    height: 20 / 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
