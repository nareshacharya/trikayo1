import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              _buildHeader(),
              const SizedBox(height: 40),
              _buildAuthOptions(context),
              const SizedBox(height: 40),
              _buildFooter(context),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App Logo/Icon placeholder
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Icon(
            Icons.restaurant_menu,
            size: 60,
            color: AppTheme.primaryColor,
          ),
        ).animate().scale(duration: AppConstants.mediumAnimation),

        const SizedBox(height: 24),

        Text(
          'Welcome to Trikayo',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(delay: AppConstants.shortAnimation),

        const SizedBox(height: 16),

        Text(
          'Your personal meal tracking companion',
          style: TextStyle(
            fontSize: 18,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: AppConstants.mediumAnimation),
      ],
    );
  }

  Widget _buildAuthOptions(BuildContext context) {
    return Column(
      children: [
        _buildAuthButton(
          context,
          'Continue with Email',
          Icons.email_outlined,
          AppTheme.primaryColor,
          () => context.go('/auth/email'),
        )
            .animate()
            .slideY(begin: 0.3, end: 0, delay: AppConstants.mediumAnimation),
        const SizedBox(height: 16),
        _buildAuthButton(
          context,
          'Continue with Google',
          Icons.g_mobiledata,
          Colors.red,
          () {
            // TODO: Implement Google Sign In
          },
        )
            .animate()
            .slideY(begin: 0.3, end: 0, delay: AppConstants.longAnimation),
        const SizedBox(height: 16),
        _buildAuthButton(
          context,
          'Continue with Apple',
          Icons.apple,
          Colors.black,
          () {
            // TODO: Implement Apple Sign In
          },
        )
            .animate()
            .slideY(begin: 0.3, end: 0, delay: AppConstants.longAnimation),
      ],
    );
  }

  Widget _buildAuthButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'By continuing, you agree to our',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // TODO: Navigate to Terms of Service
              },
              child: Text(
                'Terms of Service',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              ' and ',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to Privacy Policy
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: AppConstants.longAnimation);
  }
}
