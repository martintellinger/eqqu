import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class MimoStajScreen extends StatefulWidget {
  const MimoStajScreen({super.key});

  @override
  State<MimoStajScreen> createState() => _MimoStajScreenState();
}

class _MimoStajScreenState extends State<MimoStajScreen> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: const AppHeader(title: 'Mimo stáj', showBack: true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: cs.secondary,
                      letterSpacing: 0.5,
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mimo stáj',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: cs.secondary,
                              letterSpacing: 0.15,
                              height: 24 / 16,
                            ),
                          ),
                        ),
                        Switch(
                          value: _enabled,
                          onChanged: (v) {
                            setState(() => _enabled = v);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  v ? 'Mimo stáj zapnuto' : 'Mimo stáj vypnuto',
                                  style: const TextStyle(fontFamily: 'Poppins'),
                                ),
                                backgroundColor: cs.primary,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          activeColor: Colors.white,
                          activeTrackColor: cs.primary,
                          inactiveThumbColor: cs.onSurfaceVariant,
                          inactiveTrackColor: cs.surfaceContainerHighest,
                          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) return Colors.transparent;
                            return cs.onSurfaceVariant;
                          }),
                        ),
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
}
