class AppConstants {
  static const String appName = 'Trikayo';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String apiBaseUrl = 'https://api.trikayo.com';
  static const int apiTimeout = 30000;

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';
  static const String onboardingCompletedKey = 'onboarding_completed';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultIconSize = 24.0;

  // Subscription Tiers
  static const String tierBasic = 'Basic';
  static const String tierPlus = 'Plus';
  static const String tierPro = 'Pro';

  // Order Status
  static const String orderStatusPlaced = 'placed';
  static const String orderStatusPreparing = 'preparing';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';

  // Intake Status
  static const String intakeStatusPending = 'pending';
  static const String intakeStatusConsumed = 'consumed';
  static const String intakeStatusPartial = 'partial';
  static const String intakeStatusSkipped = 'skipped';
}
