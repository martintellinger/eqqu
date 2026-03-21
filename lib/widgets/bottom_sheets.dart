import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/utils/blur_overlay.dart';

// ══════════════════════════════════════════════════════════════════════════════
// Filter Data
// ══════════════════════════════════════════════════════════════════════════════

const _categoryLabels = [
  'Koně',
  'Jezdci',
  'Stáj',
  'Psi',
  'Knihy, hračky, dárky',
  'Umění',
  'Veterinární produkty',
  'Krmivo',
  'Terapeutické přístroje',
];

const _categorySvgs = [
  'assets/icons/Kone.svg',
  'assets/icons/Jezdci.svg',
  'assets/icons/Staj.svg',
  'assets/icons/Psi.svg',
  'assets/icons/Kniha_hracky_darky.svg',
  'assets/icons/Kone.svg',
  'assets/icons/Veterinarni_produkty.svg',
  'assets/icons/Krmivo.svg',
  'assets/icons/erapeuticke_pristroje.svg',
];

const _subcategoriesMap = <String, List<String>>{
  'Koně': ['Sedla', 'Podsedlové dečky', 'Tlumící podsedlovky', 'Podbřišníky', 'Udidla', 'Uzdečky a uzdy', 'Deky', 'Martingaly a poprsníky', 'Kamaše a chrániče', 'Třmeny a třmenové řemeny'],
  'Jezdci': ['Helmy', 'Rajtky', 'Boty', 'Vesty', 'Rukavice', 'Bundy'],
  'Stáj': ['Kbelíky a krmítka', 'Čištění', 'Podestýlky', 'Stájové vybavení'],
  'Psi': ['Obojky', 'Vodítka', 'Pelíšky', 'Hračky', 'Misky'],
  'Knihy, hračky, dárky': ['Knihy', 'Hračky', 'Dárkové sety', 'Puzzle', 'Modely koní'],
  'Umění': ['Obrazy', 'Sochy', 'Fotografie', 'Plakáty'],
  'Veterinární produkty': ['Doplňky stravy', 'Ošetření kopyt', 'Obvazy a náplasti', 'Dezinfekce'],
  'Krmivo': ['Müsli', 'Granule', 'Seno a sláma', 'Pamlsky', 'Minerály'],
  'Terapeutické přístroje': ['Magnetoterapie', 'Lasery', 'Masážní přístroje', 'Solné lampy'],
};

const _sortOptions = [
  'Relevance',
  'Od nejlevnějšího',
  'Od nejdražšího',
  'Od nejnovějších',
];

const _conditionOptions = [
  'Nové s visačkou',
  'Nové bez visačky',
  'Velmi dobré',
  'Dobré',
  'Uspokojivé',
];

const _sizeOptions = [
  'XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL',
  '14"', '15"', '16"', '16.5"', '17"', '17.5"', '18"',
];

const _brandOptions = [
  'Kentucky',
  'Eskadron',
  'BR',
  'Horze',
  'HKM',
  'Cavallo',
  'Prestige',
  'Stübben',
  'Passier',
  'Busse',
  'Pikeur',
  'Kingsland',
  'Schockemöhle',
  'Equiline',
  'Animo',
];

const _genderOptions = [
  'Muži',
  'Ženy',
  'Unisex',
  'Děti',
];

const _colorOptions = [
  'Černá',
  'Bílá',
  'Hnědá',
  'Modrá',
  'Červená',
  'Zelená',
  'Šedá',
  'Béžová',
  'Růžová',
  'Fialová',
];

const _materialOptions = [
  'Kůže',
  'Syntetika',
  'Bavlna',
  'Vlna',
  'Polyester',
  'Neopren',
  'Fleece',
];

const _favoriteOptions = [
  'Všechny',
  'Jen oblíbené produkty',
];

// ══════════════════════════════════════════════════════════════════════════════
// Main Filter Sheet
// ══════════════════════════════════════════════════════════════════════════════

Future<Map<String, String>?> showFilterSheet(BuildContext context, {Map<String, String>? currentFilters}) {
  return showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _FilterSheet(initialFilters: currentFilters ?? {}),
  );
}

class _FilterSheet extends StatefulWidget {
  final Map<String, String> initialFilters;
  const _FilterSheet({required this.initialFilters});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late Map<String, String> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map<String, String>.from(widget.initialFilters);
  }

  void _clearFilters() {
    setState(() => _filters.clear());
  }

  Future<void> _openSubFilter(String key) async {
    String? result;
    switch (key) {
      case 'Řadit podle':
        result = await _showSelectSheet(context, 'Řadit podle', _sortOptions, _filters[key], singleSelect: true);
        break;
      case 'Kategorie':
        result = await _showCategorySelectSheet(context, _filters[key]);
        break;
      case 'Cena':
        result = await _showPriceSheet(context, _filters[key]);
        break;
      case 'Stav zboží':
        result = await _showSelectSheet(context, 'Stav zboží', _conditionOptions, _filters[key]);
        break;
      case 'Velikost':
        result = await _showSelectSheet(context, 'Velikost', _sizeOptions, _filters[key]);
        break;
      case 'Značka':
        result = await _showSelectSheet(context, 'Značka', _brandOptions, _filters[key]);
        break;
      case 'Pohlaví':
        result = await _showSelectSheet(context, 'Pohlaví', _genderOptions, _filters[key]);
        break;
      case 'Barva':
        result = await _showSelectSheet(context, 'Barva', _colorOptions, _filters[key]);
        break;
      case 'Materiál':
        result = await _showSelectSheet(context, 'Materiál', _materialOptions, _filters[key]);
        break;
      case 'Oblíbené':
        result = await _showSelectSheet(context, 'Oblíbené', _favoriteOptions, _filters[key], singleSelect: true);
        break;
    }

    if (result != null && mounted) {
      setState(() {
        if (result!.isEmpty ||
            (key == 'Řadit podle' && result == 'Relevance') ||
            (key == 'Oblíbené' && result == 'Všechny')) {
          _filters.remove(key);
        } else {
          _filters[key] = result;
        }
      });
    }
  }

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
          _filterAppBar(cs, 'Filtr',
            onBack: () => Navigator.pop(context),
            onClear: _clearFilters,
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: EdgeInsets.zero,
              children: [
                _filterNavTile(cs, 'Řadit podle', _filters['Řadit podle'], onTap: () => _openSubFilter('Řadit podle')),
                _filterNavTile(cs, 'Kategorie', _filters['Kategorie'], onTap: () => _openSubFilter('Kategorie')),
                _filterNavTile(cs, 'Cena', _filters['Cena'], onTap: () => _openSubFilter('Cena')),
                _filterNavTile(cs, 'Stav zboží', _filters['Stav zboží'], onTap: () => _openSubFilter('Stav zboží')),
                _filterNavTile(cs, 'Velikost', _filters['Velikost'], onTap: () => _openSubFilter('Velikost')),
                _filterNavTile(cs, 'Značka', _filters['Značka'], onTap: () => _openSubFilter('Značka')),
                _filterNavTile(cs, 'Pohlaví', _filters['Pohlaví'], onTap: () => _openSubFilter('Pohlaví')),
                _filterNavTile(cs, 'Barva', _filters['Barva'], onTap: () => _openSubFilter('Barva')),
                _filterNavTile(cs, 'Materiál', _filters['Materiál'], onTap: () => _openSubFilter('Materiál')),
                _filterNavTile(cs, 'Oblíbené', _filters['Oblíbené'], onTap: () => _openSubFilter('Oblíbené')),
              ],
            ),
          ),
          _saveButton(cs, context, _filters.isEmpty ? 'Uložit filtry' : 'Uložit filtry (${_filters.length})',
            onPressed: () => Navigator.pop(context, _filters),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Generic Select Sheet (used for Sort, Condition, Size, Brand, Gender, Color, Material, Favorites)
// ══════════════════════════════════════════════════════════════════════════════

Future<String?> _showSelectSheet(
  BuildContext context,
  String title,
  List<String> options,
  String? currentValue, {
  bool singleSelect = false,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _SelectSheet(
      title: title,
      options: options,
      currentValue: currentValue,
      singleSelect: singleSelect,
    ),
  );
}

class _SelectSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? currentValue;
  final bool singleSelect;

  const _SelectSheet({
    required this.title,
    required this.options,
    this.currentValue,
    this.singleSelect = false,
  });

  @override
  State<_SelectSheet> createState() => _SelectSheetState();
}

class _SelectSheetState extends State<_SelectSheet> {
  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
    if (widget.currentValue != null && widget.currentValue!.isNotEmpty) {
      _selected = widget.currentValue!.split(', ').toSet();
    } else {
      _selected = {};
    }
  }

  void _toggle(String option) {
    setState(() {
      if (widget.singleSelect) {
        _selected = {option};
      } else {
        if (_selected.contains(option)) {
          _selected.remove(option);
        } else {
          _selected.add(option);
        }
      }
    });
  }

  void _clear() {
    setState(() => _selected.clear());
  }

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
          _filterAppBar(cs, widget.title,
            onBack: () => Navigator.pop(context),
            onClear: _clear,
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.only(top: 16),
              children: widget.options.map((option) {
                final isSelected = _selected.contains(option);
                return _checkListTile(cs, option, isSelected, onTap: () => _toggle(option));
              }).toList(),
            ),
          ),
          _saveButton(cs, context, 'Uložit',
            onPressed: () => Navigator.pop(context, _selected.join(', ')),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Category Select Sheet (Figma: multi-select categories, then subcategories)
// ══════════════════════════════════════════════════════════════════════════════

Future<String?> _showCategorySelectSheet(BuildContext context, String? currentValue) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _CategorySelectSheet(currentValue: currentValue),
  );
}

class _CategorySelectSheet extends StatefulWidget {
  final String? currentValue;
  const _CategorySelectSheet({this.currentValue});

  @override
  State<_CategorySelectSheet> createState() => _CategorySelectSheetState();
}

class _CategorySelectSheetState extends State<_CategorySelectSheet> {
  late Set<String> _selectedCategories;
  late Set<String> _selectedSubcategories;
  bool _showSubcategories = false;

  @override
  void initState() {
    super.initState();
    _selectedCategories = {};
    _selectedSubcategories = {};
    if (widget.currentValue != null && widget.currentValue!.isNotEmpty) {
      final parts = widget.currentValue!.split(', ');
      for (final part in parts) {
        if (_categoryLabels.contains(part)) {
          _selectedCategories.add(part);
        } else {
          _selectedSubcategories.add(part);
        }
      }
    }
  }

  void _toggleCategory(String cat) {
    setState(() {
      if (_selectedCategories.contains(cat)) {
        _selectedCategories.remove(cat);
        final subs = _subcategoriesMap[cat] ?? [];
        _selectedSubcategories.removeAll(subs);
      } else {
        _selectedCategories.add(cat);
      }
    });
  }

  void _toggleSubcategory(String sub) {
    setState(() {
      if (_selectedSubcategories.contains(sub)) {
        _selectedSubcategories.remove(sub);
      } else {
        _selectedSubcategories.add(sub);
      }
    });
  }

  void _clear() {
    setState(() {
      _selectedCategories.clear();
      _selectedSubcategories.clear();
    });
  }

  String _buildResult() {
    final all = <String>[..._selectedCategories, ..._selectedSubcategories];
    return all.join(', ');
  }

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
          _filterAppBar(
            cs,
            _showSubcategories ? 'Podkategorie' : 'Kategorie',
            onBack: _showSubcategories
                ? () => setState(() => _showSubcategories = false)
                : () => Navigator.pop(context),
            onClear: _clear,
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: _showSubcategories
                ? _buildSubcategoriesList(cs, controller)
                : _buildCategoriesList(cs, controller),
          ),
          _saveButton(
            cs,
            context,
            _showSubcategories ? 'Uložit' : 'Uložit a vybrat podkategorie',
            onPressed: () {
              if (!_showSubcategories && _selectedCategories.isNotEmpty) {
                setState(() => _showSubcategories = true);
              } else {
                Navigator.pop(context, _buildResult());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(ColorScheme cs, ScrollController controller) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.only(top: 16),
      children: List.generate(_categoryLabels.length, (i) {
        final label = _categoryLabels[i];
        final isSelected = _selectedCategories.contains(label);
        return _checkListTile(cs, label, isSelected,
          leading: _trySvgIcon(_categorySvgs[i]),
          onTap: () => _toggleCategory(label),
        );
      }),
    );
  }

  Widget _buildSubcategoriesList(ColorScheme cs, ScrollController controller) {
    final children = <Widget>[];
    for (final cat in _selectedCategories) {
      final subs = _subcategoriesMap[cat] ?? [];
      if (subs.isEmpty) continue;
      children.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            cat,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: cs.onSurface,
              height: 32 / 24,
            ),
          ),
        ),
      );
      for (final sub in subs) {
        final isSelected = _selectedSubcategories.contains(sub);
        children.add(_checkListTile(cs, sub, isSelected, onTap: () => _toggleSubcategory(sub)));
      }
    }
    return ListView(
      controller: controller,
      children: children,
    );
  }

  Widget? _trySvgIcon(String path) {
    try {
      return SvgPicture.asset(path, width: 24, height: 24);
    } catch (_) {
      return null;
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Price Range Sheet
// ══════════════════════════════════════════════════════════════════════════════

Future<String?> _showPriceSheet(BuildContext context, String? currentValue) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    barrierColor: kBlurBarrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _PriceFilterSheet(currentValue: currentValue),
  );
}

class _PriceFilterSheet extends StatefulWidget {
  final String? currentValue;
  const _PriceFilterSheet({this.currentValue});

  @override
  State<_PriceFilterSheet> createState() => _PriceFilterSheetState();
}

class _PriceFilterSheetState extends State<_PriceFilterSheet> {
  late RangeValues _range;
  late TextEditingController _minController;
  late TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    double min = 0, max = 5000;
    if (widget.currentValue != null) {
      final match = RegExp(r'(\d+)\s*[–-]\s*(\d+)').firstMatch(widget.currentValue!);
      if (match != null) {
        min = double.tryParse(match.group(1)!) ?? 0;
        max = double.tryParse(match.group(2)!) ?? 5000;
      }
    }
    _range = RangeValues(min, max);
    _minController = TextEditingController(text: min.round().toString());
    _maxController = TextEditingController(text: max.round().toString());
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.85,
      minChildSize: 0.4,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          _dragHandle(cs),
          _filterAppBar(cs, 'Cenové rozpětí',
            onBack: () => Navigator.pop(context),
            onClear: () {
              setState(() {
                _range = const RangeValues(0, 5000);
                _minController.text = '0';
                _maxController.text = '5000';
              });
            },
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
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
              ],
            ),
          ),
          _saveButton(cs, context, 'Uložit',
            onPressed: () {
              final min = _range.start.round();
              final max = _range.end.round();
              if (min == 0 && max == 5000) {
                Navigator.pop(context, '');
              } else {
                Navigator.pop(context, '$min – $max €');
              }
            },
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Legacy Category Sheet (kept for standalone use)
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
          _dragHandle(cs),
          _sheetHeader(
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
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
              letterSpacing: 0.15,
            ),
          ),
        ),
        ...List.generate(_categoryLabels.length, (i) => _categoryTile(
          cs,
          _categorySvgs[i],
          _categoryLabels[i],
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
    );
  }

  Widget _buildSubcategoriesList(ColorScheme cs, ScrollController controller) {
    final subs = _subcategoriesMap[_selectedCategory] ?? [];
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
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
                letterSpacing: 0.5,
              ),
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
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: cs.onSurface,
            letterSpacing: 0.5,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: cs.onSurface, size: 20),
        onTap: () => setState(() => _selectedCategory = label),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Legacy Sorting Sheet (kept for standalone use)
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
          ..._sortOptions.map((option) => RadioListTile<String>(
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

// ══════════════════════════════════════════════════════════════════════════════
// Legacy Price Range Sheet (kept for standalone use)
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

// ══════════════════════════════════════════════════════════════════════════════
// Shared Widgets
// ══════════════════════════════════════════════════════════════════════════════

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

Widget _sheetHeader(BuildContext context, ColorScheme cs, String title, {VoidCallback? onBack}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: onBack ?? () => Navigator.pop(context),
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

/// App bar with back arrow, centered title, and trash icon (matching Figma design)
Widget _filterAppBar(ColorScheme cs, String title, {
  required VoidCallback onBack,
  required VoidCallback onClear,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: onBack,
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
        IconButton(
          icon: Icon(Icons.delete_outline, color: cs.onSurface),
          onPressed: onClear,
        ),
      ],
    ),
  );
}

/// List tile with checkmark (matches Figma design: item with outline-variant bottom border, green check when selected)
Widget _checkListTile(ColorScheme cs, String label, bool isSelected, {
  required VoidCallback onTap,
  Widget? leading,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
            ),
          ),
          if (isSelected)
            Icon(Icons.check_circle, color: cs.primary, size: 20),
        ],
      ),
    ),
  );
}

/// Navigation tile in main filter sheet (label + value text + chevron)
Widget _filterNavTile(ColorScheme cs, String label, String? value, {required VoidCallback onTap}) {
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
        if (value != null && value.isNotEmpty)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: cs.surfaceTint,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        const SizedBox(width: 4),
        Icon(Icons.chevron_right, color: cs.onSurface, size: 24),
      ],
    ),
    onTap: onTap,
  );
}

/// Green save button at bottom of sheets
Widget _saveButton(ColorScheme cs, BuildContext context, String label, {required VoidCallback onPressed}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
    child: SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
