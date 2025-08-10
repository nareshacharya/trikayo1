# Settings Implementation Documentation

## Overview
The settings functionality has been fully implemented in the Trikayo app, providing users with comprehensive control over app preferences, appearance, and data management.

## Features Implemented

### 1. Theme Management
- **Dark Mode Toggle**: Users can switch between light and dark themes
- **Persistent Storage**: Theme preference is saved and restored on app restart
- **Real-time Updates**: Theme changes are applied immediately throughout the app

### 2. Notification Settings
- **Push Notifications Toggle**: Enable/disable push notifications
- **Permission Management**: Automatically requests notification permissions when enabled
- **Welcome Notification**: Shows a welcome message when notifications are first enabled

### 3. Biometric Authentication
- **Fingerprint/Face ID Support**: Uses device biometric capabilities
- **Availability Check**: Automatically detects if biometric authentication is available
- **Secure Storage**: Biometric preference is securely stored

### 4. Language & Units
- **Language Selection**: Support for English, Spanish, French, and German
- **Measurement Units**: Toggle between Metric and Imperial units
- **Persistent Settings**: All preferences are saved locally

### 5. Data Management
- **Data Export**: Export user settings and app data
- **Account Deletion**: Permanently remove user account and data
- **Settings Reset**: Reset all settings to default values

### 6. Support & Legal
- **Help Center**: Access to help documentation
- **Contact Support**: Direct communication with support team
- **Bug Reporting**: Report issues and provide feedback
- **Legal Pages**: Terms of Service, Privacy Policy, and Open Source Licenses

## Technical Implementation

### Architecture
- **Riverpod State Management**: Uses StateNotifierProvider for reactive state management
- **SharedPreferences**: Local storage for persistent settings
- **Provider Pattern**: Clean separation of concerns with dedicated notifiers

### Key Classes

#### SettingsService
- Main service class with static methods for data operations
- Manages SharedPreferences storage
- Handles data export and account deletion

#### ThemeModeNotifier
- Manages theme state (light/dark/system)
- Persists theme preference
- Provides methods for theme switching

#### NotificationsNotifier
- Manages notification settings
- Handles permission requests
- Shows welcome notification

#### BiometricNotifier
- Manages biometric authentication settings
- Checks device compatibility
- Handles authentication flow

#### LanguageNotifier & UnitsNotifier
- Manage language and units preferences
- Persist user choices
- Provide reactive updates

### State Management Flow
1. **Initialization**: Notifiers load saved preferences on creation
2. **User Interaction**: UI calls notifier methods to update settings
3. **State Update**: Notifiers update their state and persist changes
4. **UI Update**: Riverpod automatically rebuilds UI with new values
5. **Persistence**: Changes are saved to SharedPreferences

## Usage Examples

### Theme Switching
```dart
final themeNotifier = ref.read(SettingsService.themeModeProvider.notifier);
await themeNotifier.setThemeMode(ThemeMode.dark);
```

### Notification Toggle
```dart
final notificationsNotifier = ref.read(SettingsService.notificationsProvider.notifier);
await notificationsNotifier.toggleNotifications();
```

### Biometric Authentication
```dart
final biometricNotifier = ref.read(SettingsService.biometricProvider.notifier);
await biometricNotifier.toggleBiometric();
```

### Language Change
```dart
final languageNotifier = ref.read(SettingsService.languageProvider.notifier);
await languageNotifier.setLanguage('Spanish');
```

## Navigation
The settings page provides navigation to various support and legal pages:
- `/help-center` - Help documentation
- `/contact-support` - Support contact form
- `/bug-report` - Bug reporting form
- `/terms-of-service` - Terms and conditions
- `/privacy-policy` - Privacy policy
- `/licenses` - Open source licenses

## Future Enhancements
- **Cloud Sync**: Sync settings across devices
- **Advanced Notifications**: Customizable notification schedules
- **Accessibility**: Screen reader support and font scaling
- **Backup/Restore**: Settings backup to cloud storage
- **Analytics**: Usage analytics for settings preferences

## Testing
To test the settings functionality:
1. Navigate to the Settings page
2. Toggle various settings (theme, notifications, biometric)
3. Verify changes are applied immediately
4. Restart the app to verify persistence
5. Test navigation to support and legal pages

## Dependencies
- `flutter_riverpod`: State management
- `shared_preferences`: Local storage
- `flutter_local_notifications`: Notification management
- `local_auth`: Biometric authentication
- `go_router`: Navigation

## Notes
- All settings are stored locally using SharedPreferences
- Biometric authentication requires device support
- Notification permissions are requested when enabled
- Theme changes are applied globally throughout the app
- Settings reset clears all user preferences
