import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/screens/reviews_screen.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/utils/blur_overlay.dart';

class BuyerViewSellerScreen extends StatefulWidget {
  const BuyerViewSellerScreen({super.key});

  @override
  State<BuyerViewSellerScreen> createState() => _BuyerViewSellerScreenState();
}

class _BuyerViewSellerScreenState extends State<BuyerViewSellerScreen> {
  final Set<int> _favorites = {};
  bool _isFollowing = false;

  static const _products = [
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
    {
      'title': 'Black GP type saddle',
      'subtitle': 'No brand / Good / 17"',
      'oldPrice': '140 €',
      'newPrice': '159 €',
      'image': 'assets/images/product_03.png',
    },
    {
      'title': 'Blue Comfort type saddle',
      'subtitle': 'Comfy Brand / Fair / 18"',
      'oldPrice': '120 €',
      'newPrice': '135 €',
      'image': 'assets/images/product_04.png',
    },
  ];

  void _showMoreSheet() {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      barrierColor: kBlurBarrierColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outline,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              // Share button
              _buildSheetButton(
                cs,
                Icons.share,
                'Sdílet profil',
                cs.secondaryContainer,
                cs.onSecondaryContainer,
                () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Odkaz byl zkopírován do schránky')),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Block button
              _buildSheetButton(
                cs,
                Icons.block,
                'Zablokovat prodejce',
                cs.secondaryContainer,
                cs.onSecondaryContainer,
                () {
                  Navigator.pop(context);
                  _showBlockDialog();
                },
              ),
              const SizedBox(height: 16),
              // Report button
              _buildSheetButton(
                cs,
                Icons.flag_outlined,
                'Nahlásit profil',
                cs.error,
                Colors.white,
                () {
                  Navigator.pop(context);
                  _showReportSelectionSheet();
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetButton(
    ColorScheme cs,
    IconData icon,
    String label,
    Color bgColor,
    Color fgColor,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: fgColor),
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: fgColor,
            letterSpacing: 0.15,
            height: 24 / 16,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  void _showBlockDialog() {
    final cs = Theme.of(context).colorScheme;
    showBlurDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: cs.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Zablokovat prodejce?',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                  height: 32 / 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: cs.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Zrušit',
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
                  ),
                  SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.error,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        'Zablokovat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 0.1,
                          height: 20 / 14,
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
    );
  }

  void _showReportSelectionSheet() {
    final cs = Theme.of(context).colorScheme;
    int selectedReason = -1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      barrierColor: kBlurBarrierColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cs.outline,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Text(
                  'Důvod nahlášení',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface,
                    height: 32 / 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.25,
                    height: 20 / 14,
                  ),
                ),
                const SizedBox(height: 16),
                _buildRadioOption(
                  cs,
                  0,
                  selectedReason,
                  'Myslím si, že jde o podvod nebo spam',
                  (val) => setSheetState(() => selectedReason = val),
                ),
                _buildRadioOption(
                  cs,
                  1,
                  selectedReason,
                  'Text je urážlivý',
                  (val) => setSheetState(() => selectedReason = val),
                ),
                _buildRadioOption(
                  cs,
                  2,
                  selectedReason,
                  'Něco jiného',
                  (val) => setSheetState(() => selectedReason = val),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: selectedReason >= 0
                        ? () {
                            Navigator.pop(ctx);
                            if (selectedReason == 2) {
                              _showReportReasonDialog();
                            }
                          }
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.primary,
                      disabledBackgroundColor: cs.primary.withAlpha(100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Odeslat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0.15,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(
    ColorScheme cs,
    int value,
    int groupValue,
    String label,
    ValueChanged<int> onChanged,
  ) {
    final selected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? cs.surfaceTint : cs.onSurface,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? cs.surfaceTint : cs.outlineVariant,
                  width: selected ? 6 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportReasonDialog() {
    final cs = Theme.of(context).colorScheme;
    final controller = TextEditingController();

    showBlurDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: cs.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Důvod nahlášení',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                  height: 32 / 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Popište důvod*',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.25,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: cs.primary),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: cs.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Zrušit',
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
                  ),
                  SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.secondaryContainer,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Odeslat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: cs.onSecondaryContainer,
                          letterSpacing: 0.1,
                          height: 20 / 14,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(
              title: 'emma.novak',
              showBack: true,
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: cs.onSurface),
                onPressed: _showMoreSheet,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile card
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildProfileCard(cs),
                  ),

                  // Info section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildInfoSection(cs),
                  ),

                  // Follow button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          setState(() => _isFollowing = !_isFollowing);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: _isFollowing
                              ? cs.secondaryContainer
                              : cs.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _isFollowing ? 'Sledujete' : 'Sledovat',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _isFollowing
                                ? cs.onSecondaryContainer
                                : Colors.white,
                            letterSpacing: 0.15,
                            height: 24 / 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Message seller button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatDetailScreen(
                                name: 'Emma Novak',
                                initials: 'EN',
                                avatarImage: 'assets/images/avatar_1.png',
                                productImage: 'assets/images/product_01.png',
                                productName: 'Black GP type saddle',
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.chat_bubble_outline, size: 20, color: cs.primary),
                        label: Text(
                          'Napsat zprávu',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: cs.primary,
                            letterSpacing: 0.15,
                            height: 24 / 16,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cs.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // "Inzeráty" section title with "Sestavit sadu" link
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Inzeráty',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                            height: 28 / 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Sestavit sadu',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: cs.surfaceTint,
                              letterSpacing: 0.1,
                              height: 20 / 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Product grid
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildProductGrid(cs),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(ColorScheme cs) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Avatar + name + stars row
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar_1.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emma Novak',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: cs.secondary,
                      height: 28 / 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ReviewsScreen(),
                        ),
                      );
                    },
                    child: Row(
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
                            letterSpacing: 0.15,
                            height: 24 / 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildStatColumn(cs, '35', 'sledujících'),
              ),
              Expanded(
                child: _buildStatColumn(cs, '18', 'sleduje'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(ColorScheme cs, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: cs.secondary,
            height: 28 / 20,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: cs.tertiary,
            letterSpacing: 0.4,
            height: 16 / 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoSection(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque eu mauris nec quam malesuada scelerisque ac luctus purus. Suspendisse placerat tristique orci, id volutpat nulla molestie non.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.secondary,
            letterSpacing: 0.25,
            height: 20 / 14,
          ),
        ),
        const SizedBox(height: 12),
        // Location
        _buildInfoRow(cs, 'assets/icons/MapPinArea.svg', 'Česká republika'),
        const SizedBox(height: 12),
        // Last login
        _buildInfoRow(
          cs,
          'assets/icons/ClockUser.svg',
          'Poslední přihlášení: ',
          trailingBold: '23.06.2024',
        ),
        const SizedBox(height: 12),
        // Verified
        _buildInfoRow(cs, 'assets/icons/shield-check.svg', 'Ověřeno e-mailem'),
      ],
    );
  }

  Widget _buildInfoRow(ColorScheme cs, String svgPath, String text, {String? trailingBold}) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(cs.secondary, BlendMode.srcIn),
        ),
        const SizedBox(width: 12),
        if (trailingBold != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: cs.secondary,
                    letterSpacing: 0.25,
                    height: 20 / 14,
                  ),
                ),
                TextSpan(
                  text: trailingBold,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: cs.secondary,
                    letterSpacing: 0.25,
                    height: 20 / 14,
                  ),
                ),
              ],
            ),
          )
        else
          Text(
            text,
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

  Widget _buildProductGrid(ColorScheme cs) {
    final rows = <Widget>[];
    for (var i = 0; i < _products.length; i += 2) {
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 2 < _products.length ? 16 : 0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildProductCard(cs, i, _products[i])),
                const SizedBox(width: 16),
                if (i + 1 < _products.length)
                  Expanded(child: _buildProductCard(cs, i + 1, _products[i + 1]))
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildProductCard(ColorScheme cs, int index, Map<String, String> product) {
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
              imageAsset: product['image']!,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 177 / 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    product['image']!,
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
                        child: Stack(
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
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
}
