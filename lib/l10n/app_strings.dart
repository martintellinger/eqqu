// Centralized UI strings for localization.
//
// Usage:
//   final s = AppStrings.of(context);
//   Text(s.home)
//
// To add a new language, add a map to [_translations] and register
// the language in LanguageNotifier.languages.

import 'package:flutter/material.dart';
import 'package:eqqu/app_state.dart';

class AppStrings {
  final String _langCode;

  AppStrings._(this._langCode);

  /// Resolves strings for the current language from [AppState].
  factory AppStrings.of(BuildContext context) {
    final code = AppState.of(context).languageNotifier.selectedCode;
    return AppStrings._(code);
  }

  String _t(String key) {
    final map = _translations[_langCode] ?? _translations['cs']!;
    return map[key] ?? _translations['cs']![key] ?? key;
  }

  // ── Navigation ──
  String get home => _t('home');
  String get chat => _t('chat');
  String get sell => _t('sell');
  String get favorites => _t('favorites');
  String get profile => _t('profile');

  // ── Auth ──
  String get login => _t('login');
  String get registration => _t('registration');
  String get forgotPassword => _t('forgotPassword');
  String get logout => _t('logout');
  String get email => _t('email');
  String get password => _t('password');
  String get continueWithoutLogin => _t('continueWithoutLogin');
  String get continueWithoutRegistration => _t('continueWithoutRegistration');
  String get alreadyHaveAccount => _t('alreadyHaveAccount');
  String get createAccount => _t('createAccount');
  String get sendResetLink => _t('sendResetLink');
  String get rememberPassword => _t('rememberPassword');

  // ── Settings ──
  String get settings => _t('settings');
  String get accountSettings => _t('accountSettings');
  String get payments => _t('payments');
  String get shipping => _t('shipping');
  String get secureAccount => _t('secureAccount');
  String get notifications => _t('notifications');
  String get language => _t('language');
  String get appearance => _t('appearance');
  String get appLanguage => _t('appLanguage');

  // ── Theme ──
  String get lightMode => _t('lightMode');
  String get darkMode => _t('darkMode');
  String get systemMode => _t('systemMode');

  // ── Product / Commerce ──
  String get cart => _t('cart');
  String get products => _t('products');
  String get productPrice => _t('productPrice');
  String get totalPrice => _t('totalPrice');
  String get buyerProtection => _t('buyerProtection');
  String get moreFromSeller => _t('moreFromSeller');
  String get messageSeller => _t('messageSeller');
  String get buy => _t('buy');
  String get search => _t('search');
  String get featured => _t('featured');

  // ── Listings ──
  String get myListings => _t('myListings');
  String get myPurchases => _t('myPurchases');
  String get mySales => _t('mySales');
  String get newListing => _t('newListing');
  String get basicInfo => _t('basicInfo');

  // ── Filters ──
  String get filter => _t('filter');
  String get save => _t('save');
  String get saveFilters => _t('saveFilters');
  String get sortBy => _t('sortBy');
  String get category => _t('category');
  String get subcategory => _t('subcategory');
  String get price => _t('price');
  String get priceRange => _t('priceRange');
  String get condition => _t('condition');
  String get size => _t('size');
  String get brand => _t('brand');
  String get gender => _t('gender');
  String get color => _t('color');
  String get material => _t('material');

  // ── Profile ──
  String get sellerProfile => _t('sellerProfile');
  String get listings => _t('listings');
  String get follow => _t('follow');
  String get following => _t('following');
  String get reviews => _t('reviews');
  String get rating => _t('rating');

  // ── Info pages ──
  String get about => _t('about');
  String get howItWorks => _t('howItWorks');
  String get help => _t('help');
  String get feedback => _t('feedback');
  String get inviteFriends => _t('inviteFriends');
  String get eqquPlatform => _t('eqquPlatform');
  String get offStable => _t('offStable');

  // ── Misc ──
  String get writeMessage => _t('writeMessage');
  String get changePassword => _t('changePassword');
  String get address => _t('address');
  String get order => _t('order');
  String get all => _t('all');
  String get active => _t('active');
  String get completed => _t('completed');
  String get newStatus => _t('newStatus');
  String get noFavoritesYet => _t('noFavoritesYet');
  String get buildSet => _t('buildSet');
  String get reserve => _t('reserve');
  String get hide => _t('hide');
  String get shareLink => _t('shareLink');
  String get wrongCategory => _t('wrongCategory');
  String get contactUs => _t('contactUs');
  String get changesSaved => _t('changesSaved');
  String get skip => _t('skip');

  // ── Translations ──
  static const _translations = <String, Map<String, String>>{
    'cs': {
      'home': 'Domů',
      'chat': 'Chat',
      'sell': 'Prodat',
      'favorites': 'Oblíbené',
      'profile': 'Profil',
      'login': 'Přihlášení',
      'registration': 'Registrace',
      'forgotPassword': 'Zapomenuté heslo',
      'logout': 'Odhlásit se',
      'email': 'E-mail',
      'password': 'Heslo',
      'continueWithoutLogin': 'Pokračovat bez přihlášení',
      'continueWithoutRegistration': 'Pokračovat bez registrace',
      'alreadyHaveAccount': 'Již máte účet?',
      'createAccount': 'Vytvořte si ho',
      'sendResetLink': 'Odeslat',
      'rememberPassword': 'Pamatujete si heslo?',
      'settings': 'Nastavení',
      'accountSettings': 'Nastavení účtu',
      'payments': 'Platby',
      'shipping': 'Přeprava',
      'secureAccount': 'Bezpečný účet',
      'notifications': 'Oznámení',
      'language': 'Jazyk',
      'appearance': 'Vzhled',
      'appLanguage': 'Jazyk aplikace',
      'lightMode': 'Light mode',
      'darkMode': 'Dark mode',
      'systemMode': 'Podle systému',
      'cart': 'Košík',
      'products': 'Produkty',
      'productPrice': 'Cena zboží',
      'totalPrice': 'Celková cena',
      'buyerProtection': 'Včetně ochrany kupujícího',
      'moreFromSeller': 'Další od tohoto prodejce',
      'messageSeller': 'Napsat prodejci',
      'buy': 'Koupit',
      'search': 'Hledat',
      'featured': 'Doporučené',
      'myListings': 'Moje inzeráty',
      'myPurchases': 'Moje nákupy',
      'mySales': 'Moje prodeje',
      'newListing': 'Nový inzerát',
      'basicInfo': 'Základní informace',
      'filter': 'Filtr',
      'save': 'Uložit',
      'saveFilters': 'Uložit filtry',
      'sortBy': 'Řadit podle',
      'category': 'Kategorie',
      'subcategory': 'Podkategorie',
      'price': 'Cena',
      'priceRange': 'Cenové rozpětí',
      'condition': 'Stav zboží',
      'size': 'Velikost',
      'brand': 'Značka',
      'gender': 'Pohlaví',
      'color': 'Barva',
      'material': 'Materiál',
      'sellerProfile': 'Profil prodejce',
      'listings': 'Inzeráty',
      'follow': 'Sledovat',
      'following': 'Sledujete',
      'reviews': 'Hodnocení',
      'rating': 'Hodnocení',
      'about': 'O nás',
      'howItWorks': 'Jak to funguje',
      'help': 'Nápověda',
      'feedback': 'Zpětná vazba',
      'inviteFriends': 'Pozvat přátele',
      'eqquPlatform': 'Platforma EQQU',
      'offStable': 'Mimo stáj',
      'writeMessage': 'Napište zprávu',
      'changePassword': 'Změna hesla',
      'address': 'Adresa',
      'order': 'Objednávka',
      'all': 'Vše',
      'active': 'Aktivní',
      'completed': 'Dokončené',
      'newStatus': 'Nové',
      'noFavoritesYet': 'Zatím nemáte žádné oblíbené',
      'buildSet': 'Sestavit sadu',
      'reserve': 'Rezervovat',
      'hide': 'Skrýt',
      'shareLink': 'Sdílet odkaz',
      'wrongCategory': 'Nenašel jsi správnou kategorii?',
      'contactUs': 'Napiš nám',
      'changesSaved': 'Změny byly uloženy',
      'skip': 'Skip',
    },
    'en': {
      'home': 'Home',
      'chat': 'Chat',
      'sell': 'Sell',
      'favorites': 'Favorites',
      'profile': 'Profile',
      'login': 'Login',
      'registration': 'Registration',
      'forgotPassword': 'Forgotten password',
      'logout': 'Log out',
      'email': 'Email',
      'password': 'Password',
      'continueWithoutLogin': 'Continue without login',
      'continueWithoutRegistration': 'Continue without registration',
      'alreadyHaveAccount': 'Already have an account?',
      'createAccount': 'Create one',
      'sendResetLink': 'Send',
      'rememberPassword': 'Remember your password?',
      'settings': 'Settings',
      'accountSettings': 'Account settings',
      'payments': 'Payments',
      'shipping': 'Shipping',
      'secureAccount': 'Secure account',
      'notifications': 'Notifications',
      'language': 'Language',
      'appearance': 'Appearance',
      'appLanguage': 'App language',
      'lightMode': 'Light mode',
      'darkMode': 'Dark mode',
      'systemMode': 'System default',
      'cart': 'Cart',
      'products': 'Products',
      'productPrice': 'Product price',
      'totalPrice': 'Total price',
      'buyerProtection': 'Including buyer protection',
      'moreFromSeller': 'More from this seller',
      'messageSeller': 'Message seller',
      'buy': 'Buy',
      'search': 'Search',
      'featured': 'Featured',
      'myListings': 'My listings',
      'myPurchases': 'My purchases',
      'mySales': 'My sales',
      'newListing': 'New listing',
      'basicInfo': 'Basic information',
      'filter': 'Filter',
      'save': 'Save',
      'saveFilters': 'Save filters',
      'sortBy': 'Sort by',
      'category': 'Category',
      'subcategory': 'Subcategory',
      'price': 'Price',
      'priceRange': 'Price range',
      'condition': 'Condition',
      'size': 'Size',
      'brand': 'Brand',
      'gender': 'Gender',
      'color': 'Color',
      'material': 'Material',
      'sellerProfile': 'Seller profile',
      'listings': 'Listings',
      'follow': 'Follow',
      'following': 'Following',
      'reviews': 'Reviews',
      'rating': 'Rating',
      'about': 'About us',
      'howItWorks': 'How it works',
      'help': 'Help',
      'feedback': 'Feedback',
      'inviteFriends': 'Invite friends',
      'eqquPlatform': 'EQQU Platform',
      'offStable': 'Off stable',
      'writeMessage': 'Write a message',
      'changePassword': 'Change password',
      'address': 'Address',
      'order': 'Order',
      'all': 'All',
      'active': 'Active',
      'completed': 'Completed',
      'newStatus': 'New',
      'noFavoritesYet': 'No favorites yet',
      'buildSet': 'Build set',
      'reserve': 'Reserve',
      'hide': 'Hide',
      'shareLink': 'Share link',
      'wrongCategory': 'Can\'t find the right category?',
      'contactUs': 'Contact us',
      'changesSaved': 'Changes saved',
      'skip': 'Skip',
    },
  };
}
