import '../models/user.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockUserRepository implements UserRepository {
  User? _currentUser;

  MockUserRepository() {
    // Initialize with a mock user
    _currentUser = const User(
      id: 'user_1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+1234567890',
      tier: 'Basic',
      avatarUrl: 'https://example.com/avatar.jpg',
    );
  }

  @override
  Future<User> me() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (_currentUser == null) {
      throw Exception('User not authenticated');
    }

    return _currentUser!;
  }

  @override
  Future<void> updateTier(String code) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (_currentUser == null) {
      throw Exception('User not authenticated');
    }

    // Validate tier code
    if (!['Basic', 'Plus', 'Pro'].contains(code)) {
      throw Exception('Invalid tier code');
    }

    // Update user tier
    _currentUser = _currentUser!.copyWith(tier: code);
  }

  // Helper method to get current user (for testing)
  User? get currentUser => _currentUser;
}
