import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildQuickHelpSection(),
            const SizedBox(height: 24),
            _buildFaqSection(),
            const SizedBox(height: 24),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for help...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Help',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildQuickHelpCard(
              'Getting Started',
              Icons.play_circle_filled,
              'Learn the basics',
              () {},
            ),
            _buildQuickHelpCard(
              'Meal Tracking',
              Icons.restaurant,
              'Track your meals',
              () {},
            ),
            _buildQuickHelpCard(
              'Nutrition Goals',
              Icons.track_changes,
              'Set and achieve goals',
              () {},
            ),
            _buildQuickHelpCard(
              'Account Settings',
              Icons.settings,
              'Manage your account',
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickHelpCard(
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    final List<Map<String, String>> faqs = [
      {
        'question': 'How do I track my meals?',
        'answer': 'Tap the + button on the home screen and select "Add Meal". Choose from your recent meals or search for new ones.',
      },
      {
        'question': 'How do I set nutrition goals?',
        'answer': 'Go to Profile > Goals to set your daily calorie, protein, carb, and fat targets.',
      },
      {
        'question': 'Can I export my data?',
        'answer': 'Yes! Go to Settings > Data & Privacy > Export Data to download your information.',
      },
      {
        'question': 'How do I change my subscription?',
        'answer': 'Navigate to Profile > Subscription to view and modify your current plan.',
      },
      {
        'question': 'What if I forgot my password?',
        'answer': 'Use the "Forgot Password" option on the login screen to reset your password via email.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return _buildFaqTile(faqs[index]['question']!, faqs[index]['answer']!);
          },
        ),
      ],
    );
  }

  Widget _buildFaqTile(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Still Need Help?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.email, color: AppTheme.primaryColor),
                  title: const Text('Email Support'),
                  subtitle: const Text('Get a response within 24 hours'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement email support
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.chat, color: AppTheme.primaryColor),
                  title: const Text('Live Chat'),
                  subtitle: const Text('Available 9 AM - 6 PM EST'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement live chat
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.phone, color: AppTheme.primaryColor),
                  title: const Text('Call Us'),
                  subtitle: const Text('1-800-TRIKAYO'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement phone call
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
