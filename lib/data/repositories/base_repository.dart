import 'package:dio/dio.dart';

import '../models/user.dart';
import '../models/meal.dart';
import '../models/order.dart';
import '../models/intake_log.dart';
import '../models/subscription.dart';
import '../models/vendor.dart';

// Meal Repository Interface
abstract class MealRepository {
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
  });

  Future<Meal> getById(String id);
  Future<List<Meal>> byVendor(String vendorId,
      {int page = 1, int pageSize = 20});
}

// Vendor Repository Interface
abstract class VendorRepository {
  Future<List<Vendor>> nearby({double? lat, double? lng, double radiusKm = 5});
  Future<Vendor> getById(String id);
}

// Order Repository Interface
abstract class OrderRepository {
  Future<Order> place(Order draft);
  Stream<Order> track(
      String orderId); // emits status updates (preparing→delivered)
  Future<List<Order>> history(String userId, {int page = 1, int pageSize = 20});
}

// Intake Repository Interface
abstract class IntakeRepository {
  Future<void> createPendingFromDelivery(Order order);
  Future<void> confirm(String intakeLogId,
      {double fraction = 1.0, String status = "consumed"});
  Stream<List<IntakeLog>> today(String userId);
}

// User Repository Interface
abstract class UserRepository {
  Future<User> me();
  Future<void> updateTier(String code); // Basic | Plus | Pro
}

// Subscription Repository Interface
abstract class SubscriptionRepository {
  Future<List<SubscriptionPlan>> getAvailablePlans();
  Future<SubscriptionPlan?> getCurrentPlan(String userId);
  Future<bool> subscribeUser(String userId, String planId);
  Future<bool> cancelSubscription(String userId);
}

// Nutrition Service Interface (Optional)
abstract class NutritionService {
  Future<List<Meal>> findEquivalentMeals({
    required int targetCalories,
    required Map<String, double> macroRatio,
    List<String>? tags,
    bool? isVeg,
    double radiusKm = 5,
  });

  Future<void> rebalanceAfterCheat({required int excessCalories});
}
