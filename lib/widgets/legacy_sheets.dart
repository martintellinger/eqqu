import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/filter_data.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';

// ══════════════════════════════════════════════════════════════════════════════
// Legacy Category Sheet (standalone use)
// ══════════════════════════════════════════════════════════════════════════════

Future<String?> showCategoriesSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _CategoriesSheet(),
  );
}

class _CategoriesSheet extends StatefulWidget {
  const _CategoriesSheet();

  @override
  State<_CategoriesSheet> createState() => _CategoriesSheetState();
}

class _CategoriesSheetState extends State<_CategoriesSheet> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          buildDragHandle(cs),
          buildSheetHeader(
            context,
            cs,
            _selectedCategory ?? 'Kategorie',
            onBack: _selectedCategory != null
              ? () => setState(() => _selectedCategory = null)
              : null,
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: _selectedCategory == null
              ? _buildCategoriesList(cs, controller)
              : _buildSubcategoriesList(cs, controller),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(ColorScheme cs, ScrollController controller) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'Kategorie',
            style: AppTextStyles.labelMedium(cs.onSurface),
          ),
        ),
        ...List.generate(categoryLabels.length, (i) => _categoryTile(
          cs,
          categorySvgs[i],
          categoryLabels[i],
        )),
        const SizedBox(height: 24),
        Center(
          child: Column(
            children: [
              Text(
                'Nenašel jsi správnou kategorii?',
                style: AppTextStyles.bodyMedium(cs.tertiary),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Napiš nám',
                  style: AppTextStyles.actionLink(cs.secondary).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSubcategoriesList(ColorScheme cs, ScrollController controller) {
    final subs = subcategoriesMap[_selectedCategory] ?? [];
    return ListView(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 12),
        ...subs.map((sub) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              sub,
              style: AppTextStyles.bodyLarge(cs.onSurface),
            ),
            trailing: Icon(Icons.chevron_right, color: cs.onSurface, size: 20),
            onTap: () => Navigator.pop(context, '$_selectedCategory > $sub'),
          ),
        )),
      ],
    );
  }

  Widget _categoryTile(ColorScheme cs, String svgPath, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: SvgPicture.asset(svgPath, width: 24, height: 24),
        title: Text(
          label,
          style: AppTextStyles.bodyLarge(cs.onSurface),
        ),
        trailing: Icon(Icons.chevron_right, color: cs.onSurface, size: 20),
        onTap: () => setState(() => _selectedCategory = label),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Legacy Sorting Sheet (standalone use)
// ══════════════════════════════════════════════════════════════════════════════

void showSortingSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _SortingSheet(),
  );
}

class _SortingSheet extends StatefulWidget {
  const _SortingSheet();

  @override
  State<_SortingSheet> createState() => _SortingSheetState();
}

class _SortingSheetState extends State<_SortingSheet> {
  String _selected = 'Relevance';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDragHandle(cs),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Řadit podle',
              style: AppTextStyles.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
              ),
            ),
          ),
          Divider(color: cs.outline, height: 1),
          ...sortOptions.map((option) => RadioListTile<String>(
            value: option,
            groupValue: _selected,
            onChanged: (v) {
              setState(() => _selected = v!);
              Navigator.pop(context);
            },
            title: Text(
              option,
              style: AppTextStyles.bodyLarge(cs.onSurface),
            ),
            activeColor: cs.primary,
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Legacy Price Range Sheet (standalone use)
// ══════════════════════════════════════════════════════════════════════════════

void showPriceRangeSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _PriceRangeSheet(),
  );
}

class _PriceRangeSheet extends StatefulWidget {
  const _PriceRangeSheet();

  @override
  State<_PriceRangeSheet> createState() => _PriceRangeSheetState();
}

class _PriceRangeSheetState extends State<_PriceRangeSheet> {
  RangeValues _range = const RangeValues(0, 1000);
  final _minController = TextEditingController(text: '0');
  final _maxController = TextEditingController(text: '1000');

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildDragHandle(cs),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Cenové rozpětí',
                style: AppTextStyles.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                ),
              ),
            ),
            Divider(color: cs.outline, height: 1),
            const SizedBox(height: 24),
            RangeSlider(
              values: _range,
              min: 0,
              max: 5000,
              divisions: 100,
              activeColor: cs.primary,
              inactiveColor: cs.outline,
              onChanged: (v) {
                setState(() {
                  _range = v;
                  _minController.text = v.start.round().toString();
                  _maxController.text = v.end.round().toString();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Min (€)'),
                    onChanged: (v) {
                      final val = double.tryParse(v);
                      if (val != null && val >= 0 && val <= _range.end) {
                        setState(() => _range = RangeValues(val, _range.end));
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Max (€)'),
                    onChanged: (v) {
                      final val = double.tryParse(v);
                      if (val != null && val >= _range.start && val <= 5000) {
                        setState(() => _range = RangeValues(_range.start, val));
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            buildSaveButton(cs, context, 'Uložit',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
