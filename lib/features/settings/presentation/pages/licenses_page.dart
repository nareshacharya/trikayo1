import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class LicensesPage extends StatelessWidget {
  const LicensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Source Licenses'),
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
            _buildLicensesList(),
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
              Icons.code,
              size: 48,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Open Source Licenses',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Trikayo is built with the help of many open source libraries. We are grateful to the developers who have contributed to these projects.',
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

  Widget _buildLicensesList() {
    final List<Map<String, String>> licenses = [
      {
        'name': 'Flutter',
        'version': '3.10.0+',
        'license': 'BSD 3-Clause License',
        'description':
            'Google\'s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
      },
      {
        'name': 'Dart',
        'version': '3.0.0+',
        'license': 'BSD 3-Clause License',
        'description':
            'A client-optimized programming language for fast apps on any platform.',
      },
      {
        'name': 'flutter_riverpod',
        'version': '2.4.9',
        'license': 'MIT License',
        'description':
            'A state management library that combines the simplicity of Provider with the power of Riverpod.',
      },
      {
        'name': 'go_router',
        'version': '12.1.3',
        'license': 'BSD 3-Clause License',
        'description':
            'A declarative routing package for Flutter that uses the Router 2.0 API.',
      },
      {
        'name': 'dio',
        'version': '5.3.2',
        'license': 'MIT License',
        'description':
            'A powerful HTTP client for Dart, which supports Interceptors, Global configuration, FormData, Request cancellation, File downloading, Timeout etc.',
      },
      {
        'name': 'shared_preferences',
        'version': '2.2.2',
        'license': 'MIT License',
        'description':
            'Flutter plugin for reading and writing simple key-value pairs.',
      },
      {
        'name': 'hive',
        'version': '2.2.3',
        'license': 'Apache License 2.0',
        'description':
            'Lightweight and fast key-value database written in pure Dart.',
      },
      {
        'name': 'firebase_core',
        'version': '2.24.2',
        'license': 'Apache License 2.0',
        'description':
            'Flutter plugin for Firebase Core, enabling you to use Firebase services in your Flutter app.',
      },
      {
        'name': 'firebase_auth',
        'version': '4.15.3',
        'license': 'Apache License 2.0',
        'description':
            'Flutter plugin for Firebase Authentication, enabling you to use Firebase Authentication in your Flutter app.',
      },
      {
        'name': 'google_sign_in',
        'version': '6.1.6',
        'license': 'Apache License 2.0',
        'description':
            'Flutter plugin for Google Sign In, enabling you to use Google Sign In in your Flutter app.',
      },
      {
        'name': 'flutter_local_notifications',
        'version': '16.3.0',
        'license': 'MIT License',
        'description': 'A Flutter plugin for displaying local notifications.',
      },
      {
        'name': 'flutter_animate',
        'version': '4.2.0',
        'license': 'MIT License',
        'description':
            'A library that makes it simple to add almost any kind of animated effect in Flutter.',
      },
      {
        'name': 'lottie',
        'version': '2.7.0',
        'license': 'Apache License 2.0',
        'description': 'A Flutter package for displaying Lottie animations.',
      },
      {
        'name': 'google_fonts',
        'version': '6.1.0',
        'license': 'Apache License 2.0',
        'description': 'A Flutter package to use fonts from fonts.google.com.',
      },
      {
        'name': 'intl',
        'version': '0.18.1',
        'license': 'BSD 3-Clause License',
        'description':
            'Contains code to deal with internationalized/localized messages, date and number formatting and parsing, bi-directional text, and other internationalization issues.',
      },
      {
        'name': 'equatable',
        'version': '2.0.5',
        'license': 'MIT License',
        'description':
            'A Dart package that helps to implement value based equality without needing to explicitly override == and hashCode.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Third-Party Libraries',
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
          itemCount: licenses.length,
          itemBuilder: (context, index) {
            final license = licenses[index];
            return _buildLicenseCard(
              license['name']!,
              license['version']!,
              license['license']!,
              license['description']!,
            );
          },
        ),
      ],
    );
  }

  Widget _buildLicenseCard(
      String name, String version, String license, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Version $version',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    license,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
