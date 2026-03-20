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
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF545454), width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF070707),
        selectedItemColor: const Color(0xFF006535),
        unselectedItemColor: const Color(0xFF8C8C8C),
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
                        color: const Color(0xFF1C1B1B),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(Icons.search, color: Colors.white.withValues(alpha: 0.6), size: 24),
                          const SizedBox(width: 12),
                          Text(
                            'Hledat...',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: const Color(0xFF1C1B1B),
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => showFilterSheet(context),
                      child: Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        child: const Icon(Icons.tune, color: Colors.white, size: 24),
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
                  _buildChip('Cavalleria Toscana'),
                  const SizedBox(width: 8),
                  _buildChip('Animo'),
                  const SizedBox(width: 8),
                  _buildChip('Kingsland'),
                  const SizedBox(width: 8),
                  _buildChip('Kentucky'),
                  const SizedBox(width: 8),
                  _buildChip('Samshield'),
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
              child: const Text(
                'Featured',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
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

  static Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      backgroundColor: const Color(0xFF1C1B1B),
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
                  color: const Color(0xFF1C1B1B),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.2),
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
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.white,
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
              color: Colors.white.withValues(alpha: 0.6),
              letterSpacing: 0.4,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Name
          Text(
            product['name']!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Condition
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF85D89C)),
              const SizedBox(width: 4),
              Text(
                product['condition']!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF85D89C),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Price
          Row(
            children: [
              Text(
                product['price']!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (product['oldPrice']!.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(
                  product['oldPrice']!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.4),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
