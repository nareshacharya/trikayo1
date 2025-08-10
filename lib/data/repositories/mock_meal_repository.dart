import '../models/meal.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockMealRepository implements MealRepository {
  @override
  Future<List<Meal>> search({
    String? query,
    List<String>? cuisines,
    List<String>? tags,
    bool? isVeg,
    int? maxCalories,
    double? radiusKm,
    String? vendorId,
    int page = 1,
    int pageSize = 20,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    List<Meal> filteredMeals = MockData.meals;

    // Apply filters
    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      filteredMeals = filteredMeals.where((meal) {
        return meal.title.toLowerCase().contains(lowercaseQuery) ||
            (meal.description?.toLowerCase().contains(lowercaseQuery) ??
                false) ||
            meal.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
      }).toList();
    }

    if (cuisines != null && cuisines.isNotEmpty) {
      filteredMeals = filteredMeals.where((meal) {
        return meal.cuisine != null && cuisines.contains(meal.cuisine);
      }).toList();
    }

    if (tags != null && tags.isNotEmpty) {
      filteredMeals = filteredMeals.where((meal) {
        return tags.any((tag) => meal.tags.contains(tag));
      }).toList();
    }

    if (isVeg != null) {
      filteredMeals = filteredMeals.where((meal) {
        return meal.isVeg == isVeg;
      }).toList();
    }

    if (maxCalories != null) {
      filteredMeals = filteredMeals.where((meal) {
        return meal.calories <= maxCalories;
      }).toList();
    }

    if (vendorId != null) {
      filteredMeals = filteredMeals.where((meal) {
        return meal.vendorId == vendorId;
      }).toList();
    }

    // Apply pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= filteredMeals.length) {
      return [];
    }

    return filteredMeals.sublist(
      startIndex,
      endIndex > filteredMeals.length ? filteredMeals.length : endIndex,
    );
  }

  @override
  Future<Meal> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final meal = MockData.meals.firstWhere((meal) => meal.id == id);
      return meal;
    } catch (e) {
      throw Exception('Meal not found');
    }
  }

  @override
  Future<List<Meal>> byVendor(String vendorId,
      {int page = 1, int pageSize = 20}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final vendorMeals =
        MockData.meals.where((meal) => meal.vendorId == vendorId).toList();

    // Apply pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= vendorMeals.length) {
      return [];
    }

    return vendorMeals.sublist(
      startIndex,
      endIndex > vendorMeals.length ? vendorMeals.length : endIndex,
    );
  }
}
