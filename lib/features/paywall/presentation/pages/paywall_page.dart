import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class PaywallPage extends ConsumerStatefulWidget {
  const PaywallPage({super.key});

  @override
  ConsumerState<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends ConsumerState<PaywallPage> {
  String _selectedTier = 'plus';
  bool _isYearly = true;

  final List<Map<String, dynamic>> _subscriptionTiers = [
    {
      'id': 'basic',
      'name': 'Basic',
      'price': 9.99,
      'yearlyPrice': 99.99,
      'description': 'Perfect for getting started',
      'features': [
        'Track up to 10 meals per day',
        'Basic nutrition insights',
        'Standard meal recommendations',
        'Email support',
      ],
      'color': Colors.blue,
    },
    {
      'id': 'plus',
      'name': 'Plus',
      'price': 19.99,
      'yearlyPrice': 199.99,
      'description': 'Most popular choice',
      'features': [
        'Unlimited meal tracking',
        'Advanced nutrition analytics',
        'Personalized meal plans',
        'Priority support',
        'Recipe suggestions',
        'Progress reports',
      ],
      'color': AppTheme.primaryColor,
      'isPopular': true,
    },
    {
      'id': 'pro',
      'name': 'Pro',
      'price': 29.99,
      'yearlyPrice': 299.99,
      'description': 'For health professionals',
      'features': [
        'Everything in Plus',
        'AI-powered meal optimization',
        'Custom nutrition goals',
        '24/7 support',
        'Advanced analytics',
        'Team collaboration',
        'API access',
      ],
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildBillingToggle(),
              const SizedBox(height: 24),
              _buildSubscriptionTiers(),
              const SizedBox(height: 32),
              _buildFeaturesComparison(),
              const SizedBox(height: 32),
              _buildSubscribeButton(),
              const SizedBox(height: 16),
              _buildTermsAndPrivacy(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
        const SizedBox(height: 16),
        Text(
          'Unlock Premium Features',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Take your nutrition journey to the next level with personalized insights, unlimited tracking, and expert guidance.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildBillingToggle() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isYearly = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        !_isYearly ? AppTheme.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Monthly',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: !_isYearly ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isYearly = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        _isYearly ? AppTheme.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Yearly (Save 20%)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isYearly ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionTiers() {
    return Column(
      children: _subscriptionTiers.map((tier) {
        final isSelected = _selectedTier == tier['id'];
        final price = _isYearly ? tier['yearlyPrice'] : tier['price'];
        final monthlyPrice =
            _isYearly ? (tier['yearlyPrice'] / 12) : tier['price'];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () => setState(() => _selectedTier = tier['id']),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? tier['color'] : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(16),
                color:
                    isSelected ? tier['color'].withOpacity(0.05) : Colors.white,
              ),
              child: Stack(
                children: [
                  if (tier['isPopular'] == true)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: tier['color'],
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          'POPULAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tier['name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: tier['color'],
                                  ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${price.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                if (_isYearly)
                                  Text(
                                    '\$${monthlyPrice.toStringAsFixed(2)}/mo',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tier['description'],
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        const SizedBox(height: 16),
                        ...(tier['features'].map<Widget>((feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: tier['color'],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeaturesComparison() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why Choose Premium?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            _buildFeatureRow(
              Icons.analytics,
              'Advanced Analytics',
              'Get detailed insights into your nutrition patterns and progress',
            ),
            _buildFeatureRow(
              Icons.person,
              'Personalized Plans',
              'AI-powered meal recommendations based on your goals',
            ),
            _buildFeatureRow(
              Icons.support_agent,
              'Expert Support',
              'Get help from nutrition experts when you need it',
            ),
            _buildFeatureRow(
              Icons.sync,
              'Sync Across Devices',
              'Access your data anywhere, anytime',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    final selectedTier =
        _subscriptionTiers.firstWhere((tier) => tier['id'] == _selectedTier);
    final price =
        _isYearly ? selectedTier['yearlyPrice'] : selectedTier['price'];

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement subscription logic
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Subscribing to ${selectedTier['name']}...'),
              backgroundColor: AppTheme.primaryColor,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedTier['color'],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
        ),
        child: Text(
          'Subscribe to ${selectedTier['name']} - \$${price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Column(
      children: [
        Text(
          'By subscribing, you agree to our Terms of Service and Privacy Policy.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // TODO: Navigate to terms
              },
              child: const Text('Terms of Service'),
            ),
            Text(
              '•',
              style: TextStyle(color: Colors.grey[500]),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to privacy
              },
              child: const Text('Privacy Policy'),
            ),
          ],
        ),
      ],
    );
  }
}
