import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_auth/local_auth.dart';

import '../core/constants/app_constants.dart';

class SettingsService {
  static const String _notificationsKey = 'notifications_enabled';
  static const String _darkModeKey = 'dark_mode_enabled';
  static const String _biometricKey = 'biometric_enabled';
  static const String _languageKey = 'language';
  static const String _unitsKey = 'units';

  // Theme mode provider
  static final themeModeProvider =
      StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
    return ThemeModeNotifier();
  });

  // Notifications provider
  static final notificationsProvider =
      StateNotifierProvider<NotificationsNotifier, bool>((ref) {
    return NotificationsNotifier();
  });

  // Language provider
  static final languageProvider =
      StateNotifierProvider<LanguageNotifier, String>((ref) {
    return LanguageNotifier();
  });

  // Units provider
  static final unitsProvider =
      StateNotifierProvider<UnitsNotifier, String>((ref) {
    return UnitsNotifier();
  });

  // Biometric provider
  static final biometricProvider =
      StateNotifierProvider<BiometricNotifier, bool>((ref) {
    return BiometricNotifier();
  });

  // Initialize settings
  static Future<void> initialize() async {
    // This method is kept for backward compatibility
    // The actual initialization is now handled by the individual notifiers
  }

  // Save notification setting
  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);

    if (enabled) {
      await _requestNotificationPermissions();
    }
  }

  // Save theme setting
  static Future<void> setDarkModeEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, enabled);
  }

  // Save language setting
  static Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language);
  }

  // Save units setting
  static Future<void> setUnits(String units) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_unitsKey, units);
  }

  // Save biometric setting
  static Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricKey, enabled);

    if (enabled) {
      await _checkBiometricAvailability();
    }
  }

  // Get saved settings
  static Future<Map<String, dynamic>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'notifications': prefs.getBool(_notificationsKey) ?? true,
      'darkMode': prefs.getBool(_darkModeKey) ?? false,
      'biometric': prefs.getBool(_biometricKey) ?? false,
      'language': prefs.getString(_languageKey) ?? 'English',
      'units': prefs.getString(_unitsKey) ?? 'Metric',
    };
  }

  // Reset all settings to defaults
  static Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationsKey);
    await prefs.remove(_darkModeKey);
    await prefs.remove(_biometricKey);
    await prefs.remove(_languageKey);
    await prefs.remove(_unitsKey);
  }

  // Export user data
  static Future<Map<String, dynamic>> exportData() async {
    final settings = await getSettings();

    // In a real app, you'd also export user data, meal history, etc.
    return {
      'exportDate': DateTime.now().toIso8601String(),
      'settings': settings,
      'appVersion': AppConstants.appVersion,
    };
  }

  // Delete account data
  static Future<void> deleteAccountData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // In a real app, you'd also delete data from your backend
    // and handle account deletion through your auth service
  }

  // Request notification permissions (temporarily disabled)
  static Future<void> _requestNotificationPermissions() async {
    // TODO: Implement when flutter_local_notifications is available
    // For now, just simulate success
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Check biometric availability (simplified version)
  static Future<bool> _checkBiometricAvailability() async {
    // For now, return true to simulate biometric availability
    // In a real app, you'd check actual device capabilities
    return true;
  }

  // Test biometric authentication (simplified version)
  static Future<bool> authenticateWithBiometrics() async {
    // For now, simulate successful authentication
    // In a real app, you'd use actual biometric authentication
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}

// Theme Mode Notifier
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
    state = darkModeEnabled ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newMode;
    await prefs.setBool('dark_mode_enabled', newMode == ThemeMode.dark);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    state = mode;
    await prefs.setBool('dark_mode_enabled', mode == ThemeMode.dark);
  }
}

// Notifications Notifier
class NotificationsNotifier extends StateNotifier<bool> {
  NotificationsNotifier() : super(true) {
    _loadNotificationsSetting();
  }

  Future<void> _loadNotificationsSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('notifications_enabled') ?? true;
  }

  Future<void> toggleNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    state = !state;
    await prefs.setBool('notifications_enabled', state);

    if (state) {
      await _requestNotificationPermissions();
    }
  }

  Future<void> _requestNotificationPermissions() async {
    // TODO: Implement when flutter_local_notifications is available
    // For now, just simulate success
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

// Language Notifier
class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super('English') {
    _loadLanguageSetting();
  }

  Future<void> _loadLanguageSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('language') ?? 'English';
  }

  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    state = language;
    await prefs.setString('language', language);
  }
}

// Units Notifier
class UnitsNotifier extends StateNotifier<String> {
  UnitsNotifier() : super('Metric') {
    _loadUnitsSetting();
  }

  Future<void> _loadUnitsSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('units') ?? 'Metric';
  }

  Future<void> setUnits(String units) async {
    final prefs = await SharedPreferences.getInstance();
    state = units;
    await prefs.setString('units', units);
  }
}

// Biometric Notifier
class BiometricNotifier extends StateNotifier<bool> {
  BiometricNotifier() : super(false) {
    _loadBiometricSetting();
  }

  Future<void> _loadBiometricSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('biometric_enabled') ?? false;
  }

  Future<void> toggleBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    state = !state;
    await prefs.setBool('biometric_enabled', state);

    if (state) {
      await _checkBiometricAvailability();
    }
  }

  Future<bool> _checkBiometricAvailability() async {
    // TODO: Implement when local_auth is available
    // For now, just simulate success
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> authenticateWithBiometrics() async {
    // TODO: Implement when local_auth is available
    // For now, just simulate success
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
