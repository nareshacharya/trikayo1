import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;
  String _language = 'English';
  String _units = 'Metric';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> _unitsList = ['Metric', 'Imperial'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Appearance',
              [
                _buildSwitchTile(
                  'Dark Mode',
                  'Use dark theme for the app',
                  Icons.dark_mode,
                  _darkModeEnabled,
                  (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                    // TODO: Implement theme switching
                  },
                ),
                _buildDropdownTile(
                  'Language',
                  'Choose your preferred language',
                  Icons.language,
                  _language,
                  _languages,
                  (value) {
                    setState(() {
                      _language = value!;
                    });
                    // TODO: Implement language switching
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Preferences',
              [
                _buildSwitchTile(
                  'Push Notifications',
                  'Receive notifications about meals and goals',
                  Icons.notifications,
                  _notificationsEnabled,
                  (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    // TODO: Implement notification toggle
                  },
                ),
                _buildDropdownTile(
                  'Units',
                  'Choose your preferred measurement units',
                  Icons.straighten,
                  _units,
                  _unitsList,
                  (value) {
                    setState(() {
                      _units = value!;
                    });
                    // TODO: Implement units switching
                  },
                ),
                _buildSwitchTile(
                  'Biometric Authentication',
                  'Use fingerprint or face ID to unlock the app',
                  Icons.fingerprint,
                  _biometricEnabled,
                  (value) {
                    setState(() {
                      _biometricEnabled = value;
                    });
                    // TODO: Implement biometric toggle
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Data & Privacy',
              [
                _buildListTile(
                  'Export Data',
                  'Download your data as a file',
                  Icons.download,
                  () {
                    // TODO: Implement data export
                    _showSnackBar('Exporting data...');
                  },
                ),
                _buildListTile(
                  'Delete Account',
                  'Permanently remove your account and data',
                  Icons.delete_forever,
                  () {
                    _showDeleteAccountDialog();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Support',
              [
                _buildListTile(
                  'Help Center',
                  'Get help and find answers',
                  Icons.help,
                  () {
                    // TODO: Navigate to help center
                    _showSnackBar('Opening help center...');
                  },
                ),
                _buildListTile(
                  'Contact Support',
                  'Get in touch with our support team',
                  Icons.support_agent,
                  () {
                    // TODO: Navigate to contact support
                    _showSnackBar('Opening contact form...');
                  },
                ),
                _buildListTile(
                  'Report a Bug',
                  'Help us improve by reporting issues',
                  Icons.bug_report,
                  () {
                    // TODO: Navigate to bug report
                    _showSnackBar('Opening bug report form...');
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'About',
              [
                _buildListTile(
                  'App Version',
                  'Trikayo v${AppConstants.appVersion}',
                  Icons.info,
                  null,
                ),
                _buildListTile(
                  'Terms of Service',
                  'Read our terms and conditions',
                  Icons.description,
                  () {
                    // TODO: Navigate to terms
                    _showSnackBar('Opening terms of service...');
                  },
                ),
                _buildListTile(
                  'Privacy Policy',
                  'Learn about our privacy practices',
                  Icons.privacy_tip,
                  () {
                    // TODO: Navigate to privacy policy
                    _showSnackBar('Opening privacy policy...');
                  },
                ),
                _buildListTile(
                  'Open Source Licenses',
                  'View third-party licenses',
                  Icons.code,
                  () {
                    // TODO: Show licenses
                    _showSnackBar('Opening licenses...');
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    IconData icon,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: Container(),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  Widget _buildResetButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () {
          _showResetDialog();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.orange,
          side: BorderSide(color: Colors.orange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
        ),
        child: const Text(
          'Reset to Defaults',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement account deletion
                _showSnackBar('Account deletion requested...');
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Settings'),
          content: const Text(
            'Are you sure you want to reset all settings to their default values?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _notificationsEnabled = true;
                  _darkModeEnabled = false;
                  _biometricEnabled = false;
                  _language = 'English';
                  _units = 'Metric';
                });
                _showSnackBar('Settings reset to defaults');
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
