import 'package:flutter/material.dart';
import 'package:eqqu/theme/theme_notifier.dart';
import 'package:eqqu/utils/language_notifier.dart';

/// Provides app-wide state (theme & language) to the widget tree.
///
/// Usage: `AppState.of(context).themeNotifier`
class AppState extends InheritedWidget {
  final ThemeNotifier themeNotifier;
  final LanguageNotifier languageNotifier;

  const AppState({
    super.key,
    required this.themeNotifier,
    required this.languageNotifier,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(result != null, 'No AppState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) =>
      themeNotifier != oldWidget.themeNotifier ||
      languageNotifier != oldWidget.languageNotifier;
}
