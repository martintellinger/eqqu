import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class BuildSetScreen extends StatefulWidget {
  final List<Map<String, String>> products;

  const BuildSetScreen({super.key, required this.products});

  @override
  State<BuildSetScreen> createState() => _BuildSetScreenState();
}

class _BuildSetScreenState extends State<BuildSetScreen> {
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Navigator.pop(context, _selectedIndices.length);
        }
      },
      child: Scaffold(
        backgroundColor: cs.surface,
        body: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: 'Sestavit sadu',
                showBack: true,
                onBack: () => Navigator.pop(context, _selectedIndices.length),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: Text(
                          'Přidejte produkty do košiku',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                            height: 28 / 20,
                          ),
                        ),
                      ),
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
        ),
      ),
    );
  }

  Widget _buildProductGrid(ColorScheme cs) {
    final products = widget.products;
    final List<Widget> rows = [];
    for (int i = 0; i < products.length; i += 2) {
      final first = _buildProductCard(cs, i);
      final second = i + 1 < products.length
          ? _buildProductCard(cs, i + 1)
          : const Expanded(child: SizedBox());
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: first),
            const SizedBox(width: 16),
            Expanded(child: second),
          ],
        ),
      );
      if (i + 2 < products.length) {
        rows.add(const SizedBox(height: 16));
      }
    }
    return Column(children: rows);
  }

  Widget _buildProductCard(ColorScheme cs, int index) {
    final p = widget.products[index];
    final isSelected = _selectedIndices.contains(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedIndices.remove(index);
          } else {
            _selectedIndices.add(index);
          }
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 177 / 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    p['image']!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedIndices.remove(index);
                        } else {
                          _selectedIndices.add(index);
                        }
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? cs.primary
                            : cs.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSelected ? Icons.check : Icons.add,
                        size: 20,
                        color: isSelected
                            ? cs.onPrimary
                            : cs.onSecondaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            p['title']!,
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
            p['subtitle']!,
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
                '${p['oldPrice']}  ',
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
                '${p['newPrice']}  ',
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
