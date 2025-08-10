import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user.dart' as app_user;
import '../core/constants/app_constants.dart';

class AuthService {
  app_user.User? _currentUser;
  bool _isSignedIn = false;

  // Mock sign in with email
  Future<app_user.User?> signInWithEmail(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock user data
      _currentUser = app_user.User(
        id: 'mock_user_001',
        email: email,
        name: 'Mock User',
        phone: '+1234567890',
        tier: 'Basic',
        avatarUrl: null,
      );

      _isSignedIn = true;
      return _currentUser;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Mock sign in with Google
  Future<app_user.User?> signInWithGoogle() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock user data
      _currentUser = app_user.User(
        id: 'google_user_001',
        email: 'user@gmail.com',
        name: 'Google User',
        phone: '+1234567890',
        tier: 'Basic',
        avatarUrl: null,
      );

      _isSignedIn = true;
      return _currentUser;
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  // Mock sign in with Apple
  Future<app_user.User?> signInWithApple() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock user data
      _currentUser = app_user.User(
        id: 'apple_user_001',
        email: 'user@icloud.com',
        name: 'Apple User',
        phone: '+1234567890',
        tier: 'Basic',
        avatarUrl: null,
      );

      _isSignedIn = true;
      return _currentUser;
    } catch (e) {
      throw Exception('Failed to sign in with Apple: $e');
    }
  }

  // Send OTP to email (mock)
  Future<void> sendOtp(String email) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      if (kDebugMode) {
        print('Mock OTP sent to $email: 123456');
      }
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Verify OTP (mock)
  Future<app_user.User?> verifyOtp(String email, String otp) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock verification (accept any 6-digit code)
      if (otp.length == 6 && int.tryParse(otp) != null) {
        _currentUser = app_user.User(
          id: 'otp_user_001',
          email: email,
          name: 'OTP User',
          phone: '+1234567890',
          tier: 'Basic',
          avatarUrl: null,
        );

        _isSignedIn = true;
        return _currentUser;
      } else {
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      _currentUser = null;
      _isSignedIn = false;
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  // Get current user
  app_user.User? getCurrentUser() {
    return _currentUser;
  }

  // Check if user is signed in
  bool get isSignedIn => _isSignedIn;

  // Stream of auth state changes (mock)
  Stream<app_user.User?> get authStateChanges {
    return Stream.value(_currentUser);
  }

  // Create user profile from mock data
  app_user.User createUserProfile(app_user.User user) {
    return user;
  }
}

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Provider for current user
final currentUserProvider = StreamProvider<app_user.User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Provider for authentication state
final isAuthenticatedProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});
