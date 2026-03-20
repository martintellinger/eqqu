import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar + stats
            _buildProfileHeader(cs),
            const SizedBox(height: 24),

            // Menu groups
            _buildMenuGroup(cs, [
              _MenuItem('assets/icons/moje inzeraty.svg', 'Moje inzeráty'),
              _MenuItem('assets/icons/moje nakupy.svg', 'Moje nákupy'),
              _MenuItem('assets/icons/moje prodeje.svg', 'Moje prodeje'),
              _MenuItem('assets/icons/oblibene predmety.svg', 'Oblíbené předměty'),
              _MenuItem('assets/icons/mimo staj.svg', 'Mimo stáj'),
            ]),
            const SizedBox(height: 16),

            _buildMenuGroup(cs, [
              _MenuItem('assets/icons/pozvat.svg', 'Pozvat přátele'),
              _MenuItem('assets/icons/jak funguje.svg', 'Jak funguje'),
              _MenuItem('assets/icons/napoveda.svg', 'Nápověda'),
              _MenuItem('assets/icons/zpetna vazba.svg', 'Zpětná vazba'),
            ]),
            const SizedBox(height: 16),

            _buildMenuGroup(cs, [
              _MenuItem('assets/icons/nastaveni.svg', 'Nastavení'),
              _MenuItem('assets/icons/o nas.svg', 'O nás'),
              _MenuItem('assets/icons/eqqu platforma.svg', 'EQQU Platforma'),
            ]),
            const SizedBox(height: 24),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Odhlásit se',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: cs.error,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ColorScheme cs) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: cs.primary,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'EN',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Name
        Text(
          'Emma Novak',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
            height: 32 / 24,
          ),
        ),
        const SizedBox(height: 4),
        // Stars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: Color(0xFFFFD700))),
            Icon(Icons.star_border, size: 20, color: cs.tertiary),
            const SizedBox(width: 8),
            Text(
              '4.2',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Stats row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              _buildStat(cs, '12', 'Aktivní'),
              _buildStatDivider(cs),
              _buildStat(cs, '8', 'Prodané'),
              _buildStatDivider(cs),
              _buildStat(cs, '24', 'Hodnocení'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStat(ColorScheme cs, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
              height: 28 / 20,
            ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider(ColorScheme cs) {
    return Container(
      width: 1,
      height: 32,
      color: cs.outline,
    );
  }

  Widget _buildMenuGroup(ColorScheme cs, List<_MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return Column(
              children: [
                if (i > 0) Divider(color: cs.outline, height: 1, indent: 52),
                ListTile(
                  leading: SvgPicture.asset(
                    item.svgPath,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(cs.onSurface, BlendMode.srcIn),
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurface,
                      letterSpacing: 0.15,
                      height: 24 / 16,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: cs.tertiary, size: 20),
                  onTap: () {},
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String svgPath;
  final String label;
  const _MenuItem(this.svgPath, this.label);
}
