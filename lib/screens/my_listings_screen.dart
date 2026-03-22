import 'package:flutter/material.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/models/listing.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/app_header.dart';


class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  final Set<int> _hiddenIndices = {};

  bool get _allHidden =>
      _listings.isNotEmpty && _hiddenIndices.length == _listings.length;

  final List<Listing> _listings = [
    Listing(
      id: '1',
      product: const Product(
        title: 'Black GP type saddle',
        subtitle: 'No brand / Good / 17"',
        oldPrice: '140 €',
        newPrice: '159 €',
        imageAsset: 'assets/images/product_01.png',
        brand: 'No brand',
      ),
      status: 'active',
    ),
    Listing(
      id: '2',
      product: const Product(
        title: 'Green Mountain type saddle',
        subtitle: 'Rugged Brand / Very Good / 16"',
        oldPrice: '180 €',
        newPrice: '199 €',
        imageAsset: 'assets/images/product_02.png',
        brand: 'Rugged Brand',
      ),
      status: 'sold',
    ),
    Listing(
      id: '3',
      product: const Product(
        title: 'Red Racing type saddle',
        subtitle: 'Speedy Brand / Excellent / 15"',
        oldPrice: '200 €',
        newPrice: '230 €',
        imageAsset: 'assets/images/product_03.png',
        brand: 'Speedy Brand',
      ),
      status: 'sold',
    ),
    Listing(
      id: '4',
      product: const Product(
        title: 'Black GP type saddle',
        subtitle: 'No brand / Good / 17"',
        oldPrice: '140 €',
        newPrice: '159 €',
        imageAsset: 'assets/images/product_01.png',
        brand: 'No brand',
      ),
      status: 'shipped',
    ),
    Listing(
      id: '5',
      product: const Product(
        title: 'Red Racing type saddle',
        subtitle: 'Speedy Brand / Excellent / 15"',
        oldPrice: '200 €',
        newPrice: '230 €',
        imageAsset: 'assets/images/product_03.png',
        brand: 'Speedy Brand',
      ),
      status: 'shipped',
    ),
    Listing(
      id: '6',
      product: const Product(
        title: 'Green Mountain type saddle',
        subtitle: 'Rugged Brand / Very Good / 16"',
        oldPrice: '180 €',
        newPrice: '199 €',
        imageAsset: 'assets/images/product_02.png',
        brand: 'Rugged Brand',
      ),
      status: 'shipped',
    ),
  ];

  void _toggleHideAll() {
    setState(() {
      if (_allHidden) {
        _hiddenIndices.clear();
      } else {
        _hiddenIndices.addAll(
          List.generate(_listings.length, (i) => i),
        );
      }
    });
  }

  void _toggleHideItem(int index) {
    setState(() {
      if (_hiddenIndices.contains(index)) {
        _hiddenIndices.remove(index);
      } else {
        _hiddenIndices.add(index);
      }
    });
  }

  void _deleteItem(int index) {
    if (index >= _listings.length) return;
    final deleted = _listings[index];
    // Schedule deletion after the current frame to avoid mouse_tracker issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _listings.removeAt(index);
        final newHidden = <int>{};
        for (final h in _hiddenIndices) {
          if (h < index) {
            newHidden.add(h);
          } else if (h > index) {
            newHidden.add(h - 1);
          }
        }
        _hiddenIndices
          ..clear()
          ..addAll(newHidden);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${deleted.product.title} byl smazán'),
        ),
      );
    });
  }

  void _showProductActions(int index, Listing listing) {
    final cs = Theme.of(context).colorScheme;
    final isHidden = _hiddenIndices.contains(index);

    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16, 8, 16, MediaQuery.of(ctx).viewPadding.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Rezervovat
              _buildSheetButton(
                cs: cs,
                icon: Icons.check_circle,
                label: 'Rezervovat',
                onTap: () async {
                  Navigator.pop(ctx);
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (mounted) _showReservationDialog();
                },
              ),
              const SizedBox(height: 12),
              // Upravit
              _buildSheetButton(
                cs: cs,
                icon: Icons.edit,
                label: 'Upravit',
                onTap: () => Navigator.pop(ctx),
              ),
              const SizedBox(height: 12),
              // Skrýt / Odkrýt
              _buildSheetButton(
                cs: cs,
                icon: isHidden ? Icons.visibility : Icons.visibility_off,
                label: isHidden ? 'Odkrýt' : 'Skrýt',
                onTap: () {
                  Navigator.pop(ctx);
                  _toggleHideItem(index);
                },
              ),
              const SizedBox(height: 12),
              // Smazat
              _buildSheetButton(
                cs: cs,
                icon: Icons.delete,
                label: 'Smazat',
                isDestructive: true,
                onTap: () async {
                  Navigator.pop(ctx);
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (mounted) _deleteItem(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSheetButton({
    required ColorScheme cs,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final bgColor = isDestructive ? cs.error : cs.secondary;
    final fgColor = isDestructive ? cs.onError : cs.onSecondary;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: fgColor),
        label: Text(
          label,
          style: AppTextStyles.productTitle(fgColor),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  void _showReservationDialog() {
    if (!mounted) return;

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: cs.surfaceContainerHigh,
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          title: Text(
            'Rezervovat',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: cs.onSurface,
              height: 32 / 24,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem ipsum dolor sit amet luctus, consectetur adipiscing elit',
                style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Uživatelské jméno*',
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: cs.onSurfaceVariant,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: cs.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: cs.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: cs.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          actions: [
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
                  style: AppTextStyles.chip(cs.onSurfaceVariant),
                ),
              ),
            ),
            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (mounted) _showReservationErrorSheet();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: cs.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Rezervovat',
                  style: AppTextStyles.chip(cs.onSecondaryContainer),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showReservationErrorSheet() {
    final cs = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: cs.errorContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24, 8, 24, MediaQuery.of(ctx).viewPadding.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: cs.onErrorContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Icon(
                Icons.error_outline,
                size: 48,
                color: cs.onErrorContainer,
              ),
              const SizedBox(height: 16),
              Text(
                'Rezervace se nezdařila',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: cs.onErrorContainer,
                  height: 28 / 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nepodařilo se rezervovat inzerát. Zkuste to prosím znovu později.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(cs.onErrorContainer),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Zavřít',
                    style: AppTextStyles.productTitle(cs.onError),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final anyHidden = _hiddenIndices.isNotEmpty;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Moje inzeráty', showBack: true),
          ),
          Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 88),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 177 / 290,
                  ),
                  itemCount: _listings.length,
                  itemBuilder: (context, index) {
                    final item = _listings[index];
                    return KeyedSubtree(
                      key: ValueKey(item.id),
                      child: _buildProductCard(cs, index, item),
                    );
                  },
                ),
                // Bottom floating button
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  child: SizedBox(
                    height: 56,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      color: cs.primary,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: _toggleHideAll,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                anyHidden ? Icons.visibility : Icons.visibility_off,
                                size: 24,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                anyHidden
                                    ? 'Odkrýt všechny inzeráty'
                                    : 'Skrýt všechny inzeráty',
                                style: AppTextStyles.productTitle(Colors.white),
                              ),
                            ],
                          ),
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

  Widget _buildProductCard(
    ColorScheme cs,
    int index,
    Listing listing,
  ) {
    final status = listing.status;
    final product = listing.product;
    final isHidden = _hiddenIndices.contains(index);

    return GestureDetector(
      onTap: () => _showProductActions(index, listing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with status badge
          AspectRatio(
            aspectRatio: 177 / 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    product.imageAsset,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Status badge (top-left)
                Positioned(
                  top: 8,
                  left: 8,
                  child: _buildStatusChip(cs, status),
                ),
                // Hidden eye-off chip (bottom-left)
                if (isHidden)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _buildHiddenChip(cs),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            product.title,
            style: AppTextStyles.productTitle(cs.secondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Subtitle
          Text(
            product.subtitle,
            style: AppTextStyles.bodyMedium(cs.tertiary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Price row
          Row(
            children: [
              Text(
                '${product.oldPrice}  ',
                style: AppTextStyles.labelSmall(cs.tertiary),
              ),
              const SizedBox(width: 8),
              Text(
                '${product.newPrice}  ',
                style: AppTextStyles.productNewPrice(cs.surfaceTint),
              ),
              Text(
                'vč.',
                style: AppTextStyles.productBadge(cs.surfaceTint),
              ),
              const SizedBox(width: 4),
              Icon(Icons.verified_user, size: 16, color: cs.surfaceTint),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(ColorScheme cs, String status) {
    String label;
    Color textColor;
    IconData icon;

    switch (status) {
      case 'active':
        label = 'Aktivní';
        textColor = const Color(0xFFA46700);
        icon = Icons.circle;
        break;
      case 'sold':
        label = 'Prodáno';
        textColor = cs.surfaceTint;
        icon = Icons.check_circle;
        break;
      case 'shipped':
        label = 'Odesláno';
        textColor = cs.onSurface;
        icon = Icons.circle;
        break;
      default:
        label = status;
        textColor = cs.tertiary;
        icon = Icons.circle;
    }

    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.chip(textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenChip(ColorScheme cs) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(Icons.visibility_off, size: 18, color: cs.onSurface),
    );
  }
}
