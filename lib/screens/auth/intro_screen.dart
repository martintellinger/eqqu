import 'package:flutter/material.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/routes.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/utils/blur_overlay.dart';
import 'package:country_flags/country_flags.dart';
import 'package:eqqu/app_state.dart';
import 'package:eqqu/utils/language_notifier.dart';
import 'package:eqqu/widgets/sheet_helpers.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentImageIndex = 0;
  late final List<String> _bgImages;
  LanguageNotifier? _languageNotifier;

  static const _allBgImages = [
    'assets/images/bg_default.png',
    'assets/images/bg_europe.png',
    'assets/images/bg_france.png',
    'assets/images/bg_italy.png',
    'assets/images/bg_uk.png',
    'assets/images/bg_usa.png',
  ];

  bool _imagesPrecached = false;

  @override
  void initState() {
    super.initState();
    _bgImages = [
      _allBgImages[0],
      ...(List.from(_allBgImages.sublist(1))..shuffle()),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageNotifier?.removeListener(_onLanguageChanged);
    _languageNotifier = AppState.of(context).languageNotifier;
    _languageNotifier!.addListener(_onLanguageChanged);
    if (!_imagesPrecached) {
      _imagesPrecached = true;
      Future.wait(
        _bgImages.map((path) => precacheImage(AssetImage(path), context)),
      ).then((_) {
        if (mounted) _startImageCycling();
      }).catchError((_) {
        // Start cycling even if some images fail to precache
        if (mounted) _startImageCycling();
      });
    }
  }

  void _startImageCycling() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _bgImages.length;
      });
      _startImageCycling();
    });
  }

  @override
  void dispose() {
    _languageNotifier?.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() => setState(() {});

  void _showLanguageSheet() {
    final s = AppStrings.of(context);
    final langNotifier = AppState.of(context).languageNotifier;
    String selected = langNotifier.selectedCode;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: kBlurBarrierColor,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
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
                  buildDragHandle(Theme.of(ctx).colorScheme, color: Colors.white24),
                  Text(
                    s.languageSlashLanguage,
                    style: AppTextStyles.sectionTitle(Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ...LanguageNotifier.languages.map((lang) {
                    final isSelected = lang.code == selected;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          setSheetState(() => selected = lang.code);
                          langNotifier.setLanguage(lang.code);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Theme.of(ctx).colorScheme.surfaceTint : Colors.white24,
                              width: isSelected ? 2 : 1,
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
                                    color: isSelected ? Theme.of(ctx).colorScheme.surfaceTint : Colors.white24,
                                    width: isSelected ? 6 : 2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              CountryFlag.fromCountryCode(
                                lang.countryCode,
                                width: 24,
                                height: 24,
                                shape: const Circle(),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                lang.name,
                                style: AppTextStyles.selectableOption(
                                  color: isSelected ? Theme.of(ctx).colorScheme.surfaceTint : Colors.white,
                                  isSelected: isSelected,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with cross-fade (no white flash)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1500),
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            child: Image.asset(
              _bgImages[_currentImageIndex],
              key: ValueKey(_currentImageIndex),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
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
                    Semantics(
                      button: true,
                      label: AppStrings.of(context).languageSlashLanguage,
                      child: GestureDetector(
                      onTap: _showLanguageSheet,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.expand_more, color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            AppState.of(context).languageNotifier.selectedCode.toUpperCase(),
                            style: AppTextStyles.actionLink(Colors.white),
                          ),
                        ],
                      ),
                    ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        s.skip,
                        style: AppTextStyles.actionLink(Colors.white).copyWith(height: null),
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
                Text(
                  s.introTitle,
                  style: AppTextStyles.outfit(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 44 / 36,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Subtitle
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    s.introSubtitle,
                    style: AppTextStyles.labelMedium(Colors.white),
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
                      Navigator.pushNamed(context, AppRoutes.registration);
                    },
                    style: null,
                    child: Text(
                      s.registration,
                      style: AppTextStyles.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Přihlášení button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    s.login,
                    style: AppTextStyles.actionLink(Colors.white).copyWith(height: null),
                  ),
                ),
                const SizedBox(height: 16),
                // Page indicator dots (reflect current background image)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_bgImages.length, (i) => Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 4 : 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: i == _currentImageIndex ? 32 : 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: i == _currentImageIndex ? 1.0 : 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
