import 'package:flutter/material.dart';

// ── Categories ──

void showCategoriesSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _CategoriesSheet(),
  );
}

class _CategoriesSheet extends StatelessWidget {
  const _CategoriesSheet();

  static const _categories = [
    {'icon': Icons.pets, 'label': 'Koně'},
    {'icon': Icons.person, 'label': 'Jezdci'},
    {'icon': Icons.home_work, 'label': 'Stáj'},
    {'icon': Icons.pets, 'label': 'Psi'},
    {'icon': Icons.menu_book, 'label': 'Knihy, hračky, dárky'},
    {'icon': Icons.medical_services, 'label': 'Veterinární produkty'},
    {'icon': Icons.grass, 'label': 'Krmivo'},
    {'icon': Icons.healing, 'label': 'Terapeutické přístroje'},
  ];

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
          _dragHandle(cs),
          _sheetHeader(context, cs, 'Kategorie'),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Text(
                    'Kategorie',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
                ..._categories.map((cat) => _categoryTile(
                  context,
                  cs,
                  cat['icon'] as IconData,
                  cat['label'] as String,
                )),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Nenašel jsi správnou kategorii?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: cs.tertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Napiš nám',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: cs.secondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryTile(BuildContext context, ColorScheme cs, IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: cs.onSurface, size: 24),
        title: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: cs.onSurface,
            letterSpacing: 0.5,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: cs.onSurface, size: 20),
        onTap: () {
          Navigator.pop(context);
          showSubcategoriesSheet(context, label);
        },
      ),
    );
  }
}

// ── Subcategories ──

void showSubcategoriesSheet(BuildContext context, String category) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _SubcategoriesSheet(category: category),
  );
}

class _SubcategoriesSheet extends StatelessWidget {
  final String category;
  const _SubcategoriesSheet({required this.category});

  static const _subcategories = [
    'Sedla',
    'Podsedlové dečky',
    'Tlumící podsedlovky',
    'Podbřišníky',
    'Třmeny a třmenové řemeny',
    'Udidla',
    'Uzdečky a uzdy',
    'Deky',
    'Martingaly a poprsníky',
    'Kamaše a chrániče',
  ];

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
          _dragHandle(cs),
          _sheetHeader(context, cs, category),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 12),
                ..._subcategories.map((sub) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: cs.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      sub,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: cs.onSurface,
                        letterSpacing: 0.5,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right, color: cs.onSurface, size: 20),
                    onTap: () => Navigator.pop(context),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Filter Sheet ──

void showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _FilterSheet(),
  );
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet();

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
          _dragHandle(cs),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: cs.onSurface),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Filtr',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: cs.onSurface),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: EdgeInsets.zero,
              children: [
                _filterTile(context, cs, 'Řadit podle', 'Relevance', onTap: () {
                  Navigator.pop(context);
                  showSortingSheet(context);
                }),
                _filterTile(context, cs, 'Kategorie', 'Koně', valuePrimary: true, onTap: () {
                  Navigator.pop(context);
                  showCategoriesSheet(context);
                }),
                _filterTile(context, cs, 'Cena', 'Všechny', onTap: () {
                  Navigator.pop(context);
                  showPriceRangeSheet(context);
                }),
                _filterTile(context, cs, 'Stav zboží', null, onTap: () {}),
                _filterTile(context, cs, 'Velikost', null, onTap: () {}),
                _filterTile(context, cs, 'Značka', null, onTap: () {}),
                _filterTile(context, cs, 'Pohlaví', null, onTap: () {}),
                _filterTile(context, cs, 'Barva', null, onTap: () {}),
                _filterTile(context, cs, 'Materiál', null, onTap: () {}),
                _filterTile(context, cs, 'Oblíbené', null, onTap: () {}),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Uložit filtry',
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
        ],
      ),
    );
  }

  Widget _filterTile(BuildContext context, ColorScheme cs, String label, String? value, {bool valuePrimary = false, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: cs.onSurface,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: valuePrimary ? cs.surfaceTint : cs.tertiary,
              ),
            ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right, color: cs.onSurface, size: 24),
        ],
      ),
      onTap: onTap,
    );
  }
}

// ── Sorting Sheet ──

void showSortingSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
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

  static const _options = [
    'Relevance',
    'Nejnovější',
    'Cena: od nejnižší',
    'Cena: od nejvyšší',
    'Nejoblíbenější',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dragHandle(cs),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Řadit podle',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
              ),
            ),
          ),
          Divider(color: cs.outline, height: 1),
          ..._options.map((option) => RadioListTile<String>(
            value: option,
            groupValue: _selected,
            onChanged: (v) {
              setState(() => _selected = v!);
              Navigator.pop(context);
            },
            title: Text(
              option,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
              ),
            ),
            activeColor: cs.primary,
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Price Range Sheet ──

void showPriceRangeSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
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
            _dragHandle(cs),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Cenové rozpětí',
                style: TextStyle(
                  fontFamily: 'Poppins',
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
                    decoration: const InputDecoration(
                      labelText: 'Min (€)',
                    ),
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
                    decoration: const InputDecoration(
                      labelText: 'Max (€)',
                    ),
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
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Uložit',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared Widgets ──

Widget _dragHandle(ColorScheme cs) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    width: 40,
    height: 4,
    decoration: BoxDecoration(
      color: cs.onSurface.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

Widget _sheetHeader(BuildContext context, ColorScheme cs, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: cs.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 48),
      ],
    ),
  );
}
