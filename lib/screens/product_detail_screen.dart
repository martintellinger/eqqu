import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String brand;
  final String name;
  final String condition;
  final String price;
  final String oldPrice;

  const ProductDetailScreen({
    super.key,
    required this.brand,
    required this.name,
    required this.condition,
    required this.price,
    required this.oldPrice,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  final int _totalImages = 4;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Image header
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 391,
                        child: PageView.builder(
                          itemCount: _totalImages,
                          onPageChanged: (i) => setState(() => _currentImageIndex = i),
                          itemBuilder: (context, index) => Container(
                            color: cs.surfaceContainerLow,
                            child: Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 64,
                                color: cs.tertiary.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x66000000), Colors.transparent],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _circleButton(Icons.arrow_back, () => Navigator.pop(context)),
                                _circleButton(Icons.share_outlined, () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_totalImages, (i) {
                            return Container(
                              width: i == _currentImageIndex ? 24 : 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: i == _currentImageIndex ? 1.0 : 0.4),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // Product info
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.brand,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: cs.tertiary,
                            letterSpacing: 0.15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (widget.oldPrice.isNotEmpty)
                          Text(
                            widget.oldPrice,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: cs.tertiary,
                              letterSpacing: 0.15,
                            ),
                          ),
                        const SizedBox(height: 4),
                        // Price + protection
                        Row(
                          children: [
                            Text(
                              widget.price,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: cs.surfaceTint,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: cs.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified_user, size: 18, color: cs.surfaceTint),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Včetně ochrany kupujícího',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cs.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'Krásné bandáže v perfektním stavu, téměř nepoužité. Vhodné pro práci i soutěže. Barva šedá, univerzální velikost.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: cs.secondary.withValues(alpha: 0.8),
                            height: 1.5,
                            letterSpacing: 0.25,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Specs grid
                        _buildSpecsGrid(cs),

                        const SizedBox(height: 20),

                        // Seller card
                        _buildSellerCard(cs),

                        const SizedBox(height: 24),

                        // Featured banner
                        Container(
                          width: double.infinity,
                          height: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(color: cs.surfaceContainerLow),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.5, -0.3),
                                    end: Alignment(-0.5, 1.0),
                                    colors: [Colors.transparent, Color(0x80000000)],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'Lorem ipsum dolor sit amet, elit adipiscin',
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        height: 28 / 20,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // More from seller
                        Text(
                          'More from this seller',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (_, i) => Container(
                              width: 140,
                              decoration: BoxDecoration(
                                color: cs.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 32,
                                  color: cs.tertiary.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom bar with buttons
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              border: Border(
                top: BorderSide(color: cs.outline, width: 0.5),
              ),
            ),
            padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Buy',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cs.secondary,
                        side: BorderSide(color: cs.secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Offer',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Colors.black),
      ),
    );
  }

  Widget _buildSpecsGrid(ColorScheme cs) {
    final specs = [
      {'label': 'Condition', 'value': widget.condition},
      {'label': 'Size', 'value': 'One size'},
      {'label': 'Color', 'value': 'Gray'},
      {'label': 'Material', 'value': 'Cotton'},
    ];
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _specItem(cs, specs[0])),
            const SizedBox(width: 12),
            Expanded(child: _specItem(cs, specs[1])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _specItem(cs, specs[2])),
            const SizedBox(width: 12),
            Expanded(child: _specItem(cs, specs[3])),
          ],
        ),
      ],
    );
  }

  Widget _specItem(ColorScheme cs, Map<String, String> spec) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          spec['label']!,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.tertiary,
            letterSpacing: 0.25,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          spec['value']!,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: cs.secondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSellerCard(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFF006535),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'EN',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Emma Novak',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: cs.secondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: Color(0xFFFFD700))),
                            Icon(Icons.star_border, size: 20, color: cs.tertiary),
                            const SizedBox(width: 8),
                            Text(
                              '4.2',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: cs.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 20, color: cs.surfaceTint),
                          const SizedBox(width: 4),
                          Text(
                            'Message seller',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: cs.surfaceTint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
