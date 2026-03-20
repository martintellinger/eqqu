import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/widgets/app_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          // M3 App bar
          const AppHeader(title: 'Profil'),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile card
                    _buildProfileCard(cs),
                    const SizedBox(height: 24),

                    // Menu group 1
                    _buildMenuItem(cs, 'assets/icons/moje inzeraty.svg', 'Moje inzeráty'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje nakupy.svg', 'Moje nákupy'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje prodeje.svg', 'Moje prodeje'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/oblibene predmety.svg', 'Oblíbené předměty'),
                    const SizedBox(height: 24),

                    // Menu group 2
                    _buildMenuItem(cs, 'assets/icons/mimo staj.svg', 'Mimo stáj'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/pozvat.svg', 'Pozvat přátele'),
                    const SizedBox(height: 24),

                    // Menu group 3
                    _buildMenuItem(cs, 'assets/icons/jak funguje.svg', 'Mimo stáj'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/napoveda.svg', 'Nápověda'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/zpetna vazba.svg', 'Zpětná vazba'),
                    const SizedBox(height: 24),

                    // Menu group 4
                    _buildMenuItem(cs, 'assets/icons/nastaveni.svg', 'Nastavení'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/o nas.svg', 'O nás'),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/eqqu platforma.svg', 'EQQU Platforma'),
                    const SizedBox(height: 24),

                    // Logout button
                    _buildLogoutButton(context, cs),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(ColorScheme cs) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: avatar + name + stars
          Expanded(
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/avatar_1.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Emma Novak',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: cs.secondary,
                    height: 28 / 20,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: Color(0xFFFFD700))),
                    Icon(Icons.star_border, size: 20, color: cs.tertiary),
                    const SizedBox(width: 8),
                    Text(
                      '4.2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: cs.tertiary,
                        letterSpacing: 0.15,
                        height: 24 / 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right: stats stacked vertically
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatItem(cs, '3', 'Aktivních inzerátů', showBottomBorder: true),
                _buildStatItem(cs, '15', 'Prodaných inzerátů', showBottomBorder: true),
                _buildStatItem(cs, '12', 'hodnocení', showBottomBorder: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(ColorScheme cs, String value, String label, {required bool showBottomBorder}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: showBottomBorder ? 8 : 0,
        top: showBottomBorder ? 0 : 8,
      ),
      decoration: showBottomBorder
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: cs.outlineVariant, width: 1),
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: cs.secondary,
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

  Widget _buildMenuItem(ColorScheme cs, String svgPath, String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(cs.onSurface, BlendMode.srcIn),
                ),
                const SizedBox(width: 12),
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
                Icon(Icons.chevron_right, size: 20, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ColorScheme cs) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 24, color: cs.secondary),
            const SizedBox(width: 8),
            Text(
              'Odhlásit se',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.secondary,
                letterSpacing: 0.15,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
