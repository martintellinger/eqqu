import 'package:flutter/material.dart';
import 'package:eqqu/models/product.dart';
import 'package:eqqu/screens/splash_screen.dart';
import 'package:eqqu/screens/intro_screen.dart';
import 'package:eqqu/screens/registration_screen.dart';
import 'package:eqqu/screens/login_screen.dart';
import 'package:eqqu/screens/forgot_password_screen.dart';
import 'package:eqqu/screens/home_screen.dart';
import 'package:eqqu/screens/settings_screen.dart';
import 'package:eqqu/screens/account_settings_screen.dart';
import 'package:eqqu/screens/shipping_screen.dart';
import 'package:eqqu/screens/secure_account_screen.dart';
import 'package:eqqu/screens/notifications_screen.dart';
import 'package:eqqu/screens/appearance_screen.dart';
import 'package:eqqu/screens/language_screen.dart';
import 'package:eqqu/screens/cart_screen.dart';
import 'package:eqqu/screens/new_listing_screen.dart';
import 'package:eqqu/screens/my_listings_screen.dart';
import 'package:eqqu/screens/my_purchases_screen.dart';
import 'package:eqqu/screens/my_sales_screen.dart';
import 'package:eqqu/screens/order_detail_screen.dart';
import 'package:eqqu/screens/product_detail_screen.dart';
import 'package:eqqu/screens/seller_profile_screen.dart';
import 'package:eqqu/screens/buyer_view_seller_screen.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/screens/profile_screen.dart';
import 'package:eqqu/screens/about_screen.dart';
import 'package:eqqu/screens/how_it_works_screen.dart';
import 'package:eqqu/screens/help_screen.dart';
import 'package:eqqu/screens/feedback_screen.dart';
import 'package:eqqu/screens/invite_friends_screen.dart';
import 'package:eqqu/screens/eqqu_platform_screen.dart';
import 'package:eqqu/screens/reviews_screen.dart';
import 'package:eqqu/screens/build_set_screen.dart';
import 'package:eqqu/screens/address_screen.dart';
import 'package:eqqu/screens/change_password_screen.dart';
import 'package:eqqu/screens/login_overview_screen.dart';
import 'package:eqqu/screens/mimo_staj_screen.dart';
import 'package:eqqu/screens/favorites_screen.dart';

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
