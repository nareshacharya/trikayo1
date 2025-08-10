import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildTermsContent(),
            const SizedBox(height: 24),
            _buildLastUpdated(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.description,
              size: 48,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please read these terms carefully before using our service.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          '1. Acceptance of Terms',
          'By accessing and using the Trikayo mobile application ("App"), you accept and agree to be bound by the terms and provision of this agreement.',
        ),
        _buildSection(
          '2. Description of Service',
          'Trikayo is a meal tracking and nutrition management application that helps users monitor their dietary intake, set nutrition goals, and track their progress towards health objectives.',
        ),
        _buildSection(
          '3. User Accounts',
          'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.',
        ),
        _buildSection(
          '4. Acceptable Use',
          'You agree to use the App only for lawful purposes and in accordance with these Terms. You agree not to use the App to transmit any harmful, offensive, or inappropriate content.',
        ),
        _buildSection(
          '5. Privacy Policy',
          'Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the App, to understand our practices.',
        ),
        _buildSection(
          '6. Subscription and Payment',
          'Some features of the App may require a subscription. Subscription fees are billed in advance on a recurring basis. You may cancel your subscription at any time through your account settings.',
        ),
        _buildSection(
          '7. Intellectual Property',
          'The App and its original content, features, and functionality are owned by Trikayo and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.',
        ),
        _buildSection(
          '8. Disclaimer of Warranties',
          'The App is provided "as is" without any warranties, express or implied. We do not guarantee that the App will be error-free or uninterrupted.',
        ),
        _buildSection(
          '9. Limitation of Liability',
          'In no event shall Trikayo be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the App.',
        ),
        _buildSection(
          '10. Termination',
          'We may terminate or suspend your account and access to the App immediately, without prior notice, for any reason, including breach of these Terms.',
        ),
        _buildSection(
          '11. Governing Law',
          'These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which Trikayo operates.',
        ),
        _buildSection(
          '12. Changes to Terms',
          'We reserve the right to modify these Terms at any time. We will notify users of any material changes by posting the new Terms on the App.',
        ),
        _buildSection(
          '13. Contact Information',
          'If you have any questions about these Terms, please contact us at legal@trikayo.com.',
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: 32,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 12),
            Text(
              'Last Updated',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'December 15, 2024',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'By using Trikayo, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
