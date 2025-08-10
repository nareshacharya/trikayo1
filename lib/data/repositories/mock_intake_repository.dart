import 'dart:async';
import '../models/intake_log.dart';
import '../models/order.dart';
import '../models/meal.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockIntakeRepository implements IntakeRepository {
  final Map<String, List<IntakeLog>> _intakeLogs = {};
  final Map<String, StreamController<List<IntakeLog>>> _todayControllers = {};

  @override
  Future<void> createPendingFromDelivery(Order order) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final userId = order.userId;
    if (!_intakeLogs.containsKey(userId)) {
      _intakeLogs[userId] = [];
    }

    // Create pending intake logs for each meal in the order
    for (final item in order.items) {
      final meal = MockData.meals.firstWhere((m) => m.id == item.mealId);

      final intakeLog = IntakeLog(
        id: 'intake_${DateTime.now().millisecondsSinceEpoch}_${item.mealId}',
        orderId: order.id,
        mealId: item.mealId,
        status: 'pending',
        fraction: 1.0,
        nutrients: Nutrients(
          calories: meal.calories * item.qty,
          protein: meal.macros.protein * item.qty,
          carbs: meal.macros.carbs * item.qty,
          fat: meal.macros.fat * item.qty,
        ),
        createdAt: DateTime.now(),
      );

      _intakeLogs[userId]!.add(intakeLog);
    }

    // Notify today stream subscribers
    _notifyTodaySubscribers(userId);
  }

  @override
  Future<void> confirm(String intakeLogId,
      {double fraction = 1.0, String status = "consumed"}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Find and update the intake log
    for (final userLogs in _intakeLogs.values) {
      final logIndex = userLogs.indexWhere((log) => log.id == intakeLogId);
      if (logIndex != -1) {
        final log = userLogs[logIndex];
        final updatedLog = log.copyWith(
          status: status,
          fraction: fraction,
          confirmedAt: DateTime.now(),
        );

        userLogs[logIndex] = updatedLog;

        // Notify today stream subscribers
        _notifyTodaySubscribers(log.orderId);
        break;
      }
    }
  }

  @override
  Stream<List<IntakeLog>> today(String userId) {
    if (!_todayControllers.containsKey(userId)) {
      _todayControllers[userId] = StreamController<List<IntakeLog>>.broadcast();

      // Emit initial value
      _emitTodayLogs(userId);
    }

    return _todayControllers[userId]!.stream;
  }

  void _emitTodayLogs(String userId) {
    final controller = _todayControllers[userId];
    if (controller != null && !controller.isClosed) {
      final today = DateTime.now();
      final todayLogs = _intakeLogs[userId]?.where((log) {
            return log.createdAt.year == today.year &&
                log.createdAt.month == today.month &&
                log.createdAt.day == today.day;
          }).toList() ??
          [];

      controller.add(todayLogs);
    }
  }

  void _notifyTodaySubscribers(String userId) {
    _emitTodayLogs(userId);
  }

  void dispose() {
    for (final controller in _todayControllers.values) {
      controller.close();
    }
    _todayControllers.clear();
  }
}
