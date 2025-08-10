import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  bool _isLoading = false;
  bool _isResendEnabled = true;
  int _resendCountdown = 30;
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/auth/email'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _buildHeader(),
              const SizedBox(height: 40),
              _buildOtpField(),
              const SizedBox(height: 24),
              _buildVerifyButton(),
              const SizedBox(height: 24),
              _buildResendSection(),
              const Spacer(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.verified_outlined,
            size: 50,
            color: AppTheme.primaryColor,
          ),
        ).animate().scale(duration: AppConstants.mediumAnimation),
        const SizedBox(height: 24),
        Text(
          'Verify your account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(delay: AppConstants.shortAnimation),
        const SizedBox(height: 16),
        Text(
          'We\'ve sent a verification code to your email',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: AppConstants.mediumAnimation),
        const SizedBox(height: 8),
        Text(
          'user@example.com', // TODO: Get actual email from auth flow
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryColor,
          ),
        ).animate().fadeIn(delay: AppConstants.mediumAnimation),
      ],
    );
  }

  Widget _buildOtpField() {
    return Column(
      children: [
        TextField(
          maxLength: 6,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: 'Enter 6-digit code',
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _otp = value;
            });
          },
        )
            .animate()
            .slideY(begin: 0.3, end: 0, delay: AppConstants.shortAnimation),
        const SizedBox(height: 16),
        Text(
          'Enter the 6-digit code',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ).animate().fadeIn(delay: AppConstants.mediumAnimation),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed:
            (_otp.length == 6 && !_isLoading) ? _handleVerification : null,
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Verify & Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    ).animate().slideY(begin: 0.3, end: 0, delay: AppConstants.longAnimation);
  }

  Widget _buildResendSection() {
    return Column(
      children: [
        Text(
          'Didn\'t receive the code?',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ).animate().fadeIn(delay: AppConstants.longAnimation),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _isResendEnabled ? _handleResend : null,
          child: Text(
            _isResendEnabled
                ? 'Resend Code'
                : 'Resend in $_resendCountdown seconds',
            style: TextStyle(
              color: _isResendEnabled
                  ? AppTheme.primaryColor
                  : AppTheme.textDisabled,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate().fadeIn(delay: AppConstants.longAnimation),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Having trouble? ',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to help/support
              },
              child: Text(
                'Get Help',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: AppConstants.longAnimation);
  }

  Future<void> _handleVerification() async {
    if (_otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit code'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual OTP verification logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to home after successful verification
      context.go('/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleResend() async {
    setState(() {
      _isResendEnabled = false;
      _resendCountdown = 30;
    });

    try {
      // TODO: Implement actual resend logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code resent successfully'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      _startResendCountdown();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend code: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );

      setState(() {
        _isResendEnabled = true;
      });
    }
  }

  void _startResendCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _resendCountdown--;
        });
      }

      if (_resendCountdown <= 0) {
        setState(() {
          _isResendEnabled = true;
        });
        return false;
      }
      return true;
    });
  }
}
