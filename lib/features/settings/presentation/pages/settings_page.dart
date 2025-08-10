import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../services/settings_service.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(SettingsService.themeModeProvider);
    final notificationsEnabled =
        ref.watch(SettingsService.notificationsProvider);
    final biometricEnabled = ref.watch(SettingsService.biometricProvider);
    final language = ref.watch(SettingsService.languageProvider);
    final units = ref.watch(SettingsService.unitsProvider);

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
                  themeMode == ThemeMode.dark,
                  (value) async {
                    final notifier =
                        ref.read(SettingsService.themeModeProvider.notifier);
                    if (value) {
                      await notifier.setThemeMode(ThemeMode.dark);
                    } else {
                      await notifier.setThemeMode(ThemeMode.light);
                    }
                  },
                ),
                _buildDropdownTile(
                  'Language',
                  'Choose your preferred language',
                  Icons.language,
                  language,
                  ['English', 'Spanish', 'French', 'German'],
                  (value) async {
                    if (value != null) {
                      final notifier =
                          ref.read(SettingsService.languageProvider.notifier);
                      await notifier.setLanguage(value);
                    }
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
                  notificationsEnabled,
                  (value) async {
                    final notifier = ref
                        .read(SettingsService.notificationsProvider.notifier);
                    await notifier.toggleNotifications();
                  },
                ),
                _buildDropdownTile(
                  'Units',
                  'Choose your preferred measurement units',
                  Icons.straighten,
                  units,
                  ['Metric', 'Imperial'],
                  (value) async {
                    if (value != null) {
                      final notifier =
                          ref.read(SettingsService.unitsProvider.notifier);
                      await notifier.setUnits(value);
                    }
                  },
                ),
                _buildSwitchTile(
                  'Biometric Authentication',
                  'Use fingerprint or face ID to unlock the app',
                  Icons.fingerprint,
                  biometricEnabled,
                  (value) async {
                    final notifier =
                        ref.read(SettingsService.biometricProvider.notifier);
                    await notifier.toggleBiometric();
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
                  () async {
                    try {
                      final data = await SettingsService.exportData();
                      _showSnackBar('Data exported successfully');
                      // In a real app, you'd save this to a file
                      print('Exported data: $data');
                    } catch (e) {
                      _showSnackBar('Failed to export data');
                    }
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
                    context.push('/help-center');
                  },
                ),
                _buildListTile(
                  'Contact Support',
                  'Get in touch with our support team',
                  Icons.support_agent,
                  () {
                    context.push('/contact-support');
                  },
                ),
                _buildListTile(
                  'Report a Bug',
                  'Help us improve by reporting issues',
                  Icons.bug_report,
                  () {
                    context.push('/bug-report');
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
                    context.push('/terms-of-service');
                  },
                ),
                _buildListTile(
                  'Privacy Policy',
                  'Learn about our privacy practices',
                  Icons.privacy_tip,
                  () {
                    context.push('/privacy-policy');
                  },
                ),
                _buildListTile(
                  'Open Source Licenses',
                  'View third-party licenses',
                  Icons.code,
                  () {
                    context.push('/licenses');
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
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
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
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
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
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
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
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await SettingsService.deleteAccountData();
                  _showSnackBar('Account deleted successfully');
                  // In a real app, you'd navigate to login or onboarding
                  // context.go('/auth');
                } catch (e) {
                  _showSnackBar('Failed to delete account');
                }
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
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await SettingsService.resetToDefaults();

                  // Reset all providers to defaults
                  final themeNotifier =
                      ref.read(SettingsService.themeModeProvider.notifier);
                  final notificationsNotifier =
                      ref.read(SettingsService.notificationsProvider.notifier);
                  final biometricNotifier =
                      ref.read(SettingsService.biometricProvider.notifier);
                  final languageNotifier =
                      ref.read(SettingsService.languageProvider.notifier);
                  final unitsNotifier =
                      ref.read(SettingsService.unitsProvider.notifier);

                  await themeNotifier.setThemeMode(ThemeMode.light);
                  await notificationsNotifier
                      .toggleNotifications(); // This will set to true
                  await biometricNotifier
                      .toggleBiometric(); // This will set to false
                  await languageNotifier.setLanguage('English');
                  await unitsNotifier.setUnits('Metric');

                  _showSnackBar('Settings reset to defaults');
                } catch (e) {
                  _showSnackBar('Failed to reset settings');
                }
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
