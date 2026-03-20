import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with gradient overlay
          Image.asset(
            'assets/background.jpg',
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
                      onPressed: () {
                        // TODO: Language selection
                      },
                      icon: const Icon(
                        Icons.language,
                        size: 20,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'EN',
                        style: TextStyle(
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
                        Navigator.pushReplacementNamed(context, '/registration');
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
                      Navigator.pushReplacementNamed(context, '/registration');
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
                    Navigator.pushReplacementNamed(context, '/login');
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
