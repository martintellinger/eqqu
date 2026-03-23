import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/filter_data.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';

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
        result = await _showSelectSheet(context, 'Řadit podle', sortOptions, _filters[key], singleSelect: true);
        break;
      case 'Kategorie':
        result = await _showCategorySelectSheet(context, _filters[key]);
        break;
      case 'Cena':
        result = await _showPriceSheet(context, _filters[key]);
        break;
      case 'Stav zboží':
        result = await _showSelectSheet(context, 'Stav zboží', conditionOptions, _filters[key]);
        break;
      case 'Velikost':
        result = await _showSelectSheet(context, 'Velikost', sizeOptions, _filters[key]);
        break;
      case 'Značka':
        result = await _showSelectSheet(context, 'Značka', brandOptions, _filters[key]);
        break;
      case 'Pohlaví':
        result = await _showSelectSheet(context, 'Pohlaví', genderOptions, _filters[key]);
        break;
      case 'Barva':
        result = await _showSelectSheet(context, 'Barva', colorOptions, _filters[key]);
        break;
      case 'Materiál':
        result = await _showSelectSheet(context, 'Materiál', materialOptions, _filters[key]);
        break;
      case 'Oblíbené':
        result = await _showSelectSheet(context, 'Oblíbené', favoriteOptions, _filters[key], singleSelect: true);
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
          buildDragHandle(cs),
          buildFilterAppBar(cs, 'Filtr',
            onBack: () => Navigator.pop(context),
            onClear: _clearFilters,
          ),
          Divider(color: cs.outline, height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: EdgeInsets.zero,
              children: [
                buildFilterNavTile(cs, 'Řadit podle', _filters['Řadit podle'], onTap: () => _openSubFilter('Řadit podle')),
                buildFilterNavTile(cs, 'Kategorie', _filters['Kategorie'], onTap: () => _openSubFilter('Kategorie')),
                buildFilterNavTile(cs, 'Cena', _filters['Cena'], onTap: () => _openSubFilter('Cena')),
                buildFilterNavTile(cs, 'Stav zboží', _filters['Stav zboží'], onTap: () => _openSubFilter('Stav zboží')),
                buildFilterNavTile(cs, 'Velikost', _filters['Velikost'], onTap: () => _openSubFilter('Velikost')),
                buildFilterNavTile(cs, 'Značka', _filters['Značka'], onTap: () => _openSubFilter('Značka')),
                buildFilterNavTile(cs, 'Pohlaví', _filters['Pohlaví'], onTap: () => _openSubFilter('Pohlaví')),
                buildFilterNavTile(cs, 'Barva', _filters['Barva'], onTap: () => _openSubFilter('Barva')),
                buildFilterNavTile(cs, 'Materiál', _filters['Materiál'], onTap: () => _openSubFilter('Materiál')),
                buildFilterNavTile(cs, 'Oblíbené', _filters['Oblíbené'], onTap: () => _openSubFilter('Oblíbené')),
              ],
            ),
          ),
          buildSaveButton(cs, context, _filters.isEmpty ? 'Uložit filtry' : 'Uložit filtry (${_filters.length})',
            onPressed: () => Navigator.pop(context, _filters),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Generic Select Sheet
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
          buildDragHandle(cs),
          buildFilterAppBar(cs, widget.title,
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
                return buildCheckListTile(cs, option, isSelected, onTap: () => _toggle(option));
              }).toList(),
            ),
          ),
          buildSaveButton(cs, context, 'Uložit',
            onPressed: () => Navigator.pop(context, _selected.join(', ')),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Category Select Sheet
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
        if (categoryLabels.contains(part)) {
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
        final subs = subcategoriesMap[cat] ?? [];
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
          buildDragHandle(cs),
          buildFilterAppBar(
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
          buildSaveButton(
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
      children: List.generate(categoryLabels.length, (i) {
        final label = categoryLabels[i];
        final isSelected = _selectedCategories.contains(label);
        return buildCheckListTile(cs, label, isSelected,
          leading: _trySvgIcon(categorySvgs[i]),
          onTap: () => _toggleCategory(label),
        );
      }),
    );
  }

  Widget _buildSubcategoriesList(ColorScheme cs, ScrollController controller) {
    final children = <Widget>[];
    for (final cat in _selectedCategories) {
      final subs = subcategoriesMap[cat] ?? [];
      if (subs.isEmpty) continue;
      children.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            cat,
            style: AppTextStyles.outfit(
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
        children.add(buildCheckListTile(cs, sub, isSelected, onTap: () => _toggleSubcategory(sub)));
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
// Price Range Filter Sheet
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
  final FocusNode _minFocus = FocusNode();
  final FocusNode _maxFocus = FocusNode();

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
    _minFocus.addListener(() { if (!_minFocus.hasFocus) _applyMin(); });
    _maxFocus.addListener(() { if (!_maxFocus.hasFocus) _applyMax(); });
  }

  void _applyMin() {
    final val = double.tryParse(_minController.text);
    if (val != null) {
      final clamped = val.clamp(0.0, _range.end);
      setState(() {
        _range = RangeValues(clamped, _range.end);
        _minController.text = clamped.round().toString();
      });
    } else {
      _minController.text = _range.start.round().toString();
    }
  }

  void _applyMax() {
    final val = double.tryParse(_maxController.text);
    if (val != null) {
      final clamped = val.clamp(_range.start, 5000.0);
      setState(() {
        _range = RangeValues(_range.start, clamped);
        _maxController.text = clamped.round().toString();
      });
    } else {
      _maxController.text = _range.end.round().toString();
    }
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    _minFocus.dispose();
    _maxFocus.dispose();
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
          buildDragHandle(cs),
          buildFilterAppBar(cs, 'Cenové rozpětí',
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
                        focusNode: _minFocus,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Min (€)'),
                        onSubmitted: (_) => _applyMin(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _maxController,
                        focusNode: _maxFocus,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Max (€)'),
                        onSubmitted: (_) => _applyMax(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildSaveButton(cs, context, 'Uložit',
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
