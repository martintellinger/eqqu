# EQQU Architecture

EQQU is a Flutter-based equine marketplace app supporting iOS, Android, and web. Users can browse, buy, and sell horse-related equipment.

## Folder Structure

```
lib/
  main.dart              # App entry point, MultiProvider + MaterialApp setup
  app_state.dart         # InheritedWidget providing ThemeNotifier + LanguageNotifier
  routes.dart            # AppRoutes constants for named navigation

  data/                  # Mock data for development
    mock_products.dart   # Centralized product lists (allProducts, sellerProducts, etc.)

  l10n/                  # Localization
    app_strings.dart     # AppStrings with CS/EN string maps

  models/                # Data models
    product.dart         # Product model with parsedBrand, parsedCondition helpers

  providers/             # ChangeNotifier-based state management
    favorites_provider.dart
    cart_provider.dart
    search_provider.dart

  screens/               # Full-page screens (one per route/navigation target)
    home_screen.dart
    product_detail_screen.dart
    cart_screen.dart
    ...

  services/              # Business logic (pure Dart, no Flutter dependency)
    validators.dart      # Form validation (email, password, card number, etc.)
    cart_service.dart     # Price calculations
    search_service.dart  # Search relevance scoring and filtering

  theme/                 # Theming
    app_theme.dart       # Light/dark ThemeData definitions
    app_text_styles.dart # Centralized text styles (Poppins + Outfit)
    app_constants.dart   # Shared constants (colors, dimensions)
    theme_notifier.dart  # ThemeMode ChangeNotifier

  utils/                 # Utilities
    blur_overlay.dart    # Blur bottom sheet/dialog helpers
    app_snack_bar.dart   # Consistent snackbar helper
    language_notifier.dart

  widgets/               # Reusable widgets shared across screens
    product_card.dart    # Product card with Hero animation
    image_carousel.dart  # Image carousel with page indicators + Hero
    specs_grid.dart      # 2-column specs display
    featured_banner.dart # Promotional banner
    sheet_button.dart    # Bottom sheet action button
    sheet_helpers.dart   # buildDragHandle() for bottom sheets
    price_summary.dart   # Reusable price breakdown rows
    seller_card.dart     # Seller info card with avatar, stars, message CTA
    app_header.dart      # Screen header with back button
    tap_scale_widget.dart
    ...
```

## State Management

The app uses a hybrid approach:

- **Provider** (`MultiProvider` in `main.dart`): `FavoritesProvider`, `CartProvider`, `SearchProvider` for shared state across screens. All screens use Provider for favorites (no local `_favorites` sets).
- **InheritedWidget** (`AppState`): Provides `ThemeNotifier` and `LanguageNotifier` for theme/language switching.
- **Local `setState`**: Used for screen-specific UI state (form inputs, animation controllers, etc.).

Access providers via `context.read<T>()` / `context.watch<T>()` or `Provider.of<T>(context)`.

## Theming

- Material Design 3 with full `ColorScheme` for both light and dark modes.
- `AppTheme.lightTheme` / `AppTheme.darkTheme` defined in `app_theme.dart`.
- Text styles centralized in `AppTextStyles` with named constructors: `sectionTitle()`, `bodyMedium()`, `labelMedium()`, etc.
- Two font families: **Poppins** (UI text) and **Outfit** (brand/logo text).
- Toggle via `ThemeNotifier.toggleTheme()` accessed through `AppState.of(context).themeNotifier`.

## Localization

Manual localization via `AppStrings.of(context)`:
- Returns a `Map<String, String>` of ~135 keys.
- Supports Czech (CS) and English (EN).
- Language switched via `LanguageNotifier`.
- To add a string: add the key to both `_cs` and `_en` maps in `app_strings.dart`.

## Navigation

- Named routes for top-level screens (splash, intro, login, registration, home).
- `Navigator.push` with `MaterialPageRoute` or `PageRouteBuilder` for detail screens.
- Hero animations between product cards and product detail (uses `flightShuttleBuilder` with lerped border radius).

## Testing

```bash
flutter test                    # Run all tests
flutter test test/services/     # Run service tests only
dart analyze lib/               # Static analysis
```

Test structure mirrors `lib/`:
- `test/services/` — Unit tests for validators, cart, search
- `test/providers/` — Unit tests for state providers
- `test/widgets/` — Widget tests for PriceSummary, SellerCard, SheetButton
- `test/models/` — Unit tests for data models

## Adding a New Screen

1. Create `lib/screens/my_screen.dart` with a `StatefulWidget`.
2. If it needs a named route, add constant to `routes.dart` and register in `main.dart`.
3. Use `AppStrings.of(context)` for all user-visible text.
4. Use `Theme.of(context).colorScheme` for colors (never hardcode).
5. Use `AppTextStyles.*()` for text styling.
6. Extract reusable pieces into `lib/widgets/`.
7. Put business logic in `lib/services/`, not in the screen.
