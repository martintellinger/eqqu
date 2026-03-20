import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/widgets/bottom_sheets.dart';

const _productImages = [
  'assets/product_01.png',
  'assets/product_02.png',
  'assets/product_03.png',
  'assets/product_04.png',
  'assets/product_05.png',
  'assets/product_06.png',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const _navItems = [
    {'svg': 'assets/menu/Property 1=Home.svg', 'label': 'Domů'},
    {'svg': 'assets/menu/Property 1=Chat.svg', 'label': 'Chat'},
    {'svg': 'assets/menu/Property 1=Plus symbol button.svg', 'label': 'Prodat'},
    {'svg': 'assets/menu/Property 1=Heart.svg', 'label': 'Oblíbené'},
    {'svg': 'assets/menu/Property 1=User.svg', 'label': 'Profil'},
  ];

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
            children: List.generate(_navItems.length, (i) {
              final item = _navItems[i];
              final isActive = _currentIndex == i;
              final color = isActive ? cs.surfaceTint : cs.tertiary;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _currentIndex = i),
                  child: SizedBox(
                    height: 64,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          item['svg']!,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['label']!,
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
            }),
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
  String? _activeChip;
  String _searchQuery = '';
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  static const _allProducts = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'brand': 'No brand',
      'category': 'Sedla',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Comfy Brand / Fair / 18"',
      'oldPrice': '120 €',
      'newPrice': '135 €',
      'brand': 'Comfy Brand',
      'category': 'Sedla',
    },
    {
      'title': 'Red Racing type saddle',
      'subtitle': 'Speedy Brand / Excellent / 15"',
      'oldPrice': '200 €',
      'newPrice': '230 €',
      'brand': 'Cavalleria Toscana',
      'category': 'Sedla',
    },
    {
      'title': 'Green Mountain type saddle',
      'subtitle': 'Rugged Brand / Very Good / 16"',
      'oldPrice': '180 €',
      'newPrice': '199 €',
      'brand': 'Animo',
      'category': 'Sedla',
    },
    {
      'title': 'White Cruiser type saddle',
      'subtitle': 'Cruiser Co. / Fair / 19"',
      'oldPrice': '160 €',
      'newPrice': '175 €',
      'brand': 'Kingsland',
      'category': 'Sedla',
    },
    {
      'title': 'Shires Velociti bridle',
      'subtitle': 'Shires / New / Cob',
      'oldPrice': '42 €',
      'newPrice': '49 €',
      'brand': 'Shires',
      'category': 'Uzdečky',
    },
  ];

  static const _featuredProducts = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/product_01.png',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Shires / New / Cob',
      'oldPrice': '42 €',
      'newPrice': '49 €',
      'image': 'assets/product_02.png',
    },
  ];

  static const _chips = ['Cavalleria Toscana', 'Animo', 'Kingsland', 'Shires'];

  static const _searchSuggestions = [
    'Sedlo',
    'Uzdečka',
    'Deka',
    'Kamaše',
    'Třmeny',
    'Cavalleria Toscana',
    'Animo',
    'Kingsland',
    'Shires',
    'Black GP type saddle',
    'Blue Comfort type saddle',
    'Red Racing type saddle',
    'Shires Velociti bridle',
  ];

  List<Map<String, String>> get _filteredProducts {
    var products = _allProducts;
    if (_activeChip != null) {
      products = products.where((p) => p['brand'] == _activeChip).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      products = products.where((p) =>
        p['title']!.toLowerCase().contains(q) ||
        p['subtitle']!.toLowerCase().contains(q) ||
        p['brand']!.toLowerCase().contains(q) ||
        p['category']!.toLowerCase().contains(q)
      ).toList();
    }
    return products;
  }

  List<String> get _currentSuggestions {
    if (_searchQuery.isEmpty) return _searchSuggestions.take(5).toList();
    final q = _searchQuery.toLowerCase();
    return _searchSuggestions
        .where((s) => s.toLowerCase().contains(q))
        .take(5)
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onSearchTap() {
    setState(() => _isSearching = true);
    _searchFocus.requestFocus();
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
    _searchFocus.unfocus();
  }

  void _applySearch(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = false;
    });
    _searchFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final products = _filteredProducts;

    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Search bar + filter button
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _onSearchTap,
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
                                Expanded(
                                  child: _isSearching
                                    ? TextField(
                                        controller: _searchController,
                                        focusNode: _searchFocus,
                                        onChanged: (v) => setState(() => _searchQuery = v),
                                        onSubmitted: _applySearch,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: cs.onSurface,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Hledat',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: cs.onSurfaceVariant,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                        ),
                                      )
                                    : Text(
                                        _searchQuery.isEmpty ? 'Hledat' : _searchQuery,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: _searchQuery.isEmpty ? cs.onSurfaceVariant : cs.onSurface,
                                          letterSpacing: 0.5,
                                          height: 24 / 16,
                                        ),
                                      ),
                                ),
                                if (_searchQuery.isNotEmpty || _isSearching)
                                  GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      setState(() {
                                        _searchQuery = '';
                                        if (!_isSearching) return;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Icon(Icons.close, size: 20, color: cs.onSurfaceVariant),
                                    ),
                                  ),
                              ],
                            ),
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
              if (products.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.62,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final imgIndex = index % _productImages.length;
                        return _buildProductCard(
                          cs, index, products[index], _productImages[imgIndex],
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),

              // Empty state
              if (products.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Center(
                      child: Text(
                        'Žádné výsledky',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: cs.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),

              // Featured heading
              if (_searchQuery.isEmpty && _activeChip == null) ...[
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
                          return _buildFeaturedCard(_productImages[index]);
                        }
                        final pIndex = index - 2;
                        final fp = _featuredProducts[pIndex];
                        return _buildProductCard(
                          cs, 100 + pIndex, fp, fp['image']!,
                        );
                      },
                      childCount: 4,
                    ),
                  ),
                ),
              ],

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),

          // Search suggestions overlay
          if (_isSearching)
            Positioned(
              top: 80,
              left: 16,
              right: 72,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                color: cs.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _currentSuggestions.map((suggestion) {
                    return InkWell(
                      onTap: () {
                        _searchController.text = suggestion;
                        _applySearch(suggestion);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 20, color: cs.tertiary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                suggestion,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: cs.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChip(ColorScheme cs, String label) {
    final isActive = _activeChip == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeChip = isActive ? null : label;
        });
      },
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? cs.primary : Colors.transparent,
          border: Border.all(color: isActive ? cs.primary : cs.outlineVariant),
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
              color: isActive ? Colors.white : cs.onSurfaceVariant,
              letterSpacing: 0.1,
              height: 20 / 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ColorScheme cs, int index, Map<String, String> product, String imagePath) {
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
              imageAsset: imagePath,
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
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
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
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            isFav ? 'assets/icons/Heart.svg' : 'assets/icons/HeartEmpty.svg',
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              isFav ? Colors.red : cs.onSecondaryContainer,
                              BlendMode.srcIn,
                            ),
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

  Widget _buildFeaturedCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          // Black gradient for text readability
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.transparent,
                  ],
                ),
              ),
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
