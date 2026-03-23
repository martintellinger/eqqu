import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/screens/seller_profile_screen.dart';
import 'package:eqqu/screens/my_listings_screen.dart';
import 'package:eqqu/screens/my_sales_screen.dart';
import 'package:eqqu/screens/settings_screen.dart';
import 'package:eqqu/screens/mimo_staj_screen.dart';
import 'package:eqqu/screens/invite_friends_screen.dart';
import 'package:eqqu/screens/how_it_works_screen.dart';
import 'package:eqqu/screens/help_screen.dart';
import 'package:eqqu/screens/feedback_screen.dart';
import 'package:eqqu/screens/about_screen.dart';
import 'package:eqqu/screens/eqqu_platform_screen.dart';
import 'package:eqqu/screens/my_purchases_screen.dart';
import 'package:eqqu/screens/favorites_screen.dart';

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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SellerProfileScreen(),
                          ),
                        );
                      },
                      child: _buildProfileCard(cs, s),
                    ),
                    const SizedBox(height: 24),

                    // Menu group 1
                    _buildMenuItem(cs, 'assets/icons/moje_inzeraty.svg', s.myListings, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyListingsScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje_nakupy.svg', s.myPurchases, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPurchasesScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje_prodeje.svg', s.mySales, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MySalesScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/oblibene_predmety.svg', s.favoriteItems, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
                    }),
                    const SizedBox(height: 24),

                    // Menu group 2
                    _buildMenuItem(cs, 'assets/icons/mimo_staj.svg', s.offStable, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MimoStajScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/pozvat.svg', s.inviteFriends, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const InviteFriendsScreen()));
                    }),
                    const SizedBox(height: 24),

                    // Menu group 3
                    _buildMenuItem(cs, 'assets/icons/jak_funguje.svg', s.howItWorks, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HowItWorksScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/napoveda.svg', s.help, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/zpetna_vazba.svg', s.feedback, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen()));
                    }),
                    const SizedBox(height: 24),

                    // Menu group 4
                    _buildMenuItem(cs, 'assets/icons/nastaveni.svg', s.settings, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/o_nas.svg', s.about, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/eqqu_platforma.svg', s.eqquPlatform, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const EqquPlatformScreen()));
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
                    ...List.generate(4, (_) => const Icon(Icons.star, size: 20, color: Color(0xFFFFD700))),
                    Icon(Icons.star_border, size: 20, color: cs.tertiary),
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
                Icon(Icons.chevron_right, size: 20, color: cs.onSurfaceVariant),
              ],
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
            Icon(Icons.logout, size: 24, color: cs.secondary),
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
