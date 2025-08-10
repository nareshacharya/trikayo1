import '../models/vendor.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockVendorRepository implements VendorRepository {
  @override
  Future<List<Vendor>> nearby(
      {double? lat, double? lng, double radiusKm = 5}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // Mock implementation - return vendors based on radius
    // In a real app, this would use actual geolocation calculations
    if (radiusKm <= 2) {
      return MockData.vendors.take(2).toList();
    } else if (radiusKm <= 5) {
      return MockData.vendors.take(3).toList();
    } else {
      return MockData.vendors;
    }
  }

  @override
  Future<Vendor> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final vendor = MockData.vendors.firstWhere((vendor) => vendor.id == id);
      return vendor;
    } catch (e) {
      throw Exception('Vendor not found');
    }
  }
}
