import 'package:flutter/material.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/screens/auth/splash_screen.dart';
import 'package:eqqu/screens/auth/intro_screen.dart';
import 'package:eqqu/screens/auth/registration_screen.dart';
import 'package:eqqu/screens/auth/login_screen.dart';
import 'package:eqqu/screens/auth/forgot_password_screen.dart';
import 'package:eqqu/screens/products/home_screen.dart';
import 'package:eqqu/screens/settings/settings_screen.dart';
import 'package:eqqu/screens/settings/account_settings_screen.dart';
import 'package:eqqu/screens/settings/shipping_screen.dart';
import 'package:eqqu/screens/settings/secure_account_screen.dart';
import 'package:eqqu/screens/settings/notifications_screen.dart';
import 'package:eqqu/screens/settings/appearance_screen.dart';
import 'package:eqqu/screens/settings/language_screen.dart';
import 'package:eqqu/screens/commerce/cart_screen.dart';
import 'package:eqqu/screens/commerce/new_listing_screen.dart';
import 'package:eqqu/screens/commerce/my_listings_screen.dart';
import 'package:eqqu/screens/commerce/my_purchases_screen.dart';
import 'package:eqqu/screens/commerce/my_sales_screen.dart';
import 'package:eqqu/screens/commerce/order_detail_screen.dart';
import 'package:eqqu/screens/products/product_detail_screen.dart';
import 'package:eqqu/screens/social/seller_profile_screen.dart';
import 'package:eqqu/screens/social/buyer_view_seller_screen.dart';
import 'package:eqqu/screens/social/chat_detail_screen.dart';
import 'package:eqqu/screens/social/profile_screen.dart';
import 'package:eqqu/screens/info/about_screen.dart';
import 'package:eqqu/screens/info/how_it_works_screen.dart';
import 'package:eqqu/screens/info/help_screen.dart';
import 'package:eqqu/screens/info/feedback_screen.dart';
import 'package:eqqu/screens/info/invite_friends_screen.dart';
import 'package:eqqu/screens/info/eqqu_platform_screen.dart';
import 'package:eqqu/screens/social/reviews_screen.dart';
import 'package:eqqu/screens/products/build_set_screen.dart';
import 'package:eqqu/screens/settings/address_screen.dart';
import 'package:eqqu/screens/settings/change_password_screen.dart';
import 'package:eqqu/screens/auth/login_overview_screen.dart';
import 'package:eqqu/screens/info/mimo_staj_screen.dart';
import 'package:eqqu/screens/products/favorites_screen.dart';

/// Centralized route name constants and route generator.
///
/// Usage: `Navigator.pushNamed(context, AppRoutes.home)`
class AppRoutes {
  AppRoutes._();

  // ── existing ──────────────────────────────────────────────
  static const String splash = '/';
  static const String intro = '/intro';
  static const String registration = '/registration';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';

  // ── new ───────────────────────────────────────────────────
  static const String settings = '/settings';
  static const String accountSettings = '/account-settings';
  static const String shipping = '/shipping';
  static const String secureAccount = '/secure-account';
  static const String notifications = '/notifications';
  static const String appearance = '/appearance';
  static const String language = '/language';
  static const String cart = '/cart';
  static const String newListing = '/new-listing';
  static const String myListings = '/my-listings';
  static const String myPurchases = '/my-purchases';
  static const String mySales = '/my-sales';
  static const String orderDetail = '/order-detail';
  static const String productDetail = '/product-detail';
  static const String sellerProfile = '/seller-profile';
  static const String buyerViewSeller = '/buyer-view-seller';
  static const String chatDetail = '/chat-detail';
  static const String profile = '/profile';
  static const String about = '/about';
  static const String howItWorks = '/how-it-works';
  static const String help = '/help';
  static const String feedback = '/feedback';
  static const String inviteFriends = '/invite-friends';
  static const String eqquPlatform = '/eqqu-platform';
  static const String reviews = '/reviews';
  static const String buildSet = '/build-set';
  static const String address = '/address';
  static const String changePassword = '/change-password';
  static const String loginOverview = '/login-overview';
  static const String mimoStaj = '/mimo-staj';
  static const String favorites = '/favorites';

  // ── route generator ───────────────────────────────────────
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // auth / onboarding
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      // main
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // settings tree
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case accountSettings:
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case shipping:
        return MaterialPageRoute(builder: (_) => const ShippingScreen());
      case secureAccount:
        return MaterialPageRoute(builder: (_) => const SecureAccountScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case appearance:
        return MaterialPageRoute(builder: (_) => const AppearanceScreen());
      case language:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());

      // commerce
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case newListing:
        return MaterialPageRoute(builder: (_) => const NewListingScreen());
      case myListings:
        return MaterialPageRoute(builder: (_) => const MyListingsScreen());
      case myPurchases:
        return MaterialPageRoute(builder: (_) => const MyPurchasesScreen());
      case mySales:
        return MaterialPageRoute(builder: (_) => const MySalesScreen());
      case orderDetail:
        return MaterialPageRoute(builder: (_) => const OrderDetailScreen());

      // product (supports arguments for type-safe navigation)
      case productDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            brand: args['brand'] as String,
            name: args['name'] as String,
            condition: args['condition'] as String,
            price: args['price'] as String,
            oldPrice: args['oldPrice'] as String,
            imageAsset: args['imageAsset'] as String? ?? '',
            heroTag: args['heroTag'] as String? ?? '',
          ),
        );

      // profiles & social
      case sellerProfile:
        return MaterialPageRoute(builder: (_) => const SellerProfileScreen());
      case buyerViewSeller:
        return MaterialPageRoute(builder: (_) => const BuyerViewSellerScreen());
      case chatDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChatDetailScreen(
            name: args['name'] as String,
            initials: args['initials'] as String,
            avatarImage: args['avatarImage'] as String,
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case reviews:
        return MaterialPageRoute(builder: (_) => const ReviewsScreen());

      // info & misc
      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case howItWorks:
        return MaterialPageRoute(builder: (_) => const HowItWorksScreen());
      case AppRoutes.help:
        return MaterialPageRoute(builder: (_) => const HelpScreen());
      case AppRoutes.feedback:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
      case inviteFriends:
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());
      case eqquPlatform:
        return MaterialPageRoute(builder: (_) => const EqquPlatformScreen());
      case buildSet:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BuildSetScreen(products: args['products'] as List<Product>),
        );
      case address:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case loginOverview:
        return MaterialPageRoute(builder: (_) => const LoginOverviewScreen());
      case mimoStaj:
        return MaterialPageRoute(builder: (_) => const MimoStajScreen());
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
