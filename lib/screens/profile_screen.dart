import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/widgets/app_header.dart';
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SellerProfileScreen(),
                          ),
                        );
                      },
                      child: _buildProfileCard(cs),
                    ),
                    const SizedBox(height: 24),

                    // Menu group 1
                    _buildMenuItem(cs, 'assets/icons/moje_inzeraty.svg', 'Moje inzeráty', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyListingsScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje_nakupy.svg', 'Moje nákupy', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPurchasesScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/moje_prodeje.svg', 'Moje prodeje', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MySalesScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/oblibene_predmety.svg', 'Oblíbené předměty'),
                    const SizedBox(height: 24),

                    // Menu group 2
                    _buildMenuItem(cs, 'assets/icons/mimo_staj.svg', 'Mimo stáj', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MimoStajScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/pozvat.svg', 'Pozvat přátele', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const InviteFriendsScreen()));
                    }),
                    const SizedBox(height: 24),

                    // Menu group 3
                    _buildMenuItem(cs, 'assets/icons/jak_funguje.svg', 'Jak to funguje', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HowItWorksScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/napoveda.svg', 'Nápověda', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/zpetna_vazba.svg', 'Zpětná vazba', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen()));
                    }),
                    const SizedBox(height: 24),

                    // Menu group 4
                    _buildMenuItem(cs, 'assets/icons/nastaveni.svg', 'Nastavení', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/o_nas.svg', 'O nás', onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                    }),
                    const SizedBox(height: 12),
                    _buildMenuItem(cs, 'assets/icons/eqqu_platforma.svg', 'EQQU Platforma', onTap: () {
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
