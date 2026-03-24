import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/theme/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          // M3 App bar
          AppHeader(title: s.profile),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile card
                    Semantics(
                      label: s.profile,
                      button: true,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.sellerProfile);
                        },
                        child: _buildProfileCard(cs, s),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Menu group 1
                    _buildMenuItem(cs, 'assets/icons/moje_inzeraty.svg', s.myListings, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.myListings);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje_nakupy.svg', s.myPurchases, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.myPurchases);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje_prodeje.svg', s.mySales, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mySales);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/oblibene_predmety.svg', s.favoriteItems, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.favorites);
                    }),
                    const SizedBox(height: 24),

                    // Menu group 2
                    _buildMenuItem(cs, 'assets/icons/mimo_staj.svg', s.offStable, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mimoStaj);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/pozvat.svg', s.inviteFriends, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.inviteFriends);
                    }),
                    const SizedBox(height: 24),

                    // Menu group 3
                    _buildMenuItem(cs, 'assets/icons/jak_funguje.svg', s.howItWorks, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.howItWorks);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/napoveda.svg', s.help, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.help);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/zpetna_vazba.svg', s.feedback, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.feedback);
                    }),
                    const SizedBox(height: 24),

                    // Menu group 4
                    _buildMenuItem(cs, 'assets/icons/nastaveni.svg', s.settings, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.settings);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/o_nas.svg', s.about, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.about);
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/eqqu_platforma.svg', s.eqquPlatform, onTap: () {
                      Navigator.pushNamed(context, AppRoutes.eqquPlatform);
                    }),
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

  Widget _buildProfileCard(ColorScheme cs, AppStrings s) {
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
                    cacheWidth: 240,
                    cacheHeight: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Emma Novak',
                  style: AppTextStyles.sectionTitle(cs.secondary),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(4, (_) => Icon(Icons.star, size: 20, color: AppConstants.starColor, semanticLabel: s.rating)),
                    Icon(Icons.star_border, size: 20, color: cs.tertiary, semanticLabel: s.rating),
                    const SizedBox(width: 8),
                    Text(
                      '4.2',
                      style: AppTextStyles.labelMedium(cs.tertiary),
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
                _buildStatItem(cs, '3', s.activeListings, showBottomBorder: true),
                _buildStatItem(cs, '15', s.soldListings, showBottomBorder: true),
                _buildStatItem(cs, '12', s.ratingsCount, showBottomBorder: false),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
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
            style: AppTextStyles.sectionTitle(cs.secondary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.labelSmall(cs.tertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(ColorScheme cs, String svgPath, String label, {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Semantics(
        label: label,
        button: true,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            hoverColor: const Color(0x14006535),
            splashColor: const Color(0x14006535),
            highlightColor: const Color(0x14006535),
            onTap: onTap ?? () {},
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
                      style: AppTextStyles.bodyLarge(cs.onSurface),
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 20, color: cs.onSurfaceVariant, semanticLabel: ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ColorScheme cs) {
    final s = AppStrings.of(context);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 24, color: cs.secondary, semanticLabel: s.logout),
            const SizedBox(width: 8),
            Text(
              s.logout,
              style: AppTextStyles.productTitle(cs.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
