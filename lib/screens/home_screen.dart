import 'package:flutter/material.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/widgets/bottom_sheets.dart';

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
        border: Border(
          top: BorderSide(color: cs.outline, width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: cs.surface,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.tertiary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Domů',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Prodat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Oblíbené',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(Icons.search, color: cs.tertiary, size: 24),
                          const SizedBox(width: 12),
                          Text(
                            'Hledat...',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: cs.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => showFilterSheet(context),
                      child: Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        child: Icon(Icons.tune, color: cs.onSurface, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Suggestion chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _buildChip(context, 'Cavalleria Toscana'),
                  const SizedBox(width: 8),
                  _buildChip(context, 'Animo'),
                  const SizedBox(width: 8),
                  _buildChip(context, 'Kingsland'),
                  const SizedBox(width: 8),
                  _buildChip(context, 'Kentucky'),
                  const SizedBox(width: 8),
                  _buildChip(context, 'Samshield'),
                ],
              ),
            ),
          ),

          // Product grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _ProductCard(index: index),
                childCount: 6,
              ),
            ),
          ),

          // Featured section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFeaturedCard('Nová kolekce\nCavalleria Toscana'),
                  const SizedBox(width: 12),
                  _buildFeaturedCard('Zimní výprodej\nKentucky'),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  static Widget _buildChip(BuildContext context, String label) {
    final cs = Theme.of(context).colorScheme;
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: cs.onSurface,
      ),
      backgroundColor: cs.surfaceContainerLow,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  static Widget _buildFeaturedCard(String title) {
    return Container(
      width: 300,
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF006535),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            bottom: 16,
            child: Opacity(
              opacity: 0.15,
              child: Text(
                'EQQU',
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 64,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Prohlédnout',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF006535),
                    ),
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

class _ProductCard extends StatelessWidget {
  final int index;
  const _ProductCard({required this.index});

  static const _products = [
    {'brand': 'Kentucky', 'name': 'Gray bandages', 'condition': 'Nové', 'price': '10 €', 'oldPrice': '8.50 €'},
    {'brand': 'Cavalleria Toscana', 'name': 'Competition Polo', 'condition': 'Použité', 'price': '45 €', 'oldPrice': ''},
    {'brand': 'Animo', 'name': 'Riding Breeches', 'condition': 'Nové', 'price': '89 €', 'oldPrice': '120 €'},
    {'brand': 'Kingsland', 'name': 'Classic Helmet', 'condition': 'Použité', 'price': '150 €', 'oldPrice': ''},
    {'brand': 'Samshield', 'name': 'Shadowmatt', 'condition': 'Nové', 'price': '450 €', 'oldPrice': '500 €'},
    {'brand': 'Kentucky', 'name': 'Saddle Pad', 'condition': 'Nové', 'price': '65 €', 'oldPrice': ''},
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final product = _products[index % _products.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              brand: product['brand']!,
              name: product['name']!,
              condition: product['condition']!,
              price: product['price']!,
              oldPrice: product['oldPrice']!,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image placeholder
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: cs.tertiary.withValues(alpha: 0.3),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: cs.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Brand
          Text(
            product['brand']!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: cs.tertiary,
              letterSpacing: 0.4,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Name
          Text(
            product['name']!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.secondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Condition
          Row(
            children: [
              Icon(Icons.verified_user_outlined, size: 14, color: cs.surfaceTint),
              const SizedBox(width: 4),
              Text(
                product['condition']!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: cs.surfaceTint,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Price
          Row(
            children: [
              if (product['oldPrice']!.isNotEmpty) ...[
                Text(
                  product['oldPrice']!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: cs.tertiary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                product['price']!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
