import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/auth_landing_page.dart';
import '../../features/auth/presentation/pages/email_auth_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/catalog/presentation/pages/catalog_page.dart';
import '../../features/meal_details/presentation/pages/meal_details_page.dart';
import '../../features/checkout/presentation/pages/checkout_page.dart';
import '../../features/checkout/presentation/pages/order_confirmation_page.dart';
import '../../features/intake/presentation/pages/intake_page.dart';
import '../../features/paywall/presentation/pages/paywall_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static const String home = '/';
  static const String auth = '/auth';
  static const String emailAuth = '/auth/email';
  static const String otpVerification = '/auth/otp';
  static const String catalog = '/catalog';
  static const String mealDetails = '/meal/:id';
  static const String checkout = '/checkout';
  static const String orderConfirmation = '/order-confirmation';
  static const String intake = '/intake';
  static const String paywall = '/paywall';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String settings = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      // Auth Routes
      GoRoute(path: auth, builder: (context, state) => const AuthLandingPage()),
      GoRoute(
        path: emailAuth,
        builder: (context, state) => const EmailAuthPage(),
      ),
      GoRoute(
        path: otpVerification,
        builder: (context, state) => const OtpVerificationPage(),
      ),

      // Main App Routes
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(path: home, builder: (context, state) => const HomePage()),
          GoRoute(
            path: catalog,
            builder: (context, state) => const CatalogPage(),
          ),
          GoRoute(
            path: mealDetails,
            builder: (context, state) {
              final mealId = state.pathParameters['id']!;
              return MealDetailsPage(mealId: mealId);
            },
          ),
          GoRoute(
            path: checkout,
            builder: (context, state) => const CheckoutPage(),
          ),
          GoRoute(
            path: orderConfirmation,
            builder: (context, state) => const OrderConfirmationPage(),
          ),
          GoRoute(
            path: intake,
            builder: (context, state) => const IntakePage(),
          ),
          GoRoute(
            path: paywall,
            builder: (context, state) => const PaywallPage(),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: orders,
            builder: (context, state) => const OrdersPage(),
          ),
          GoRoute(
            path: settings,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
}

class _MainShell extends StatelessWidget {
  final Widget child;

  const _MainShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(location),
      onTap: (index) => _onTabTapped(context, index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Catalog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Orders',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/catalog')) return 1;
    if (location.startsWith('/orders')) return 2;
    if (location.startsWith('/profile') || location.startsWith('/settings'))
      return 3;
    return 0; // Home
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.catalog);
        break;
      case 2:
        context.go(AppRouter.orders);
        break;
      case 3:
        context.go(AppRouter.profile);
        break;
    }
  }
}
