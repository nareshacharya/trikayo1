import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/constants/app_constants.dart';

class SettingsService {
  static const String _notificationsKey = 'notifications_enabled';
  static const String _darkModeKey = 'dark_mode_enabled';
  static const String _biometricKey = 'biometric_enabled';
  static const String _languageKey = 'language';
  static const String _unitsKey = 'units';

  // Theme mode provider
  static final themeModeProvider = StateProvider<ThemeMode>((ref) {
    return ThemeMode.system;
  });

  // Notifications provider
  static final notificationsProvider = StateProvider<bool>((ref) {
    return true;
  });

  // Language provider
  static final languageProvider = StateProvider<String>((ref) {
    return 'English';
  });

  // Units provider
  static final unitsProvider = StateProvider<String>((ref) {
    return 'Metric';
  });

  // Biometric provider
  static final biometricProvider = StateProvider<bool>((ref) {
    return false;
  });

  // Initialize settings
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    // Load saved settings
    final notificationsEnabled = prefs.getBool(_notificationsKey) ?? true;
    final darkModeEnabled = prefs.getBool(_darkModeKey) ?? false;
    final biometricEnabled = prefs.getBool(_biometricKey) ?? false;
    final language = prefs.getString(_languageKey) ?? 'English';
    final units = prefs.getString(_unitsKey) ?? 'Metric';

    // Initialize providers with saved values
    // Note: In a real app, you'd use a proper state management solution
    // This is a simplified approach for demonstration
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
    final prefs = await SharedPreferences.getInstance();
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

  // Request notification permissions
  static Future<void> _requestNotificationPermissions() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'trikayo_channel',
      'Trikayo Notifications',
      channelDescription: 'Notifications for meal tracking and goals',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Welcome to Trikayo!',
      'Notifications are now enabled',
      platformChannelSpecifics,
    );
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
