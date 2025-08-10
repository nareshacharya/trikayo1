import '../models/meal.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockNutritionService implements NutritionService {
  @override
  Future<List<Meal>> findEquivalentMeals({
    required int targetCalories,
    required Map<String, double> macroRatio,
    List<String>? tags,
    bool? isVeg,
    double radiusKm = 5,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    List<Meal> filteredMeals = MockData.meals;

    // Filter by vegetarian preference if specified
    if (isVeg != null) {
      filteredMeals =
          filteredMeals.where((meal) => meal.isVeg == isVeg).toList();
    }

    // Filter by tags if specified
    if (tags != null && tags.isNotEmpty) {
      filteredMeals = filteredMeals.where((meal) {
        return tags.any((tag) => meal.tags.contains(tag));
      }).toList();
    }

    // Filter by calorie range (within 20% of target)
    final minCalories = targetCalories * 0.8;
    final maxCalories = targetCalories * 1.2;
    filteredMeals = filteredMeals.where((meal) {
      return meal.calories >= minCalories && meal.calories <= maxCalories;
    }).toList();

    // Sort by macro similarity to target ratio
    filteredMeals.sort((a, b) {
      final aMacroSimilarity = _calculateMacroSimilarity(a.macros, macroRatio);
      final bMacroSimilarity = _calculateMacroSimilarity(b.macros, macroRatio);
      return bMacroSimilarity.compareTo(aMacroSimilarity);
    });

    // Return top 5 most similar meals
    return filteredMeals.take(5).toList();
  }

  @override
  Future<void> rebalanceAfterCheat({required int excessCalories}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // Mock implementation - in a real app this would:
    // 1. Calculate how much to reduce from next meals
    // 2. Suggest meal swaps or portion adjustments
    // 3. Update user's daily targets
    // 4. Send notifications/reminders

    print('Rebalancing after cheat day: $excessCalories excess calories');
    print('Suggesting reduced portions for next 2-3 meals');
    print('Recommending high-protein, low-carb options');
  }

  double _calculateMacroSimilarity(
      Macros mealMacros, Map<String, double> targetRatio) {
    // Calculate total calories from macros
    final totalCalories = mealMacros.totalCalories;

    // Calculate actual ratios
    final actualProteinRatio = (mealMacros.protein * 4) / totalCalories;
    final actualCarbsRatio = (mealMacros.carbs * 4) / totalCalories;
    final actualFatRatio = (mealMacros.fat * 9) / totalCalories;

    // Calculate similarity score (lower is better)
    final proteinDiff = (actualProteinRatio - targetRatio['protein']!).abs();
    final carbsDiff = (actualCarbsRatio - targetRatio['carbs']!).abs();
    final fatDiff = (actualFatRatio - targetRatio['fat']!).abs();

    return 1.0 - (proteinDiff + carbsDiff + fatDiff) / 3.0;
  }
}
