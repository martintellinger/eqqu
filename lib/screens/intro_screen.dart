import 'package:flutter/material.dart';
import 'package:eqqu/utils/blur_overlay.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String _selectedLang = 'CZ';

  static const _languages = [
    {'code': 'CZ', 'name': 'Čeština'},
    {'code': 'EN', 'name': 'English'},
    {'code': 'DE', 'name': 'Deutsch'},
    {'code': 'FR', 'name': 'Français'},
  ];

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: kBlurBarrierColor,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Text(
                  'Jazyk / Language',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 28 / 20,
                  ),
                ),
                const SizedBox(height: 16),
                ..._languages.map((lang) {
                  final selected = _selectedLang == lang['code'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedLang = lang['code']!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selected ? const Color(0xFF85D89C) : Colors.white24,
                            width: selected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected ? const Color(0xFF85D89C) : Colors.white24,
                                  width: selected ? 6 : 2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              lang['name']!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                                color: selected ? const Color(0xFF85D89C) : Colors.white,
                                letterSpacing: 0.5,
                                height: 24 / 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              lang['code']!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white54,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with gradient overlay
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Gradient overlay: transparent top → black bottom
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0x99000000),
                ],
                stops: [0.0, 0.55, 0.75],
              ),
            ),
          ),

          // Top buttons: EN (left) and Skip (right)
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: _showLanguageSheet,
                      icon: const Icon(
                        Icons.language,
                        size: 20,
                        color: Colors.white,
                      ),
                      label: Text(
                        _selectedLang,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.1,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom content
          Positioned(
            left: 16,
            right: 16,
            bottom: 40,
            child: Column(
              children: [
                // Title
                const Text(
                  'RIDER TO RIDER',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 44 / 36,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Subtitle
                const Opacity(
                  opacity: 0.8,
                  child: Text(
                    'Your tack is someones gold! Pass it on and find your favorite one.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 24 / 16,
                      letterSpacing: 0.15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                // Registrace button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF006535),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Registrace',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Přihlášení button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'Přihlášení',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Page indicator dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(isActive: true),
                    const SizedBox(width: 4),
                    _buildDot(isActive: false),
                    const SizedBox(width: 4),
                    _buildDot(isActive: false),
                    const SizedBox(width: 4),
                    _buildDot(isActive: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 32 : 4,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
