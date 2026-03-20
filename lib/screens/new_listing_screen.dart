import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/widgets/bottom_sheets.dart';

class NewListingScreen extends StatefulWidget {
  const NewListingScreen({super.key});

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedCategory;
  String? _selectedBrand;
  String? _selectedCondition;
  String? _selectedSize;
  String? _selectedColor;
  String? _selectedMaterial;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          // M3 Small App bar with back button + centered title
          SafeArea(
            bottom: false,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: cs.outline, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: cs.onSurface),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Nový inzerát',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: cs.onSurface,
                        height: 28 / 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: Základní informace
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Text(
                      'Základní informace',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // File upload area
                        _buildFileUpload(cs),
                        const SizedBox(height: 24),

                        // Název*
                        TextField(
                          controller: _nameController,
                          style: _inputTextStyle(cs),
                          decoration: const InputDecoration(
                            labelText: 'Název*',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Popis*
                        TextField(
                          controller: _descriptionController,
                          style: _inputTextStyle(cs),
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Popis*',
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Kategorie*
                        _buildSelectorField(cs, 'Kategorie*', _selectedCategory, () {
                          showCategoriesSheet(context);
                        }),
                        const SizedBox(height: 16),

                        // Značka
                        _buildSelectorField(cs, 'Značka', _selectedBrand, () {
                          _showSimpleSelector(
                            context, 'Značka',
                            ['No brand', 'Cavalleria Toscana', 'Animo', 'Kingsland', 'Shires', 'Busse', 'Eskadron', 'HKM'],
                            (v) => setState(() => _selectedBrand = v),
                          );
                        }),
                        const SizedBox(height: 16),

                        // Stav*
                        _buildSelectorField(cs, 'Stav*', _selectedCondition, () {
                          _showSimpleSelector(
                            context, 'Stav',
                            ['Nový s visačkou', 'Nový bez visačky', 'Velmi dobrý', 'Dobrý', 'Uspokojivý'],
                            (v) => setState(() => _selectedCondition = v),
                          );
                        }),
                        const SizedBox(height: 16),

                        // Velikost
                        _buildSelectorField(cs, 'Velikost', _selectedSize, () {
                          _showSimpleSelector(
                            context, 'Velikost',
                            ['XS', 'S', 'M', 'L', 'XL', 'One size', '15"', '16"', '17"', '18"'],
                            (v) => setState(() => _selectedSize = v),
                          );
                        }),
                        const SizedBox(height: 16),

                        // Barva
                        _buildSelectorField(cs, 'Barva', _selectedColor, () {
                          _showSimpleSelector(
                            context, 'Barva',
                            ['Černá', 'Hnědá', 'Bílá', 'Modrá', 'Červená', 'Zelená', 'Šedá', 'Béžová'],
                            (v) => setState(() => _selectedColor = v),
                          );
                        }),
                        const SizedBox(height: 16),

                        // Materiál
                        _buildSelectorField(cs, 'Materiál', _selectedMaterial, () {
                          _showSimpleSelector(
                            context, 'Materiál',
                            ['Kůže', 'Syntetika', 'Bavlna', 'Vlna', 'Fleece', 'Neopren'],
                            (v) => setState(() => _selectedMaterial = v),
                          );
                        }),
                        const SizedBox(height: 24),

                        // Cena*
                        TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          style: _inputTextStyle(cs),
                          decoration: const InputDecoration(
                            labelText: 'Cena*',
                            suffixText: '€',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.verified_user, size: 16, color: cs.surfaceTint),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Ochrana kupujícího bude automaticky přidána k ceně',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: cs.tertiary,
                                  letterSpacing: 0.4,
                                  height: 16 / 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Vytvořit inzerát',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileUpload(ColorScheme cs) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh,
          border: Border.all(color: cs.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/Add.svg',
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(cs.onSurface, BlendMode.srcIn),
              ),
              const SizedBox(height: 12),
              Text(
                'Klepněte pro nahrání',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.surfaceTint,
                  letterSpacing: 0.25,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'SVG, PNG, JPG nebo GIF (max. 800x400px)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: cs.tertiary,
                  letterSpacing: 0.4,
                  height: 16 / 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorField(ColorScheme cs, String label, String? value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
        ),
        child: Text(
          value ?? '',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: value != null ? cs.onSurface : Colors.transparent,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  TextStyle _inputTextStyle(ColorScheme cs) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: cs.onSurface,
    );
  }

  void _showSimpleSelector(
    BuildContext context,
    String title,
    List<String> options,
    void Function(String) onSelect,
  ) {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                ),
              ),
            ),
            Divider(color: cs.outline, height: 1),
            ...options.map((option) => ListTile(
              title: Text(
                option,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                ),
              ),
              onTap: () {
                onSelect(option);
                Navigator.pop(context);
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
