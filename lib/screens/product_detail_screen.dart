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
                      // Image carousel
                      SizedBox(
                        height: 391,
                        child: PageView.builder(
                          itemCount: _totalImages,
                          onPageChanged: (i) => setState(() => _currentImageIndex = i),
                          itemBuilder: (context, index) => Container(
                            color: const Color(0xFF1C1B1B),
                            child: Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 64,
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Top gradient
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
                      // Back and share buttons
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
                      // Dots indicator
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
                        // Brand
                        Text(
                          widget.brand,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.6),
                            letterSpacing: 0.25,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Name
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Price
                        Row(
                          children: [
                            Text(
                              widget.price,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF85D89C),
                              ),
                            ),
                            if (widget.oldPrice.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Text(
                                widget.oldPrice,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.4),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Buyer protection
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF252B25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.verified_user, size: 20, color: Color(0xFF85D89C)),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'Buyer Protection included',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF85D89C),
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 20, color: Colors.white.withValues(alpha: 0.6)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Description
                        const Text(
                          'Popis',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Krásné bandáže v perfektním stavu, téměř nepoužité. Vhodné pro práci i soutěže. Barva šedá, univerzální velikost.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.5,
                            letterSpacing: 0.25,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Specs grid
                        _buildSpecsGrid(),

                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFF545454)),
                        const SizedBox(height: 20),

                        // Seller card
                        _buildSellerCard(),

                        const SizedBox(height: 24),

                        // Featured banner
                        Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFF006535),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Nová kolekce\nCavalleria Toscana',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  'Prohlédnout',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF006535),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // More from seller
                        const Text(
                          'More from this seller',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
                                color: const Color(0xFF1C1B1B),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 32,
                                  color: Colors.white.withValues(alpha: 0.2),
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
            decoration: const BoxDecoration(
              color: Color(0xFF070707),
              border: Border(
                top: BorderSide(color: Color(0xFF545454), width: 0.5),
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
                        backgroundColor: const Color(0xFF006535),
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
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
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

  Widget _buildSpecsGrid() {
    final specs = [
      {'label': 'Stav', 'value': widget.condition},
      {'label': 'Velikost', 'value': 'Univerzální'},
      {'label': 'Barva', 'value': 'Šedá'},
      {'label': 'Materiál', 'value': 'Fleece'},
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: specs.map((spec) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 44) / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                spec['label']!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.6),
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                spec['value']!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSellerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252B25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF006535),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'JN',
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
                    const Text(
                      'Jana Nováková',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Color(0xFFFFD700)),
                        const SizedBox(width: 4),
                        Text(
                          '4.2',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'Message seller',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF85D89C),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF85D89C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
