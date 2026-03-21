import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/screens/chat_list_screen.dart';
import 'package:eqqu/screens/new_listing_screen.dart';
import 'package:eqqu/screens/favorites_screen.dart';
import 'package:eqqu/screens/profile_screen.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';
import 'package:eqqu/widgets/bottom_sheets.dart';

const _productImages = [
  'assets/images/product_01.png',
  'assets/images/product_02.png',
  'assets/images/product_03.png',
  'assets/images/product_04.png',
  'assets/images/product_05.png',
  'assets/images/product_06.png',
  'assets/images/product_07.png',
  'assets/images/product_8.png',
  'assets/images/product_9.png',
  'assets/images/product_10.png',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const _navItems = [
    {'svg': 'assets/menu/Home.svg', 'label': 'Domů'},
    {'svg': 'assets/menu/Chat.svg', 'label': 'Chat'},
    {'svg': 'assets/menu/Plus_symbol_button.svg', 'label': 'Prodat'},
    {'svg': 'assets/menu/Heart.svg', 'label': 'Oblíbené'},
    {'svg': 'assets/menu/User.svg', 'label': 'Profil'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const _HomeBody();
      case 1:
        return const ChatListScreen();
      case 3:
        return const FavoritesScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const _HomeBody();
    }
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
                  onTap: () {
                    if (i == 2) {
                      // Push NewListingScreen as a route so back button works
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NewListingScreen()),
                      );
                    } else {
                      setState(() => _currentIndex = i);
                    }
                  },
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
  Map<String, String> _activeFilters = {};

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
    {
      'title': 'Fleece bandáže Kentucky',
      'subtitle': 'Kentucky / New / One size',
      'oldPrice': '35 €',
      'newPrice': '42 €',
      'brand': 'Kingsland',
      'category': 'Kamaše',
    },
    {
      'title': 'Deka Eskadron Classic',
      'subtitle': 'Eskadron / Very Good / 145cm',
      'oldPrice': '95 €',
      'newPrice': '110 €',
      'brand': 'Animo',
      'category': 'Deky',
    },
    {
      'title': 'Třmeny Flex-On',
      'subtitle': 'Flex-On / Excellent / Standard',
      'oldPrice': '280 €',
      'newPrice': '320 €',
      'brand': 'Cavalleria Toscana',
      'category': 'Třmeny',
    },
    {
      'title': 'Podsedlová dečka Animo',
      'subtitle': 'Animo / New / Drezúra',
      'oldPrice': '55 €',
      'newPrice': '65 €',
      'brand': 'Animo',
      'category': 'Sedla',
    },
  ];

  static const _featuredProducts = [
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/images/product_01.png',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Shires / New / Cob',
      'oldPrice': '42 €',
      'newPrice': '49 €',
      'image': 'assets/images/product_02.png',
    },
  ];

  static const _chips = ['Cavalleria Toscana', 'Animo', 'Kingsland', 'Shires'];

  static const _users = [
    {
      'name': 'Emma Novak',
      'username': 'emma.novak',
      'avatar': 'assets/images/avatar_1.png',
      'rating': '4.2',
    },
    {
      'name': 'Anna K.',
      'username': 'anna.k',
      'avatar': 'assets/images/avatar_2.png',
      'rating': '4.8',
    },
    {
      'name': 'Markéta P.',
      'username': 'marketa.p',
      'avatar': 'assets/images/avatar_3.png',
      'rating': '3.9',
    },
    {
      'name': 'Jan Novotný',
      'username': 'jan.novotny',
      'avatar': 'assets/images/avatar_4.png',
      'rating': '4.5',
    },
    {
      'name': 'Petra S.',
      'username': 'petra.s',
      'avatar': 'assets/images/avatar_5.png',
      'rating': '4.1',
    },
  ];

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
    'Emma Novak',
    'Anna K.',
    'Jan Novotný',
  ];

  int _searchRelevance(Map<String, String> p, String q) {
    final title = p['title']!.toLowerCase();
    final brand = p['brand']!.toLowerCase();
    // Word-start match in title or brand = highest relevance
    if (title.startsWith(q) || brand.startsWith(q)) return 0;
    final titleWords = title.split(RegExp(r'\s+'));
    final brandWords = brand.split(RegExp(r'\s+'));
    if (titleWords.any((w) => w.startsWith(q)) || brandWords.any((w) => w.startsWith(q))) return 1;
    // Contains in title or brand
    if (title.contains(q) || brand.contains(q)) return 2;
    // Match in category
    if (p['category']!.toLowerCase().contains(q)) return 3;
    // Match in subtitle (least relevant)
    return 4;
  }

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
      products.sort((a, b) => _searchRelevance(a, q).compareTo(_searchRelevance(b, q)));
    }
    return products;
  }

  List<Map<String, String>> get _filteredUsers {
    if (!_isSearching && _searchQuery.isEmpty) return [];
    if (_searchQuery.isEmpty) return _users;
    final q = _searchQuery.toLowerCase();
    return _users.where((u) =>
      u['name']!.toLowerCase().contains(q) ||
      u['username']!.toLowerCase().contains(q)
    ).toList();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final products = _filteredProducts;

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
                              color: cs.surfaceContainerHigh,
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
                                  child: TextField(
                                    controller: _searchController,
                                    focusNode: _searchFocus,
                                    onChanged: (v) => setState(() {
                                      _searchQuery = v;
                                      if (!_isSearching) _isSearching = true;
                                    }),
                                    onSubmitted: _applySearch,
                                    onTap: () {
                                      if (!_isSearching) {
                                        setState(() => _isSearching = true);
                                      }
                                    },
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: cs.onSurface,
                                      letterSpacing: 0.5,
                                      height: 24 / 16,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Hledat',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: cs.onSurfaceVariant,
                                        letterSpacing: 0.5,
                                        height: 24 / 16,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                if (_searchQuery.isNotEmpty || _isSearching)
                                  GestureDetector(
                                    onTap: _closeSearch,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Icon(Icons.close, size: 20, color: cs.onSurfaceVariant),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ),
                      const SizedBox(width: 16),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Material(
                            color: cs.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final result = await showFilterSheet(context, currentFilters: _activeFilters);
                                if (result != null) {
                                  setState(() {
                                    _activeFilters = result;
                                    _activeChip = null;
                                  });
                                }
                              },
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.tune, color: cs.onSecondaryContainer, size: 24),
                              ),
                            ),
                          ),
                          if (_activeFilters.isNotEmpty)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: cs.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${_activeFilters.length}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Chips: active filters or brand quick-filters
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: _activeFilters.isNotEmpty
                      ? _activeFilters.entries.toList().asMap().entries.map((entry) {
                          final i = entry.key;
                          final filter = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(left: i > 0 ? 4 : 0),
                            child: _buildActiveFilterChip(cs, filter.key, filter.value),
                          );
                        }).toList()
                      : _chips.asMap().entries.map((entry) {
                          return Padding(
                            padding: EdgeInsets.only(left: entry.key > 0 ? 4 : 0),
                            child: _buildChip(cs, entry.value),
                          );
                        }).toList(),
                  ),
                ),
              ),

              // User results (show when typing in search, not when showing recent searches)
              if (_filteredUsers.isNotEmpty && _searchQuery.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Uživatelé',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                            height: 28 / 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._filteredUsers.map((user) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const BuyerViewSellerScreen()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: cs.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      user['avatar']!,
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
                                        _highlightedText(
                                          user['name']!,
                                          _searchQuery,
                                          TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: cs.secondary,
                                            letterSpacing: 0.1,
                                            height: 20 / 14,
                                          ),
                                          cs.surfaceTint,
                                        ),
                                        Text(
                                          '@${user['username']}',
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
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star, size: 16, color: Color(0xFFFFD700)),
                                      const SizedBox(width: 4),
                                      Text(
                                        user['rating']!,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: cs.tertiary,
                                          letterSpacing: 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        if (products.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Produkty',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: cs.onSurface,
                              height: 28 / 20,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

              // Product grid (pairs in rows for intrinsic height)
              // Hide when showing recent searches (search mode with empty query)
              if (products.isNotEmpty && !(_isSearching && _searchQuery.isEmpty))
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, rowIndex) {
                        final i = rowIndex * 2;
                        return Padding(
                          padding: EdgeInsets.only(bottom: rowIndex < (products.length / 2).ceil() - 1 ? 12 : 0),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildProductCard(
                                    cs, i, products[i], _productImages[i % _productImages.length],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (i + 1 < products.length)
                                  Expanded(
                                    child: _buildProductCard(
                                      cs, i + 1, products[i + 1], _productImages[(i + 1) % _productImages.length],
                                    ),
                                  )
                                else
                                  const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: (products.length / 2).ceil(),
                    ),
                  ),
                ),

              // Empty state (only show when actively searching with text)
              if (products.isEmpty && _filteredUsers.isEmpty && _searchQuery.isNotEmpty)
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

              // Featured heading (hide when in search mode)
              if (_searchQuery.isEmpty && _activeChip == null && !_isSearching) ...[
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
                      childAspectRatio: 0.62,
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

              // Search mode: recent searches section
              if (_isSearching && _searchQuery.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Poslední hledání',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                            height: 28 / 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._currentSuggestions.map((suggestion) {
                          final isUser = _users.any((u) =>
                            u['name'] == suggestion || u['username'] == suggestion);
                          return InkWell(
                            onTap: () {
                              _searchController.text = suggestion;
                              _applySearch(suggestion);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    isUser ? Icons.person_outline : Icons.history,
                                    size: 20,
                                    color: cs.tertiary,
                                  ),
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
                        }),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
    );
  }

  Widget _highlightedText(String text, String query, TextStyle baseStyle, Color highlightColor) {
    if (query.isEmpty) return Text(text, style: baseStyle, maxLines: 1, overflow: TextOverflow.ellipsis);
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerText.indexOf(lowerQuery);
    if (index < 0) return Text(text, style: baseStyle, maxLines: 1, overflow: TextOverflow.ellipsis);
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: baseStyle,
        children: [
          if (index > 0) TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: baseStyle.copyWith(color: highlightColor),
          ),
          if (index + query.length < text.length)
            TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }

  Widget _heartCircle(ColorScheme cs, bool isFav) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            shape: BoxShape.circle,
          ),
        ),
        SvgPicture.asset(
          isFav ? 'assets/icons/Heart.svg' : 'assets/icons/HeartEmpty.svg',
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            isFav ? cs.error : cs.onSecondaryContainer,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveFilterChip(ColorScheme cs, String label, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeFilters.remove(label);
        });
      },
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: cs.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$label: $value',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.1,
                  height: 20 / 12,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.close, size: 14, color: Colors.white.withValues(alpha: 0.8)),
            ],
          ),
        ),
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
          AspectRatio(
            aspectRatio: 177 / 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: double.infinity,
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
                        child: _heartCircle(cs, isFav),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Title (with search highlight)
          _highlightedText(
            product['title']!,
            _searchQuery,
            TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: cs.secondary,
              letterSpacing: 0.15,
              height: 24 / 16,
            ),
            cs.surfaceTint,
          ),
          // Subtitle (with search highlight)
          _highlightedText(
            product['subtitle']!,
            _searchQuery,
            TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cs.tertiary,
              letterSpacing: 0.25,
              height: 20 / 14,
            ),
            cs.surfaceTint,
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
          const Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
