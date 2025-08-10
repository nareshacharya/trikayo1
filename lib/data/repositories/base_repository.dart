import 'package:dio/dio.dart';

import '../models/user.dart';
import '../models/meal.dart';
import '../models/order.dart';
import '../models/intake_log.dart';
import '../models/subscription.dart';

abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<T> create(T item);
  Future<T> update(String id, T item);
  Future<bool> delete(String id);
}

abstract class MealRepository extends BaseRepository<Meal> {
  Future<List<Meal>> searchMeals(String query);
  Future<List<Meal>> getMealsByVendor(String vendorId);
  Future<List<Meal>> getMealsByTags(List<String> tags);
  Future<List<Meal>> getMealsByCaloriesRange(double min, double max);
  Future<List<Meal>> getRecommendedMeals(String userId);
}

abstract class OrderRepository extends BaseRepository<Order> {
  Future<List<Order>> getOrdersByUser(String userId);
  Future<List<Order>> getOrdersByStatus(String status);
  Future<Order> updateOrderStatus(String orderId, String status);
  Future<Order> addDeliveryTime(String orderId, DateTime deliveredAt);
}

abstract class IntakeRepository extends BaseRepository<IntakeLog> {
  Future<List<IntakeLog>> getIntakeLogsByUser(String userId);
  Future<List<IntakeLog>> getIntakeLogsByDate(DateTime date);
  Future<IntakeLog> confirmIntake(
    String intakeId,
    String status,
    double fraction,
  );
  Future<Map<String, dynamic>> getDailyNutritionSummary(
    String userId,
    DateTime date,
  );
}

abstract class UserRepository extends BaseRepository<User> {
  Future<User?> getUserByEmail(String email);
  Future<User?> getUserByPhone(String phone);
  Future<User> updateUserTier(String userId, String tier);
  Future<User> updateUserProfile(String userId, Map<String, dynamic> updates);
}

abstract class SubscriptionRepository extends BaseRepository<SubscriptionPlan> {
  Future<List<SubscriptionPlan>> getAvailablePlans();
  Future<SubscriptionPlan?> getCurrentPlan(String userId);
  Future<bool> subscribeUser(String userId, String planId);
  Future<bool> cancelSubscription(String userId);
}
