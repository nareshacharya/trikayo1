import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/meal.dart';
import '../data/models/subscription.dart';
import '../data/repositories/mock_meal_repository.dart';

class NutritionService {
  final MockMealRepository _mealRepository;

  NutritionService(this._mealRepository);

  // Find equivalent meals based on nutrition criteria
  Future<List<Meal>> findEquivalentMeals({
    required double targetCalories,
    required double macroRatioTolerance,
    required double calorieTolerance,
  }) async {
    try {
      final allMeals = await _mealRepository.getAll();

      return allMeals.where((meal) {
        // Check if meal is within calorie tolerance
        final calorieDiff = (meal.calories - targetCalories).abs();
        if (calorieDiff > calorieTolerance) return false;

        // Check macro ratio similarity
        final targetProteinRatio = 0.3; // 30% protein
        final targetCarbsRatio = 0.5; // 50% carbs
        final targetFatRatio = 0.2; // 20% fat

        final mealProteinRatio = meal.macros.protein * 4 / meal.calories;
        final mealCarbsRatio = meal.macros.carbs * 4 / meal.calories;
        final mealFatRatio = meal.macros.fat * 9 / meal.calories;

        final proteinDiff = (mealProteinRatio - targetProteinRatio).abs();
        final carbsDiff = (mealCarbsRatio - targetCarbsRatio).abs();
        final fatDiff = (mealFatRatio - targetFatRatio).abs();

        return proteinDiff <= macroRatioTolerance &&
            carbsDiff <= macroRatioTolerance &&
            fatDiff <= macroRatioTolerance;
      }).toList();
    } catch (e) {
      throw Exception('Failed to find equivalent meals: $e');
    }
  }

  // Rebalance nutrition after cheat meal
  Future<Map<String, dynamic>> rebalanceAfterCheat({
    required Meal cheatMeal,
    required double cheatFraction,
    required double dailyCalorieTarget,
    required double dailyProteinTarget,
    required double dailyCarbsTarget,
    required double dailyFatTarget,
  }) async {
    try {
      final cheatCalories = cheatMeal.calories * cheatFraction;
      final cheatProtein = cheatMeal.macros.protein * cheatFraction;
      final cheatCarbs = cheatMeal.macros.carbs * cheatFraction;
      final cheatFat = cheatMeal.macros.fat * cheatFraction;

      final remainingCalories = dailyCalorieTarget - cheatCalories;
      final remainingProtein = dailyProteinTarget - cheatProtein;
      final remainingCarbs = dailyCarbsTarget - cheatCarbs;
      final remainingFat = dailyFatTarget - cheatFat;

      // Find meals that fit the remaining nutrition targets
      final recommendedMeals = await _mealRepository.getMealsByCaloriesRange(
        remainingCalories * 0.8, // 80% of remaining calories
        remainingCalories * 1.2, // 120% of remaining calories
      );

      // Filter meals that are high in remaining macros
      final proteinMeals = recommendedMeals.where((meal) {
        return meal.macros.protein >= remainingProtein * 0.3;
      }).toList();

      final carbsMeals = recommendedMeals.where((meal) {
        return meal.macros.carbs >= remainingCarbs * 0.3;
      }).toList();

      return {
        'remainingNutrition': {
          'calories': remainingCalories,
          'protein': remainingProtein,
          'carbs': remainingCarbs,
          'fat': remainingFat,
        },
        'recommendedMeals': recommendedMeals.take(5).toList(),
        'proteinMeals': proteinMeals.take(3).toList(),
        'carbsMeals': carbsMeals.take(3).toList(),
        'message': 'Consider these lighter options to balance your day',
      };
    } catch (e) {
      throw Exception('Failed to rebalance nutrition: $e');
    }
  }

  // Calculate daily nutrition summary
  Map<String, double> calculateDailyNutrition(List<Meal> meals) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final meal in meals) {
      totalCalories += meal.calories;
      totalProtein += meal.macros.protein;
      totalCarbs += meal.macros.carbs;
      totalFat += meal.macros.fat;
    }

    return {
      'calories': totalCalories,
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
    };
  }

  // Get nutrition insights based on user tier
  Map<String, dynamic> getNutritionInsights({
    required String userTier,
    required Map<String, double> dailyNutrition,
    required Map<String, double> targets,
  }) {
    final insights = <String, dynamic>{};

    if (userTier == AppConstants.tierBasic) {
      insights['message'] =
          'Upgrade to Plus to see detailed nutrition insights';
      insights['caloriesProgress'] =
          dailyNutrition['calories']! / targets['calories']!;
    } else {
      // Plus and Pro tier insights
      insights['proteinProgress'] =
          dailyNutrition['protein']! / targets['protein']!;
      insights['carbsProgress'] = dailyNutrition['carbs']! / targets['carbs']!;
      insights['fatProgress'] = dailyNutrition['fat']! / targets['fat']!;

      if (userTier == AppConstants.tierPro) {
        insights['macroBalance'] = _calculateMacroBalance(dailyNutrition);
        insights['recommendations'] = _generateRecommendations(
          dailyNutrition,
          targets,
        );
      }
    }

    return insights;
  }

  double _calculateMacroBalance(Map<String, double> nutrition) {
    final total =
        nutrition['protein']! + nutrition['carbs']! + nutrition['fat']!;
    final proteinRatio = nutrition['protein']! / total;
    final carbsRatio = nutrition['carbs']! / total;
    final fatRatio = nutrition['fat']! / total;

    // Ideal ratios: 30% protein, 50% carbs, 20% fat
    final idealProtein = 0.3;
    final idealCarbs = 0.5;
    final idealFat = 0.2;

    final balance =
        1 -
        ((proteinRatio - idealProtein).abs() +
                (carbsRatio - idealCarbs).abs() +
                (fatRatio - idealFat).abs()) /
            2;

    return balance.clamp(0.0, 1.0);
  }

  List<String> _generateRecommendations(
    Map<String, double> nutrition,
    Map<String, double> targets,
  ) {
    final recommendations = <String>[];

    if (nutrition['protein']! < targets['protein']! * 0.8) {
      recommendations.add('Consider adding more protein-rich foods');
    }
    if (nutrition['carbs']! < targets['carbs']! * 0.8) {
      recommendations.add('You might need more carbohydrates for energy');
    }
    if (nutrition['fat']! > targets['fat']! * 1.2) {
      recommendations.add('Try to reduce fat intake in your next meal');
    }

    return recommendations;
  }
}

// Provider for NutritionService
final nutritionServiceProvider = Provider<NutritionService>((ref) {
  final mealRepository = ref.watch(mockMealRepositoryProvider);
  return NutritionService(mealRepository);
});

// Provider for MockMealRepository
final mockMealRepositoryProvider = Provider<MockMealRepository>((ref) {
  return MockMealRepository();
});
