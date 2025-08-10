import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
            _buildPrivacyContent(),
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
              Icons.privacy_tip,
              size: 48,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We are committed to protecting your privacy and ensuring the security of your personal information.',
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

  Widget _buildPrivacyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          'Information We Collect',
          'We collect information you provide directly to us, such as when you create an account, track meals, or contact support. This may include your name, email address, meal data, nutrition goals, and preferences.',
        ),
        _buildSection(
          'How We Use Your Information',
          'We use the information we collect to provide, maintain, and improve our services, personalize your experience, communicate with you, and ensure the security of our platform.',
        ),
        _buildSection(
          'Information Sharing',
          'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy or required by law.',
        ),
        _buildSection(
          'Data Security',
          'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.',
        ),
        _buildSection(
          'Data Retention',
          'We retain your personal information for as long as necessary to provide our services and fulfill the purposes outlined in this policy, unless a longer retention period is required by law.',
        ),
        _buildSection(
          'Your Rights',
          'You have the right to access, update, or delete your personal information. You can also opt out of certain communications and request data portability. Contact us to exercise these rights.',
        ),
        _buildSection(
          'Cookies and Tracking',
          'We use cookies and similar technologies to enhance your experience, analyze usage patterns, and provide personalized content. You can control cookie settings through your browser preferences.',
        ),
        _buildSection(
          'Third-Party Services',
          'Our app may integrate with third-party services for analytics, payment processing, and other functionality. These services have their own privacy policies and data handling practices.',
        ),
        _buildSection(
          'Children\'s Privacy',
          'Our services are not intended for children under 13. We do not knowingly collect personal information from children under 13. If you believe we have collected such information, please contact us.',
        ),
        _buildSection(
          'International Transfers',
          'Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place to protect your information in accordance with this policy.',
        ),
        _buildSection(
          'Changes to This Policy',
          'We may update this privacy policy from time to time. We will notify you of any material changes by posting the new policy on our app and updating the "Last Updated" date.',
        ),
        _buildSection(
          'Contact Us',
          'If you have questions about this privacy policy or our data practices, please contact us at privacy@trikayo.com.',
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
              'By using Trikayo, you acknowledge that you have read and understood this Privacy Policy and consent to the collection and use of your information as described herein.',
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
