import '../models/meal.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockMealRepository implements MealRepository {
  @override
  Future<List<Meal>> getAll() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.meals;
  }

  @override
  Future<Meal?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return MockData.meals.firstWhere((meal) => meal.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Meal> create(Meal item) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // In a real implementation, this would save to a database
    return item;
  }

  @override
  Future<Meal> update(String id, Meal item) async {
    await Future.delayed(const Duration(milliseconds: 600));
    // In a real implementation, this would update the database
    return item;
  }

  @override
  Future<bool> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // In a real implementation, this would delete from database
    return true;
  }

  @override
  Future<List<Meal>> searchMeals(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (query.isEmpty) return MockData.meals;

    final lowercaseQuery = query.toLowerCase();
    return MockData.meals.where((meal) {
      return meal.title.toLowerCase().contains(lowercaseQuery) ||
          meal.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  @override
  Future<List<Meal>> getMealsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.meals.where((meal) => meal.vendorId == vendorId).toList();
  }

  @override
  Future<List<Meal>> getMealsByTags(List<String> tags) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (tags.isEmpty) return MockData.meals;

    return MockData.meals.where((meal) {
      return tags.any((tag) => meal.tags.contains(tag));
    }).toList();
  }

  @override
  Future<List<Meal>> getMealsByCaloriesRange(double min, double max) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.meals.where((meal) {
      return meal.calories >= min && meal.calories <= max;
    }).toList();
  }

  @override
  Future<List<Meal>> getRecommendedMeals(String userId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    // Mock recommendation logic - return random meals
    final random = DateTime.now().millisecondsSinceEpoch;
    final shuffled = List<Meal>.from(MockData.meals);
    shuffled.shuffle();
    return shuffled.take(5).toList();
  }
}
