import 'package:flutter/material.dart';
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
          // App bar
          SafeArea(
            bottom: false,
            child: Padding(
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
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Divider(color: cs.outline, height: 1),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo upload area
                  _buildPhotoUpload(cs),
                  const SizedBox(height: 24),

                  // Name
                  _buildLabel(cs, 'Název'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    style: _inputTextStyle(cs),
                    decoration: _inputDecoration('Zadejte název produktu'),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  _buildLabel(cs, 'Popis'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    style: _inputTextStyle(cs),
                    maxLines: 4,
                    decoration: _inputDecoration('Popište produkt'),
                  ),
                  const SizedBox(height: 16),

                  // Category
                  _buildLabel(cs, 'Kategorie'),
                  const SizedBox(height: 8),
                  _buildSelector(cs, _selectedCategory ?? 'Vyberte kategorii', () {
                    showCategoriesSheet(context);
                  }),
                  const SizedBox(height: 16),

                  // Brand
                  _buildLabel(cs, 'Značka'),
                  const SizedBox(height: 8),
                  _buildSelector(cs, _selectedBrand ?? 'Vyberte značku', () {
                    _showSimpleSelector(
                      context, cs, 'Značka',
                      ['No brand', 'Cavalleria Toscana', 'Animo', 'Kingsland', 'Shires', 'Busse', 'Eskadron', 'HKM'],
                      (v) => setState(() => _selectedBrand = v),
                    );
                  }),
                  const SizedBox(height: 16),

                  // Condition
                  _buildLabel(cs, 'Stav'),
                  const SizedBox(height: 8),
                  _buildSelector(cs, _selectedCondition ?? 'Vyberte stav', () {
                    _showSimpleSelector(
                      context, cs, 'Stav',
                      ['Nový s visačkou', 'Nový bez visačky', 'Velmi dobrý', 'Dobrý', 'Uspokojivý'],
                      (v) => setState(() => _selectedCondition = v),
                    );
                  }),
                  const SizedBox(height: 16),

                  // Size
                  _buildLabel(cs, 'Velikost'),
                  const SizedBox(height: 8),
                  _buildSelector(cs, _selectedSize ?? 'Vyberte velikost', () {
                    _showSimpleSelector(
                      context, cs, 'Velikost',
                      ['XS', 'S', 'M', 'L', 'XL', 'One size', '15"', '16"', '17"', '18"'],
                      (v) => setState(() => _selectedSize = v),
                    );
                  }),
                  const SizedBox(height: 16),

                  // Color
                  _buildLabel(cs, 'Barva'),
                  const SizedBox(height: 8),
                  _buildSelector(cs, _selectedColor ?? 'Vyberte barvu', () {
                    _showSimpleSelector(
                      context, cs, 'Barva',
                      ['Černá', 'Hnědá', 'Bílá', 'Modrá', 'Červená', 'Zelená', 'Šedá', 'Béžová'],
                      (v) => setState(() => _selectedColor = v),
                    );
                  }),
                  const SizedBox(height: 16),

                  // Material
                  _buildLabel(cs, 'Materiál'),
                  const SizedBox(height: 8),
                  _buildSelector(cs, _selectedMaterial ?? 'Vyberte materiál', () {
                    _showSimpleSelector(
                      context, cs, 'Materiál',
                      ['Kůže', 'Syntetika', 'Bavlna', 'Vlna', 'Fleece', 'Neopren'],
                      (v) => setState(() => _selectedMaterial = v),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Price section
                  _buildLabel(cs, 'Cena'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    style: _inputTextStyle(cs),
                    decoration: _inputDecoration('0 €'),
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
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoUpload(ColorScheme cs) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_alt_outlined, size: 24, color: cs.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Přidat fotky',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.onSurface,
                letterSpacing: 0.1,
                height: 20 / 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Až 10 fotografií',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: cs.tertiary,
                letterSpacing: 0.4,
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(ColorScheme cs, String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: cs.onSurface,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),
    );
  }

  Widget _buildSelector(ColorScheme cs, String text, VoidCallback onTap) {
    final isPlaceholder = text.startsWith('Vyberte');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: cs.outline),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isPlaceholder ? cs.onSurfaceVariant : cs.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 24, color: cs.onSurface),
          ],
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
    );
  }

  void _showSimpleSelector(
    BuildContext context,
    ColorScheme cs,
    String title,
    List<String> options,
    void Function(String) onSelect,
  ) {
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
