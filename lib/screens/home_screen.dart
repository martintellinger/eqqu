import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/screens/chat_list_screen.dart';
import 'package:eqqu/screens/new_listing_screen.dart';
import 'package:eqqu/screens/favorites_screen.dart';
import 'package:eqqu/screens/profile_screen.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';
import 'package:eqqu/widgets/bottom_sheets.dart';
import 'package:eqqu/widgets/product_card.dart';
import 'package:eqqu/widgets/tap_scale_widget.dart';
import 'package:eqqu/theme/app_constants.dart';
import 'package:eqqu/data/mock_products.dart';
import 'package:eqqu/services/search_service.dart';
import 'package:provider/provider.dart';
import 'package:eqqu/providers/favorites_provider.dart';
import 'package:eqqu/l10n/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const _navSvgs = [
    'assets/menu/Home.svg',
    'assets/menu/Chat.svg',
    'assets/menu/Plus_symbol_button.svg',
    'assets/menu/Heart.svg',
    'assets/menu/User.svg',
  ];

  List<String> _navLabels(AppStrings s) => [
    s.home, s.chat, s.sell, s.favorites, s.profile,
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
        return const FavoritesScreen(showBack: false);
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
            children: List.generate(_navSvgs.length, (i) {
              final labels = _navLabels(AppStrings.of(context));
              final isActive = _currentIndex == i;
              final color = isActive ? cs.surfaceTint : cs.tertiary;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (i == 2) {
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
                        AnimatedScale(
                          scale: isActive ? 1.15 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutBack,
                          child: SvgPicture.asset(
                            _navSvgs[i],
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTextStyles.navLabel(color: color, isActive: isActive),
                          child: Text(labels[i]),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          width: isActive ? 24 : 0,
                          height: 3,
                          decoration: BoxDecoration(
                            color: isActive ? cs.surfaceTint : Colors.transparent,
                            borderRadius: BorderRadius.circular(1.5),
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

class _HomeBodyState extends State<_HomeBody> with TickerProviderStateMixin {
  String? _activeChip;
  String _searchQuery = '';
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  Map<String, String> _activeFilters = {};
  late AnimationController _staggerController;
  final Map<int, Animation<double>> _staggerAnimations = {};

  void _initStaggerAnimations(int count) {
    _staggerController = AnimationController(
      duration: Duration(milliseconds: 300 + count * 80),
      vsync: this,
    );
    for (int i = 0; i < count; i++) {
      final start = (i * 0.1).clamp(0.0, 0.7);
      final end = (start + 0.4).clamp(0.0, 1.0);
      _staggerAnimations[i] = CurvedAnimation(
        parent: _staggerController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    }
    _staggerController.forward();
  }

  static const _allProducts = MockProducts.allProducts;

  static const _featuredProducts = [
    Product(title: 'Black GP type saddle', subtitle: 'No brand / Good / 17"', oldPrice: '140 €', newPrice: '159 €', imageAsset: 'assets/images/product_01.png'),
    Product(title: 'Blue Comfort type saddle', subtitle: 'Shires / New / Cob', oldPrice: '42 €', newPrice: '49 €', imageAsset: 'assets/images/product_02.png'),
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

  List<Product> get _filteredProducts => SearchService.filterProducts(
        _allProducts,
        brandChip: _activeChip,
        query: _searchQuery,
      );

  List<Map<String, String>> get _filteredUsers =>
      SearchService.filterUsers(_users, _searchQuery, isSearching: _isSearching);

  List<String> get _currentSuggestions =>
      SearchService.filterSuggestions(_searchSuggestions, _searchQuery);

  @override
  void initState() {
    super.initState();
    _initStaggerAnimations(10);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _staggerController.dispose();
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
                                    style: AppTextStyles.bodyLarge(cs.onSurface),
                                    decoration: InputDecoration(
                                      hintText: 'Hledat',
                                      hintStyle: AppTextStyles.bodyLarge(cs.onSurfaceVariant),
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
                                    style: AppTextStyles.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onPrimary,
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
                          style: AppTextStyles.sectionTitle(cs.onSurface),
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
                                          AppTextStyles.actionLink(cs.secondary),
                                          cs.surfaceTint,
                                        ),
                                        Text(
                                          '@${user['username']}',
                                          style: AppTextStyles.labelSmall(cs.tertiary),
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
                                        style: AppTextStyles.chip(cs.tertiary),
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
                            style: AppTextStyles.sectionTitle(cs.onSurface),
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
                                    cs, i, products[i], kProductImages[i % kProductImages.length],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (i + 1 < products.length)
                                  Expanded(
                                    child: _buildProductCard(
                                      cs, i + 1, products[i + 1], kProductImages[(i + 1) % kProductImages.length],
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
                        style: AppTextStyles.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
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
                      style: AppTextStyles.outfit(
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
                          return _buildFeaturedCard(kProductImages[index]);
                        }
                        final pIndex = index - 2;
                        final fp = _featuredProducts[pIndex];
                        return _buildProductCard(
                          cs, 100 + pIndex, fp, fp.imageAsset,
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
                          style: AppTextStyles.sectionTitle(cs.onSurface),
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
                                      style: AppTextStyles.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
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
                style: AppTextStyles.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: cs.onPrimary,
                  letterSpacing: 0.1,
                  height: 20 / 12,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.close, size: 14, color: cs.onPrimary.withValues(alpha: 0.8)),
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
            style: AppTextStyles.chip(isActive ? cs.onPrimary : cs.onSurfaceVariant),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ColorScheme cs, int index, Product product, String imagePath, {bool? isFav}) {
    final favProvider = context.read<FavoritesProvider>();
    isFav ??= context.select<FavoritesProvider, bool>((p) => p.isFavorite(index));
    final heroTag = 'product_image_${imagePath}_$index';

    Widget card = TapScaleWidget(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => ProductDetailScreen(
              brand: product.parsedBrand,
              name: product.title,
              condition: AppStrings.of(context).used,
              price: product.newPrice,
              oldPrice: product.oldPrice,
              imageAsset: imagePath,
              heroTag: heroTag,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: ProductCard(
        product: product,
        imageAsset: imagePath,
        isFavorite: isFav,
        heroTag: heroTag,
        onFavoriteToggle: () => favProvider.toggle(index),
        // onTap handled by TapScaleWidget
        titleBuilder: _searchQuery.isNotEmpty
            ? (text, style) => _highlightedText(text, _searchQuery, style, cs.surfaceTint)
            : null,
        subtitleBuilder: _searchQuery.isNotEmpty
            ? (text, style) => _highlightedText(text, _searchQuery, style, cs.surfaceTint)
            : null,
      ),
    );

    // Apply stagger animation if available
    final anim = _staggerAnimations[index.clamp(0, 9)];
    if (anim != null) {
      card = AnimatedBuilder(
        animation: anim,
        builder: (context, child) => Opacity(
          opacity: anim.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - anim.value)),
            child: child,
          ),
        ),
        child: card,
      );
    }

    return card;
  }

  Widget _buildFeaturedCard(String imagePath) {
    return TapScaleWidget(
      onTap: () {},
      child: ClipRRect(
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
              children: [
                Text(
                  'EQQU',
                  style: AppTextStyles.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lorem ipsum',
                  style: AppTextStyles.productBadge(Colors.white),
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

