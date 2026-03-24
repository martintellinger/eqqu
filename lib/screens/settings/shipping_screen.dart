import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/settings/address_screen.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.shipping, showBack: true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Text(
                      'Moje adresa',
                      style: AppTextStyles.labelMedium(cs.onSurface),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAddressItem(
                    cs,
                    'Soukenická 4, Praha 110 00 ',
                    Icons.home_outlined,
                    onEdit: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen()));
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAddressItem(
                    cs,
                    'Náměstí Míru 31, Praha 110 00 ',
                    Icons.location_on_outlined,
                    onEdit: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen()));
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Přidat adresu',
                    style: AppTextStyles.productTitle(cs.onPrimary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(ColorScheme cs, String address, IconData icon, {VoidCallback? onEdit}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 24, color: cs.onSurface),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    address,
                    style: AppTextStyles.bodyLarge(cs.onSurface),
                  ),
                ),
                Icon(Icons.edit_outlined, size: 20, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
