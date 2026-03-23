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

  /// Creates an instance for a specific language code (for use without context).
  factory AppStrings.forCode(String code) => AppStrings._(code);

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
  String get noAccountYet => _t('noAccountYet');
  String get loginSuccessful => _t('loginSuccessful');
  String get mustAgreeToTerms => _t('mustAgreeToTerms');
  String get accountCreated => _t('accountCreated');
  String get resetLinkSent => _t('resetLinkSent');
  String get backToLogin => _t('backToLogin');
  String get emailNotArrived => _t('emailNotArrived');
  String get resend => _t('resend');
  String get emailResent => _t('emailResent');
  String get invalidEmail => _t('invalidEmail');

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
  String get including => _t('including');

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
  String get favoriteItems => _t('favoriteItems');
  String get activeListings => _t('activeListings');
  String get soldListings => _t('soldListings');
  String get ratingsCount => _t('ratingsCount');
  String get shareProfile => _t('shareProfile');
  String get editProfile => _t('editProfile');
  String get shareProduct => _t('shareProduct');
  String get reportProduct => _t('reportProduct');
  String get reportProfile => _t('reportProfile');
  String get blockSeller => _t('blockSeller');
  String get unblockSeller => _t('unblockSeller');
  String get blockSellerQuestion => _t('blockSellerQuestion');
  String get sellerBlocked => _t('sellerBlocked');
  String get sellerUnblocked => _t('sellerUnblocked');
  String get reportReason => _t('reportReason');
  String get scamOrSpam => _t('scamOrSpam');
  String get offensiveText => _t('offensiveText');
  String get somethingElse => _t('somethingElse');
  String get describeReason => _t('describeReason');
  String get reportSent => _t('reportSent');

  // ── Info pages ──
  String get about => _t('about');
  String get howItWorks => _t('howItWorks');
  String get help => _t('help');
  String get feedback => _t('feedback');
  String get inviteFriends => _t('inviteFriends');
  String get eqquPlatform => _t('eqquPlatform');
  String get offStable => _t('offStable');
  String get inviteTitle => _t('inviteTitle');
  String get inviteBody => _t('inviteBody');

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
  String get used => _t('used');
  String get buildSet => _t('buildSet');
  String get reserve => _t('reserve');
  String get hide => _t('hide');
  String get shareLink => _t('shareLink');
  String get wrongCategory => _t('wrongCategory');
  String get contactUs => _t('contactUs');
  String get changesSaved => _t('changesSaved');
  String get skip => _t('skip');
  String get back => _t('back');
  String get more => _t('more');
  String get send => _t('send');
  String get cancel => _t('cancel');
  String get delete => _t('delete');
  String get deleteProductQuestion => _t('deleteProductQuestion');
  String get close => _t('close');
  String get edit => _t('edit');
  String get unhide => _t('unhide');
  String get message => _t('message');
  String get linkCopied => _t('linkCopied');
  String get free => _t('free');

  // ── Validators ──
  String get enterEmail => _t('enterEmail');
  String get invalidEmailFormat => _t('invalidEmailFormat');
  String get enterUsername => _t('enterUsername');
  String get minThreeChars => _t('minThreeChars');
  String get enterPassword => _t('enterPassword');
  String get passwordMinSix => _t('passwordMinSix');
  String get confirmPasswordField => _t('confirmPasswordField');
  String get passwordsDoNotMatch => _t('passwordsDoNotMatch');
  String get enterCardNumber => _t('enterCardNumber');
  String get invalidCardNumber => _t('invalidCardNumber');
  String get enterExpiry => _t('enterExpiry');
  String get enterCvc => _t('enterCvc');
  String get invalidCvc => _t('invalidCvc');

  // ── Form labels ──
  String get usernameLabel => _t('usernameLabel');
  String get usernameFieldLabel => _t('usernameFieldLabel');
  String get fullNameLabel => _t('fullNameLabel');
  String get enterFullName => _t('enterFullName');
  String get countryLabel => _t('countryLabel');
  String get dateOfBirthLabel => _t('dateOfBirthLabel');
  String get enterDateOfBirth => _t('enterDateOfBirth');
  String get descriptionLabel => _t('descriptionLabel');
  String get addressLabel => _t('addressLabel');
  String get enterAddress => _t('enterAddress');
  String get phoneLabel => _t('phoneLabel');
  String get enterPhone => _t('enterPhone');
  String get oldPasswordLabel => _t('oldPasswordLabel');
  String get enterOldPassword => _t('enterOldPassword');
  String get newPasswordLabel => _t('newPasswordLabel');
  String get enterNewPassword => _t('enterNewPassword');
  String get newPasswordConfirmLabel => _t('newPasswordConfirmLabel');
  String get confirmNewPassword => _t('confirmNewPassword');
  String get passwordConfirmation => _t('passwordConfirmation');
  String get streetAndNumber => _t('streetAndNumber');
  String get enterStreetNumber => _t('enterStreetNumber');
  String get cityLabel => _t('cityLabel');
  String get enterCity => _t('enterCity');
  String get postalCode => _t('postalCode');
  String get enterPostalCode => _t('enterPostalCode');
  String get countryRequired => _t('countryRequired');
  String get nameRequired => _t('nameRequired');
  String get descriptionRequired => _t('descriptionRequired');
  String get requiredPrice => _t('requiredPrice');
  String get cardNumber => _t('cardNumber');
  String get expiry => _t('expiry');
  String get cvcCvv => _t('cvcCvv');
  String get verbalRating => _t('verbalRating');

  // ── Cart / Order ──
  String get deliveryAddress => _t('deliveryAddress');
  String get personalInfo => _t('personalInfo');
  String get paymentMethod => _t('paymentMethod');
  String get cardPayment => _t('cardPayment');
  String get deliveryMethodLabel => _t('deliveryMethodLabel');
  String get deliveryToAddress => _t('deliveryToAddress');
  String get personalPickup => _t('personalPickup');
  String get bindingOrder => _t('bindingOrder');
  String get cartEmpty => _t('cartEmpty');
  String get addProductsToCart => _t('addProductsToCart');
  String get changeAddress => _t('changeAddress');
  String get saveCardForNext => _t('saveCardForNext');
  String get shippingCost => _t('shippingCost');
  String get buyerProtectionFee => _t('buyerProtectionFee');
  String get totalToPay => _t('totalToPay');
  String get totalPriceLabel => _t('totalPriceLabel');
  String get orderSuccess => _t('orderSuccess');
  String get orderSuccessMessage => _t('orderSuccessMessage');
  String get viewOrder => _t('viewOrder');
  String get productRemovedFromCart => _t('productRemovedFromCart');
  String orderNumber(String id) => '${_t('order')} $id';
  String productsCount(int count) => '${_t('products')} ($count)';

  // ── Order detail ──
  String get rateOrder => _t('rateOrder');
  String get rate => _t('rate');
  String get ratingSubmitted => _t('ratingSubmitted');
  String get statusCompleted => _t('statusCompleted');
  String get statusCancelled => _t('statusCancelled');
  String get statusActive => _t('statusActive');
  String get buyerInfo => _t('buyerInfo');
  String get deliveryAddressLabel => _t('deliveryAddressLabel');
  String get shippingSection => _t('shippingSection');
  String get sellerInfo => _t('sellerInfo');

  // ── Sales statuses ──
  String get statusProcessed => _t('statusProcessed');
  String get statusShipped => _t('statusShipped');
  String get statusDelivered => _t('statusDelivered');
  String get statusPaidOut => _t('statusPaidOut');

  // ── Listing statuses ──
  String get statusSold => _t('statusSold');

  // ── My listings ──
  String get hideAllListings => _t('hideAllListings');
  String get unhideAllListings => _t('unhideAllListings');
  String get reserveFailed => _t('reserveFailed');
  String get reserveFailedMessage => _t('reserveFailedMessage');
  String wasDeleted(String name) => '$name ${_t('wasDeletedSuffix')}';

  // ── Account ──
  String get deleteAccount => _t('deleteAccount');
  String get deleteProfileQuestion => _t('deleteProfileQuestion');
  String get accountDeleted => _t('accountDeleted');
  String get passwordChanged => _t('passwordChanged');
  String get changeYourPassword => _t('changeYourPassword');
  String get changePasswordDesc => _t('changePasswordDesc');
  String get addressSaved => _t('addressSaved');

  // ── Feedback ──
  String get enterMessage => _t('enterMessage');
  String get feedbackSent => _t('feedbackSent');

  // ── Off stable ──
  String get offStableEnabled => _t('offStableEnabled');
  String get offStableDisabled => _t('offStableDisabled');

  // ── New listing ──
  String get buyerProtectionHint => _t('buyerProtectionHint');
  String get createListing => _t('createListing');
  String get listingCreated => _t('listingCreated');
  String get tapToUpload => _t('tapToUpload');
  String get uploadFormats => _t('uploadFormats');

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
      'noAccountYet': 'Ještě nemáte účet?',
      'loginSuccessful': 'Přihlášení bylo úspěšné',
      'mustAgreeToTerms': 'Musíte souhlasit s podmínkami',
      'accountCreated': 'Účet byl úspěšně vytvořen',
      'resetLinkSent': 'Odeslali jsme odkaz pro resetování hesla na zadanou e-mailovou adresu.',
      'backToLogin': 'Zpět na přihlášení',
      'emailNotArrived': 'Nedorazil mail?',
      'resend': 'Poslat znova',
      'emailResent': 'E-mail byl znovu odeslán',
      'invalidEmail': 'Neplatný e-mail',
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
      'including': 'vč.',
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
      'favoriteItems': 'Oblíbené předměty',
      'activeListings': 'Aktivních inzerátů',
      'soldListings': 'Prodaných inzerátů',
      'ratingsCount': 'hodnocení',
      'shareProfile': 'Sdílet profil',
      'editProfile': 'Editovat profil',
      'shareProduct': 'Sdílet produkt',
      'reportProduct': 'Nahlásit produkt',
      'reportProfile': 'Nahlásit profil',
      'blockSeller': 'Zablokovat prodejce',
      'unblockSeller': 'Odblokovat prodejce',
      'blockSellerQuestion': 'Zablokovat prodejce?',
      'sellerBlocked': 'Prodejce byl zablokován',
      'sellerUnblocked': 'Prodejce byl odblokován',
      'reportReason': 'Důvod nahlášení',
      'scamOrSpam': 'Myslím si, že jde o podvod nebo spam',
      'offensiveText': 'Text je urážlivý',
      'somethingElse': 'Něco jiného',
      'describeReason': 'Popište důvod*',
      'reportSent': 'Nahlášení bylo odesláno',
      'about': 'O nás',
      'howItWorks': 'Jak to funguje',
      'help': 'Nápověda',
      'feedback': 'Zpětná vazba',
      'inviteFriends': 'Pozvat přátele',
      'eqquPlatform': 'Platforma EQQU',
      'offStable': 'Mimo stáj',
      'inviteTitle': 'Pozvěte své přátele do EQQU – nejlepší aplikace pro nákup jezdeckých potřeb, kde najdete vše pro vašeho koně na jednom místě.',
      'inviteBody': 'Přidejte se k EQQU a objevte široký výběr kvalitních potřeb pro koně. Pozvěte přátele a užijte si pohodlný nákup s odbornou podporou přímo v aplikaci.',
      'writeMessage': 'Napište zprávu',
      'changePassword': 'Změna hesla',
      'address': 'Adresa',
      'order': 'Objednávka',
      'all': 'Vše',
      'active': 'Aktivní',
      'completed': 'Dokončené',
      'newStatus': 'Nové',
      'noFavoritesYet': 'Zatím nemáte žádné oblíbené',
      'used': 'Použité',
      'buildSet': 'Sestavit sadu',
      'reserve': 'Rezervovat',
      'hide': 'Skrýt',
      'shareLink': 'Sdílet odkaz',
      'wrongCategory': 'Nenašel jsi správnou kategorii?',
      'contactUs': 'Napiš nám',
      'changesSaved': 'Změny byly uloženy',
      'skip': 'Skip',
      'back': 'Zpět',
      'more': 'Více',
      'send': 'Odeslat',
      'cancel': 'Zrušit',
      'delete': 'Smazat',
      'deleteProductQuestion': 'Opravdu chcete smazat tento produkt?',
      'close': 'Zavřít',
      'edit': 'Upravit',
      'unhide': 'Odkrýt',
      'message': 'Zpráva',
      'linkCopied': 'Odkaz byl zkopírován do schránky',
      'free': 'Zdarma',
      // Validators
      'enterEmail': 'Zadejte e-mail',
      'invalidEmailFormat': 'Neplatný formát e-mailu',
      'enterUsername': 'Zadejte uživatelské jméno',
      'minThreeChars': 'Minimálně 3 znaky',
      'enterPassword': 'Zadejte heslo',
      'passwordMinSix': 'Heslo musí mít alespoň 6 znaků',
      'confirmPasswordField': 'Potvrďte heslo',
      'passwordsDoNotMatch': 'Hesla se neshodují',
      'enterCardNumber': 'Zadejte číslo karty',
      'invalidCardNumber': 'Neplatné číslo karty',
      'enterExpiry': 'Zadejte expiraci',
      'enterCvc': 'Zadejte CVC',
      'invalidCvc': 'Neplatný CVC',
      // Form labels
      'usernameLabel': 'Uživatelské jméno*',
      'usernameFieldLabel': 'Uživatelské jméno',
      'fullNameLabel': 'Jméno a příjmení*',
      'enterFullName': 'Zadejte jméno a příjmení',
      'countryLabel': 'Stát*',
      'dateOfBirthLabel': 'Datum narození*',
      'enterDateOfBirth': 'Zadejte datum narození',
      'descriptionLabel': 'Popis',
      'addressLabel': 'Adresa*',
      'enterAddress': 'Zadejte adresu',
      'phoneLabel': 'Telefonní číslo*',
      'enterPhone': 'Zadejte telefonní číslo',
      'oldPasswordLabel': 'Staré heslo',
      'enterOldPassword': 'Zadejte staré heslo',
      'newPasswordLabel': 'Nové heslo',
      'enterNewPassword': 'Zadejte nové heslo',
      'newPasswordConfirmLabel': 'Potvrzení nového hesla',
      'confirmNewPassword': 'Potvrďte nové heslo',
      'passwordConfirmation': 'Potvrzení hesla',
      'streetAndNumber': 'Ulice a čp',
      'enterStreetNumber': 'Zadejte ulici a číslo popisné',
      'cityLabel': 'Město',
      'enterCity': 'Zadejte město',
      'postalCode': 'PSČ',
      'enterPostalCode': 'Zadejte PSČ',
      'countryRequired': 'Stát*',
      'nameRequired': 'Název*',
      'descriptionRequired': 'Popis*',
      'requiredPrice': 'Požadovaná cena*',
      'cardNumber': 'Číslo karty',
      'expiry': 'Expirace',
      'cvcCvv': 'CVC/CVV',
      'verbalRating': 'Slovní hodnocení',
      // Cart / Order
      'deliveryAddress': 'Doručovací adresa',
      'personalInfo': 'Osobní údaje',
      'paymentMethod': 'Způsob platby',
      'cardPayment': 'Platba kartou',
      'deliveryMethodLabel': 'Způsob doručení',
      'deliveryToAddress': 'Doručení na adresu',
      'personalPickup': 'Osobní odběr',
      'bindingOrder': 'Objednávka zavazující k platbě',
      'cartEmpty': 'Košík je prázdný',
      'addProductsToCart': 'Přidejte produkty do košíku a začněte nakupovat.',
      'changeAddress': 'Změnit adresu',
      'saveCardForNext': 'Uložit kartu pro příští nákup',
      'shippingCost': 'Cena dopravy',
      'buyerProtectionFee': 'Poplatek za ochranu kupujícího',
      'totalToPay': 'Celkem k úhradě',
      'totalPriceLabel': 'Cena celkem',
      'orderSuccess': 'Je to tam!',
      'orderSuccessMessage': 'Tvoje objednávka byla úspěšně odeslána.',
      'viewOrder': 'Zobrazit objednávku',
      'productRemovedFromCart': 'Produkt byl odebrán z košíku',
      // Order detail
      'rateOrder': 'Ohodnoťte nákup',
      'rate': 'Ohodnotit',
      'ratingSubmitted': 'Hodnocení bylo odesláno',
      'statusCompleted': 'Dokončeno',
      'statusCancelled': 'Storno',
      'statusActive': 'Aktivní',
      'buyerInfo': 'Informace o kupujícím',
      'deliveryAddressLabel': 'Doručovací adresa:',
      'shippingSection': 'Doprava',
      'sellerInfo': 'Informace o prodejci',
      // Sales statuses
      'statusProcessed': 'Vyřízeno',
      'statusShipped': 'Odesláno',
      'statusDelivered': 'Doručeno',
      'statusPaidOut': 'Vyplaceno',
      // Listing statuses
      'statusSold': 'Prodáno',
      // My listings
      'hideAllListings': 'Skrýt všechny inzeráty',
      'unhideAllListings': 'Odkrýt všechny inzeráty',
      'reserveFailed': 'Rezervace se nezdařila',
      'reserveFailedMessage': 'Nepodařilo se rezervovat inzerát. Zkuste to prosím znovu později.',
      'wasDeletedSuffix': 'byl smazán',
      // Account
      'deleteAccount': 'Smazat účet',
      'deleteProfileQuestion': 'Smazat profil?',
      'accountDeleted': 'Účet byl smazán',
      'passwordChanged': 'Heslo bylo změněno',
      'changeYourPassword': 'Změň si heslo',
      'changePasswordDesc': 'Pro změnu hesla zadej staré heslo a poté nové heslo.',
      'addressSaved': 'Adresa byla uložena',
      // Feedback
      'enterMessage': 'Zadejte zprávu',
      'feedbackSent': 'Zpětná vazba byla odeslána',
      // Off stable
      'offStableEnabled': 'Mimo stáj zapnuto',
      'offStableDisabled': 'Mimo stáj vypnuto',
      // New listing
      'buyerProtectionHint': 'Ochrana kupujícího bude automaticky přidána k ceně',
      'createListing': 'Vytvořit inzerát',
      'listingCreated': 'Inzerát byl úspěšně vytvořen',
      'tapToUpload': 'Klepněte pro nahrání',
      'uploadFormats': 'SVG, PNG, JPG nebo GIF (max. 800x400px)',
      'wasDeleted': 'byl smazán',
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
      'noAccountYet': 'Don\'t have an account yet?',
      'loginSuccessful': 'Login successful',
      'mustAgreeToTerms': 'You must agree to the terms',
      'accountCreated': 'Account created successfully',
      'resetLinkSent': 'We sent a password reset link to the provided email address.',
      'backToLogin': 'Back to login',
      'emailNotArrived': 'Email didn\'t arrive?',
      'resend': 'Resend',
      'emailResent': 'Email resent',
      'invalidEmail': 'Invalid email',
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
      'including': 'incl.',
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
      'favoriteItems': 'Favorite items',
      'activeListings': 'Active listings',
      'soldListings': 'Sold listings',
      'ratingsCount': 'ratings',
      'shareProfile': 'Share profile',
      'editProfile': 'Edit profile',
      'shareProduct': 'Share product',
      'reportProduct': 'Report product',
      'reportProfile': 'Report profile',
      'blockSeller': 'Block seller',
      'unblockSeller': 'Unblock seller',
      'blockSellerQuestion': 'Block seller?',
      'sellerBlocked': 'Seller has been blocked',
      'sellerUnblocked': 'Seller has been unblocked',
      'reportReason': 'Report reason',
      'scamOrSpam': 'I think it\'s a scam or spam',
      'offensiveText': 'Text is offensive',
      'somethingElse': 'Something else',
      'describeReason': 'Describe the reason*',
      'reportSent': 'Report has been sent',
      'about': 'About us',
      'howItWorks': 'How it works',
      'help': 'Help',
      'feedback': 'Feedback',
      'inviteFriends': 'Invite friends',
      'eqquPlatform': 'EQQU Platform',
      'offStable': 'Off stable',
      'inviteTitle': 'Invite your friends to EQQU – the best app for buying equestrian supplies, where you\'ll find everything for your horse in one place.',
      'inviteBody': 'Join EQQU and discover a wide selection of quality equestrian supplies. Invite friends and enjoy convenient shopping with expert support right in the app.',
      'writeMessage': 'Write a message',
      'changePassword': 'Change password',
      'address': 'Address',
      'order': 'Order',
      'all': 'All',
      'active': 'Active',
      'completed': 'Completed',
      'newStatus': 'New',
      'noFavoritesYet': 'No favorites yet',
      'used': 'Used',
      'buildSet': 'Build set',
      'reserve': 'Reserve',
      'hide': 'Hide',
      'shareLink': 'Share link',
      'wrongCategory': 'Can\'t find the right category?',
      'contactUs': 'Contact us',
      'changesSaved': 'Changes saved',
      'skip': 'Skip',
      'back': 'Back',
      'more': 'More',
      'send': 'Send',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'deleteProductQuestion': 'Do you really want to delete this product?',
      'close': 'Close',
      'edit': 'Edit',
      'unhide': 'Unhide',
      'message': 'Message',
      'linkCopied': 'Link copied to clipboard',
      'free': 'Free',
      // Validators
      'enterEmail': 'Enter email',
      'invalidEmailFormat': 'Invalid email format',
      'enterUsername': 'Enter username',
      'minThreeChars': 'Minimum 3 characters',
      'enterPassword': 'Enter password',
      'passwordMinSix': 'Password must be at least 6 characters',
      'confirmPasswordField': 'Confirm password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'enterCardNumber': 'Enter card number',
      'invalidCardNumber': 'Invalid card number',
      'enterExpiry': 'Enter expiry date',
      'enterCvc': 'Enter CVC',
      'invalidCvc': 'Invalid CVC',
      // Form labels
      'usernameLabel': 'Username*',
      'usernameFieldLabel': 'Username',
      'fullNameLabel': 'Full name*',
      'enterFullName': 'Enter full name',
      'countryLabel': 'Country*',
      'dateOfBirthLabel': 'Date of birth*',
      'enterDateOfBirth': 'Enter date of birth',
      'descriptionLabel': 'Description',
      'addressLabel': 'Address*',
      'enterAddress': 'Enter address',
      'phoneLabel': 'Phone number*',
      'enterPhone': 'Enter phone number',
      'oldPasswordLabel': 'Old password',
      'enterOldPassword': 'Enter old password',
      'newPasswordLabel': 'New password',
      'enterNewPassword': 'Enter new password',
      'newPasswordConfirmLabel': 'Confirm new password',
      'confirmNewPassword': 'Confirm new password',
      'passwordConfirmation': 'Password confirmation',
      'streetAndNumber': 'Street and number',
      'enterStreetNumber': 'Enter street and number',
      'cityLabel': 'City',
      'enterCity': 'Enter city',
      'postalCode': 'Postal code',
      'enterPostalCode': 'Enter postal code',
      'countryRequired': 'Country*',
      'nameRequired': 'Name*',
      'descriptionRequired': 'Description*',
      'requiredPrice': 'Asking price*',
      'cardNumber': 'Card number',
      'expiry': 'Expiry',
      'cvcCvv': 'CVC/CVV',
      'verbalRating': 'Written review',
      // Cart / Order
      'deliveryAddress': 'Delivery address',
      'personalInfo': 'Personal information',
      'paymentMethod': 'Payment method',
      'cardPayment': 'Card payment',
      'deliveryMethodLabel': 'Delivery method',
      'deliveryToAddress': 'Delivery to address',
      'personalPickup': 'Personal pickup',
      'bindingOrder': 'Binding order for payment',
      'cartEmpty': 'Cart is empty',
      'addProductsToCart': 'Add products to cart and start shopping.',
      'changeAddress': 'Change address',
      'saveCardForNext': 'Save card for next purchase',
      'shippingCost': 'Shipping cost',
      'buyerProtectionFee': 'Buyer protection fee',
      'totalToPay': 'Total to pay',
      'totalPriceLabel': 'Total price',
      'orderSuccess': 'Success!',
      'orderSuccessMessage': 'Your order has been successfully submitted.',
      'viewOrder': 'View order',
      'productRemovedFromCart': 'Product removed from cart',
      // Order detail
      'rateOrder': 'Rate your purchase',
      'rate': 'Rate',
      'ratingSubmitted': 'Rating submitted',
      'statusCompleted': 'Completed',
      'statusCancelled': 'Cancelled',
      'statusActive': 'Active',
      'buyerInfo': 'Buyer information',
      'deliveryAddressLabel': 'Delivery address:',
      'shippingSection': 'Shipping',
      'sellerInfo': 'Seller information',
      // Sales statuses
      'statusProcessed': 'Processed',
      'statusShipped': 'Shipped',
      'statusDelivered': 'Delivered',
      'statusPaidOut': 'Paid out',
      // Listing statuses
      'statusSold': 'Sold',
      // My listings
      'hideAllListings': 'Hide all listings',
      'unhideAllListings': 'Unhide all listings',
      'reserveFailed': 'Reservation failed',
      'reserveFailedMessage': 'Could not reserve the listing. Please try again later.',
      'wasDeletedSuffix': 'was deleted',
      // Account
      'deleteAccount': 'Delete account',
      'deleteProfileQuestion': 'Delete profile?',
      'accountDeleted': 'Account deleted',
      'passwordChanged': 'Password changed',
      'changeYourPassword': 'Change your password',
      'changePasswordDesc': 'To change your password, enter the old password and then the new one.',
      'addressSaved': 'Address saved',
      // Feedback
      'enterMessage': 'Enter a message',
      'feedbackSent': 'Feedback sent',
      // Off stable
      'offStableEnabled': 'Off stable enabled',
      'offStableDisabled': 'Off stable disabled',
      // New listing
      'buyerProtectionHint': 'Buyer protection will be automatically added to the price',
      'createListing': 'Create listing',
      'listingCreated': 'Listing created successfully',
      'tapToUpload': 'Tap to upload',
      'uploadFormats': 'SVG, PNG, JPG or GIF (max. 800x400px)',
      'wasDeleted': 'was deleted',
    },
    'sk': {
      'home': 'Domov',
      'chat': 'Chat',
      'sell': 'Predať',
      'favorites': 'Obľúbené',
      'profile': 'Profil',
      'login': 'Prihlásenie',
      'registration': 'Registrácia',
      'forgotPassword': 'Zabudnuté heslo',
      'logout': 'Odhlásiť sa',
      'email': 'E-mail',
      'password': 'Heslo',
      'continueWithoutLogin': 'Pokračovať bez prihlásenia',
      'continueWithoutRegistration': 'Pokračovať bez registrácie',
      'alreadyHaveAccount': 'Už máte účet?',
      'createAccount': 'Vytvorte si ho',
      'sendResetLink': 'Odoslať',
      'rememberPassword': 'Pamätáte si heslo?',
      'noAccountYet': 'Ešte nemáte účet?',
      'loginSuccessful': 'Prihlásenie bolo úspešné',
      'mustAgreeToTerms': 'Musíte súhlasiť s podmienkami',
      'accountCreated': 'Účet bol úspešne vytvorený',
      'resetLinkSent': 'Odoslali sme odkaz na resetovanie hesla na zadanú e-mailovú adresu.',
      'backToLogin': 'Späť na prihlásenie',
      'emailNotArrived': 'Neprišiel mail?',
      'resend': 'Poslať znova',
      'emailResent': 'E-mail bol znovu odoslaný',
      'invalidEmail': 'Neplatný e-mail',
      'settings': 'Nastavenia',
      'accountSettings': 'Nastavenia účtu',
      'payments': 'Platby',
      'shipping': 'Preprava',
      'secureAccount': 'Bezpečný účet',
      'notifications': 'Oznámenia',
      'language': 'Jazyk',
      'appearance': 'Vzhľad',
      'appLanguage': 'Jazyk aplikácie',
      'lightMode': 'Light mode',
      'darkMode': 'Dark mode',
      'systemMode': 'Podľa systému',
      'cart': 'Košík',
      'products': 'Produkty',
      'productPrice': 'Cena tovaru',
      'totalPrice': 'Celková cena',
      'buyerProtection': 'Vrátane ochrany kupujúceho',
      'moreFromSeller': 'Ďalšie od tohto predajcu',
      'messageSeller': 'Napísať predajcovi',
      'buy': 'Kúpiť',
      'search': 'Hľadať',
      'featured': 'Odporúčané',
      'including': 'vr.',
      'myListings': 'Moje inzeráty',
      'myPurchases': 'Moje nákupy',
      'mySales': 'Moje predaje',
      'newListing': 'Nový inzerát',
      'basicInfo': 'Základné informácie',
      'filter': 'Filter',
      'save': 'Uložiť',
      'saveFilters': 'Uložiť filtre',
      'sortBy': 'Zoradiť podľa',
      'category': 'Kategória',
      'subcategory': 'Podkategória',
      'price': 'Cena',
      'priceRange': 'Cenové rozpätie',
      'condition': 'Stav tovaru',
      'size': 'Veľkosť',
      'brand': 'Značka',
      'gender': 'Pohlavie',
      'color': 'Farba',
      'material': 'Materiál',
      'sellerProfile': 'Profil predajcu',
      'listings': 'Inzeráty',
      'follow': 'Sledovať',
      'following': 'Sledujete',
      'reviews': 'Hodnotenia',
      'rating': 'Hodnotenie',
      'favoriteItems': 'Obľúbené predmety',
      'activeListings': 'Aktívnych inzerátov',
      'soldListings': 'Predaných inzerátov',
      'ratingsCount': 'hodnotení',
      'shareProfile': 'Zdieľať profil',
      'editProfile': 'Upraviť profil',
      'shareProduct': 'Zdieľať produkt',
      'reportProduct': 'Nahlásiť produkt',
      'reportProfile': 'Nahlásiť profil',
      'blockSeller': 'Zablokovať predajcu',
      'unblockSeller': 'Odblokovať predajcu',
      'blockSellerQuestion': 'Zablokovať predajcu?',
      'sellerBlocked': 'Predajca bol zablokovaný',
      'sellerUnblocked': 'Predajca bol odblokovaný',
      'reportReason': 'Dôvod nahlásenia',
      'scamOrSpam': 'Myslím si, že ide o podvod alebo spam',
      'offensiveText': 'Text je urážlivý',
      'somethingElse': 'Niečo iné',
      'describeReason': 'Opíšte dôvod*',
      'reportSent': 'Nahlásenie bolo odoslané',
      'about': 'O nás',
      'howItWorks': 'Ako to funguje',
      'help': 'Pomoc',
      'feedback': 'Spätná väzba',
      'inviteFriends': 'Pozvať priateľov',
      'eqquPlatform': 'Platforma EQQU',
      'offStable': 'Mimo stajne',
      'inviteTitle': 'Pozvite svojich priateľov do EQQU – najlepšej aplikácie na nákup jazdeckých potrieb, kde nájdete všetko pre svojho koňa na jednom mieste.',
      'inviteBody': 'Pridajte sa k EQQU a objavte široký výber kvalitných potrieb pre kone. Pozvite priateľov a užite si pohodlný nákup s odbornou podporou priamo v aplikácii.',
      'writeMessage': 'Napíšte správu',
      'changePassword': 'Zmena hesla',
      'address': 'Adresa',
      'order': 'Objednávka',
      'all': 'Všetko',
      'active': 'Aktívne',
      'completed': 'Dokončené',
      'newStatus': 'Nové',
      'noFavoritesYet': 'Zatiaľ nemáte žiadne obľúbené',
      'used': 'Použité',
      'buildSet': 'Zostaviť sadu',
      'reserve': 'Rezervovať',
      'hide': 'Skryť',
      'shareLink': 'Zdieľať odkaz',
      'wrongCategory': 'Nenašli ste správnu kategóriu?',
      'contactUs': 'Napíšte nám',
      'changesSaved': 'Zmeny boli uložené',
      'skip': 'Preskočiť',
      'back': 'Späť',
      'more': 'Viac',
      'send': 'Odoslať',
      'cancel': 'Zrušiť',
      'delete': 'Zmazať',
      'deleteProductQuestion': 'Naozaj chcete zmazať tento produkt?',
      'close': 'Zavrieť',
      'edit': 'Upraviť',
      'unhide': 'Odkryť',
      'message': 'Správa',
      'linkCopied': 'Odkaz bol skopírovaný do schránky',
      'free': 'Zadarmo',
      'enterEmail': 'Zadajte e-mail',
      'invalidEmailFormat': 'Neplatný formát e-mailu',
      'enterUsername': 'Zadajte používateľské meno',
      'minThreeChars': 'Minimálne 3 znaky',
      'enterPassword': 'Zadajte heslo',
      'passwordMinSix': 'Heslo musí mať aspoň 6 znakov',
      'confirmPasswordField': 'Potvrďte heslo',
      'passwordsDoNotMatch': 'Heslá sa nezhodujú',
      'enterCardNumber': 'Zadajte číslo karty',
      'invalidCardNumber': 'Neplatné číslo karty',
      'enterExpiry': 'Zadajte expiráciu',
      'enterCvc': 'Zadajte CVC',
      'invalidCvc': 'Neplatný CVC',
      'usernameLabel': 'Používateľské meno*',
      'usernameFieldLabel': 'Používateľské meno',
      'fullNameLabel': 'Meno a priezvisko*',
      'enterFullName': 'Zadajte meno a priezvisko',
      'countryLabel': 'Štát*',
      'dateOfBirthLabel': 'Dátum narodenia*',
      'enterDateOfBirth': 'Zadajte dátum narodenia',
      'descriptionLabel': 'Popis',
      'addressLabel': 'Adresa*',
      'enterAddress': 'Zadajte adresu',
      'phoneLabel': 'Telefónne číslo*',
      'enterPhone': 'Zadajte telefónne číslo',
      'oldPasswordLabel': 'Staré heslo',
      'enterOldPassword': 'Zadajte staré heslo',
      'newPasswordLabel': 'Nové heslo',
      'enterNewPassword': 'Zadajte nové heslo',
      'newPasswordConfirmLabel': 'Potvrdenie nového hesla',
      'confirmNewPassword': 'Potvrďte nové heslo',
      'passwordConfirmation': 'Potvrdenie hesla',
      'streetAndNumber': 'Ulica a číslo',
      'enterStreetNumber': 'Zadajte ulicu a číslo',
      'cityLabel': 'Mesto',
      'enterCity': 'Zadajte mesto',
      'postalCode': 'PSČ',
      'enterPostalCode': 'Zadajte PSČ',
      'countryRequired': 'Štát*',
      'nameRequired': 'Názov*',
      'descriptionRequired': 'Popis*',
      'requiredPrice': 'Požadovaná cena*',
      'cardNumber': 'Číslo karty',
      'expiry': 'Expirácia',
      'cvcCvv': 'CVC/CVV',
      'verbalRating': 'Slovné hodnotenie',
      'deliveryAddress': 'Doručovacia adresa',
      'personalInfo': 'Osobné údaje',
      'paymentMethod': 'Spôsob platby',
      'cardPayment': 'Platba kartou',
      'deliveryMethodLabel': 'Spôsob doručenia',
      'deliveryToAddress': 'Doručenie na adresu',
      'personalPickup': 'Osobný odber',
      'bindingOrder': 'Objednávka zaväzujúca k platbe',
      'cartEmpty': 'Košík je prázdny',
      'addProductsToCart': 'Pridajte produkty do košíka a začnite nakupovať.',
      'changeAddress': 'Zmeniť adresu',
      'saveCardForNext': 'Uložiť kartu pre ďalší nákup',
      'shippingCost': 'Cena dopravy',
      'buyerProtectionFee': 'Poplatok za ochranu kupujúceho',
      'totalToPay': 'Celkom k úhrade',
      'totalPriceLabel': 'Cena celkom',
      'orderSuccess': 'Je to tam!',
      'orderSuccessMessage': 'Tvoja objednávka bola úspešne odoslaná.',
      'viewOrder': 'Zobraziť objednávku',
      'productRemovedFromCart': 'Produkt bol odobratý z košíka',
      'rateOrder': 'Ohodnoťte nákup',
      'rate': 'Ohodnotiť',
      'ratingSubmitted': 'Hodnotenie bolo odoslané',
      'statusCompleted': 'Dokončené',
      'statusCancelled': 'Storno',
      'statusActive': 'Aktívne',
      'buyerInfo': 'Informácie o kupujúcom',
      'deliveryAddressLabel': 'Doručovacia adresa:',
      'shippingSection': 'Doprava',
      'sellerInfo': 'Informácie o predajcovi',
      'statusProcessed': 'Vybavené',
      'statusShipped': 'Odoslané',
      'statusDelivered': 'Doručené',
      'statusPaidOut': 'Vyplatené',
      'statusSold': 'Predané',
      'hideAllListings': 'Skryť všetky inzeráty',
      'unhideAllListings': 'Odkryť všetky inzeráty',
      'reserveFailed': 'Rezervácia zlyhala',
      'reserveFailedMessage': 'Nepodarilo sa rezervovať inzerát. Skúste to prosím znova neskôr.',
      'wasDeletedSuffix': 'bol zmazaný',
      'deleteAccount': 'Zmazať účet',
      'deleteProfileQuestion': 'Zmazať profil?',
      'accountDeleted': 'Účet bol zmazaný',
      'passwordChanged': 'Heslo bolo zmenené',
      'changeYourPassword': 'Zmeňte si heslo',
      'changePasswordDesc': 'Pre zmenu hesla zadajte staré heslo a potom nové heslo.',
      'addressSaved': 'Adresa bola uložená',
      'enterMessage': 'Zadajte správu',
      'feedbackSent': 'Spätná väzba bola odoslaná',
      'offStableEnabled': 'Mimo stajne zapnuté',
      'offStableDisabled': 'Mimo stajne vypnuté',
      'buyerProtectionHint': 'Ochrana kupujúceho bude automaticky pridaná k cene',
      'createListing': 'Vytvoriť inzerát',
      'listingCreated': 'Inzerát bol úspešne vytvorený',
      'tapToUpload': 'Klepnite pre nahranie',
      'uploadFormats': 'SVG, PNG, JPG alebo GIF (max. 800x400px)',
      'wasDeleted': 'bol zmazaný',
    },
    'pl': {
      'home': 'Strona główna',
      'chat': 'Czat',
      'sell': 'Sprzedaj',
      'favorites': 'Ulubione',
      'profile': 'Profil',
      'login': 'Logowanie',
      'registration': 'Rejestracja',
      'forgotPassword': 'Zapomniane hasło',
      'logout': 'Wyloguj się',
      'email': 'E-mail',
      'password': 'Hasło',
      'continueWithoutLogin': 'Kontynuuj bez logowania',
      'continueWithoutRegistration': 'Kontynuuj bez rejestracji',
      'alreadyHaveAccount': 'Masz już konto?',
      'createAccount': 'Utwórz je',
      'sendResetLink': 'Wyślij',
      'rememberPassword': 'Pamiętasz hasło?',
      'noAccountYet': 'Nie masz jeszcze konta?',
      'loginSuccessful': 'Logowanie powiodło się',
      'mustAgreeToTerms': 'Musisz zaakceptować regulamin',
      'accountCreated': 'Konto zostało utworzone',
      'resetLinkSent': 'Wysłaliśmy link do resetowania hasła na podany adres e-mail.',
      'backToLogin': 'Powrót do logowania',
      'emailNotArrived': 'E-mail nie dotarł?',
      'resend': 'Wyślij ponownie',
      'emailResent': 'E-mail został wysłany ponownie',
      'invalidEmail': 'Nieprawidłowy e-mail',
      'settings': 'Ustawienia',
      'accountSettings': 'Ustawienia konta',
      'payments': 'Płatności',
      'shipping': 'Wysyłka',
      'secureAccount': 'Bezpieczne konto',
      'notifications': 'Powiadomienia',
      'language': 'Język',
      'appearance': 'Wygląd',
      'appLanguage': 'Język aplikacji',
      'lightMode': 'Tryb jasny',
      'darkMode': 'Tryb ciemny',
      'systemMode': 'Według systemu',
      'cart': 'Koszyk',
      'products': 'Produkty',
      'productPrice': 'Cena produktu',
      'totalPrice': 'Cena całkowita',
      'buyerProtection': 'Z ochroną kupującego',
      'moreFromSeller': 'Więcej od tego sprzedawcy',
      'messageSeller': 'Napisz do sprzedawcy',
      'buy': 'Kup',
      'search': 'Szukaj',
      'featured': 'Polecane',
      'including': 'z ochr.',
      'myListings': 'Moje ogłoszenia',
      'myPurchases': 'Moje zakupy',
      'mySales': 'Moja sprzedaż',
      'newListing': 'Nowe ogłoszenie',
      'basicInfo': 'Podstawowe informacje',
      'filter': 'Filtr',
      'save': 'Zapisz',
      'saveFilters': 'Zapisz filtry',
      'sortBy': 'Sortuj według',
      'category': 'Kategoria',
      'subcategory': 'Podkategoria',
      'price': 'Cena',
      'priceRange': 'Zakres cenowy',
      'condition': 'Stan',
      'size': 'Rozmiar',
      'brand': 'Marka',
      'gender': 'Płeć',
      'color': 'Kolor',
      'material': 'Materiał',
      'sellerProfile': 'Profil sprzedawcy',
      'listings': 'Ogłoszenia',
      'follow': 'Obserwuj',
      'following': 'Obserwujesz',
      'reviews': 'Oceny',
      'rating': 'Ocena',
      'favoriteItems': 'Ulubione przedmioty',
      'activeListings': 'Aktywnych ogłoszeń',
      'soldListings': 'Sprzedanych ogłoszeń',
      'ratingsCount': 'ocen',
      'shareProfile': 'Udostępnij profil',
      'editProfile': 'Edytuj profil',
      'shareProduct': 'Udostępnij produkt',
      'reportProduct': 'Zgłoś produkt',
      'reportProfile': 'Zgłoś profil',
      'blockSeller': 'Zablokuj sprzedawcę',
      'unblockSeller': 'Odblokuj sprzedawcę',
      'blockSellerQuestion': 'Zablokować sprzedawcę?',
      'sellerBlocked': 'Sprzedawca został zablokowany',
      'sellerUnblocked': 'Sprzedawca został odblokowany',
      'reportReason': 'Powód zgłoszenia',
      'scamOrSpam': 'Uważam, że to oszustwo lub spam',
      'offensiveText': 'Tekst jest obraźliwy',
      'somethingElse': 'Coś innego',
      'describeReason': 'Opisz powód*',
      'reportSent': 'Zgłoszenie zostało wysłane',
      'about': 'O nas',
      'howItWorks': 'Jak to działa',
      'help': 'Pomoc',
      'feedback': 'Opinia',
      'inviteFriends': 'Zaproś znajomych',
      'eqquPlatform': 'Platforma EQQU',
      'offStable': 'Poza stajnią',
      'inviteTitle': 'Zaproś znajomych do EQQU – najlepszej aplikacji do kupowania artykułów jeździeckich, gdzie znajdziesz wszystko dla swojego konia w jednym miejscu.',
      'inviteBody': 'Dołącz do EQQU i odkryj szeroki wybór artykułów jeździeckich. Zaproś znajomych i ciesz się wygodnymi zakupami ze wsparciem ekspertów bezpośrednio w aplikacji.',
      'writeMessage': 'Napisz wiadomość',
      'changePassword': 'Zmiana hasła',
      'address': 'Adres',
      'order': 'Zamówienie',
      'all': 'Wszystko',
      'active': 'Aktywne',
      'completed': 'Zakończone',
      'newStatus': 'Nowe',
      'noFavoritesYet': 'Nie masz jeszcze ulubionych',
      'used': 'Używane',
      'buildSet': 'Złóż zestaw',
      'reserve': 'Zarezerwuj',
      'hide': 'Ukryj',
      'shareLink': 'Udostępnij link',
      'wrongCategory': 'Nie znalazłeś odpowiedniej kategorii?',
      'contactUs': 'Napisz do nas',
      'changesSaved': 'Zmiany zostały zapisane',
      'skip': 'Pomiń',
      'back': 'Wstecz',
      'more': 'Więcej',
      'send': 'Wyślij',
      'cancel': 'Anuluj',
      'delete': 'Usuń',
      'deleteProductQuestion': 'Czy na pewno chcesz usunąć ten produkt?',
      'close': 'Zamknij',
      'edit': 'Edytuj',
      'unhide': 'Pokaż',
      'message': 'Wiadomość',
      'linkCopied': 'Link został skopiowany do schowka',
      'free': 'Za darmo',
      'enterEmail': 'Wprowadź e-mail',
      'invalidEmailFormat': 'Nieprawidłowy format e-mailu',
      'enterUsername': 'Wprowadź nazwę użytkownika',
      'minThreeChars': 'Minimum 3 znaki',
      'enterPassword': 'Wprowadź hasło',
      'passwordMinSix': 'Hasło musi mieć co najmniej 6 znaków',
      'confirmPasswordField': 'Potwierdź hasło',
      'passwordsDoNotMatch': 'Hasła się nie zgadzają',
      'enterCardNumber': 'Wprowadź numer karty',
      'invalidCardNumber': 'Nieprawidłowy numer karty',
      'enterExpiry': 'Wprowadź datę ważności',
      'enterCvc': 'Wprowadź CVC',
      'invalidCvc': 'Nieprawidłowy CVC',
      'usernameLabel': 'Nazwa użytkownika*',
      'usernameFieldLabel': 'Nazwa użytkownika',
      'fullNameLabel': 'Imię i nazwisko*',
      'enterFullName': 'Wprowadź imię i nazwisko',
      'countryLabel': 'Kraj*',
      'dateOfBirthLabel': 'Data urodzenia*',
      'enterDateOfBirth': 'Wprowadź datę urodzenia',
      'descriptionLabel': 'Opis',
      'addressLabel': 'Adres*',
      'enterAddress': 'Wprowadź adres',
      'phoneLabel': 'Numer telefonu*',
      'enterPhone': 'Wprowadź numer telefonu',
      'oldPasswordLabel': 'Stare hasło',
      'enterOldPassword': 'Wprowadź stare hasło',
      'newPasswordLabel': 'Nowe hasło',
      'enterNewPassword': 'Wprowadź nowe hasło',
      'newPasswordConfirmLabel': 'Potwierdzenie nowego hasła',
      'confirmNewPassword': 'Potwierdź nowe hasło',
      'passwordConfirmation': 'Potwierdzenie hasła',
      'streetAndNumber': 'Ulica i numer',
      'enterStreetNumber': 'Wprowadź ulicę i numer',
      'cityLabel': 'Miasto',
      'enterCity': 'Wprowadź miasto',
      'postalCode': 'Kod pocztowy',
      'enterPostalCode': 'Wprowadź kod pocztowy',
      'countryRequired': 'Kraj*',
      'nameRequired': 'Nazwa*',
      'descriptionRequired': 'Opis*',
      'requiredPrice': 'Żądana cena*',
      'cardNumber': 'Numer karty',
      'expiry': 'Data ważności',
      'cvcCvv': 'CVC/CVV',
      'verbalRating': 'Recenzja słowna',
      'deliveryAddress': 'Adres dostawy',
      'personalInfo': 'Dane osobowe',
      'paymentMethod': 'Metoda płatności',
      'cardPayment': 'Płatność kartą',
      'deliveryMethodLabel': 'Sposób dostawy',
      'deliveryToAddress': 'Dostawa na adres',
      'personalPickup': 'Odbiór osobisty',
      'bindingOrder': 'Zamówienie zobowiązujące do zapłaty',
      'cartEmpty': 'Koszyk jest pusty',
      'addProductsToCart': 'Dodaj produkty do koszyka i zacznij zakupy.',
      'changeAddress': 'Zmień adres',
      'saveCardForNext': 'Zapisz kartę na następne zakupy',
      'shippingCost': 'Koszt wysyłki',
      'buyerProtectionFee': 'Opłata za ochronę kupującego',
      'totalToPay': 'Razem do zapłaty',
      'totalPriceLabel': 'Cena łącznie',
      'orderSuccess': 'Gotowe!',
      'orderSuccessMessage': 'Twoje zamówienie zostało pomyślnie złożone.',
      'viewOrder': 'Zobacz zamówienie',
      'productRemovedFromCart': 'Produkt usunięty z koszyka',
      'rateOrder': 'Oceń zakup',
      'rate': 'Oceń',
      'ratingSubmitted': 'Ocena została wysłana',
      'statusCompleted': 'Zakończone',
      'statusCancelled': 'Anulowane',
      'statusActive': 'Aktywne',
      'buyerInfo': 'Informacje o kupującym',
      'deliveryAddressLabel': 'Adres dostawy:',
      'shippingSection': 'Wysyłka',
      'sellerInfo': 'Informacje o sprzedawcy',
      'statusProcessed': 'Zrealizowane',
      'statusShipped': 'Wysłane',
      'statusDelivered': 'Dostarczone',
      'statusPaidOut': 'Wypłacone',
      'statusSold': 'Sprzedane',
      'hideAllListings': 'Ukryj wszystkie ogłoszenia',
      'unhideAllListings': 'Pokaż wszystkie ogłoszenia',
      'reserveFailed': 'Rezerwacja nie powiodła się',
      'reserveFailedMessage': 'Nie udało się zarezerwować ogłoszenia. Spróbuj ponownie później.',
      'wasDeletedSuffix': 'zostało usunięte',
      'deleteAccount': 'Usuń konto',
      'deleteProfileQuestion': 'Usunąć profil?',
      'accountDeleted': 'Konto zostało usunięte',
      'passwordChanged': 'Hasło zostało zmienione',
      'changeYourPassword': 'Zmień swoje hasło',
      'changePasswordDesc': 'Aby zmienić hasło, wprowadź stare hasło, a następnie nowe.',
      'addressSaved': 'Adres został zapisany',
      'enterMessage': 'Wprowadź wiadomość',
      'feedbackSent': 'Opinia została wysłana',
      'offStableEnabled': 'Poza stajnią włączone',
      'offStableDisabled': 'Poza stajnią wyłączone',
      'buyerProtectionHint': 'Ochrona kupującego zostanie automatycznie dodana do ceny',
      'createListing': 'Utwórz ogłoszenie',
      'listingCreated': 'Ogłoszenie zostało utworzone',
      'tapToUpload': 'Kliknij, aby przesłać',
      'uploadFormats': 'SVG, PNG, JPG lub GIF (maks. 800x400px)',
      'wasDeleted': 'został usunięty',
    },
  };
}
