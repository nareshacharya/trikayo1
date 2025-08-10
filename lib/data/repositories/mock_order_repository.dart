import 'dart:async';
import '../models/order.dart';
import '../datasources/mock_data.dart';
import 'base_repository.dart';

class MockOrderRepository implements OrderRepository {
  final Map<String, StreamController<Order>> _orderControllers = {};

  @override
  Future<Order> place(Order draft) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real implementation, this would save to a database and return with generated ID
    final order = draft.copyWith(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      status: 'placed',
      createdAt: DateTime.now(),
    );

    // Create a stream controller for tracking this order
    final controller = StreamController<Order>.broadcast();
    _orderControllers[order.id] = controller;

    // Emit initial status
    controller.add(order);

    return order;
  }

  @override
  Stream<Order> track(String orderId) {
    final controller = _orderControllers[orderId];
    if (controller == null) {
      // Return a stream that emits an error if order not found
      return Stream.error('Order not found');
    }

    // Simulate order status updates
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (controller.isClosed) {
        timer.cancel();
        return;
      }

      // Mock status progression
      _simulateOrderProgress(orderId, controller);
    });

    return controller.stream;
  }

  @override
  Future<List<Order>> history(String userId,
      {int page = 1, int pageSize = 20}) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Mock order history - in a real app this would come from a database
    final mockOrders = _generateMockOrders(userId);

    // Apply pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= mockOrders.length) {
      return [];
    }

    return mockOrders.sublist(
      startIndex,
      endIndex > mockOrders.length ? mockOrders.length : endIndex,
    );
  }

  void _simulateOrderProgress(
      String orderId, StreamController<Order> controller) {
    // Mock order status progression
    final currentOrder = MockData.mockOrders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => MockData.mockOrders.first,
    );

    final statuses = [
      'placed',
      'accepted',
      'preparing',
      'out_for_delivery',
      'delivered'
    ];
    final currentIndex = statuses.indexOf(currentOrder.status);

    if (currentIndex < statuses.length - 1) {
      final nextStatus = statuses[currentIndex + 1];
      final updatedOrder = currentOrder.copyWith(
        status: nextStatus,
        deliveredAt: nextStatus == 'delivered' ? DateTime.now() : null,
      );

      controller.add(updatedOrder);

      // Close controller when order is delivered
      if (nextStatus == 'delivered') {
        Timer(const Duration(seconds: 2), () {
          controller.close();
          _orderControllers.remove(orderId);
        });
      }
    }
  }

  List<Order> _generateMockOrders(String userId) {
    // Generate mock order history for the user
    return [
      Order(
        id: 'order_1',
        userId: userId,
        items: [
          OrderItem(
            mealId: 'm1',
            vendorId: 'v1',
            qty: 2,
            unitPrice: 18.99,
            lineTotal: 37.98,
          ),
        ],
        subtotal: 37.98,
        deliveryFee: 2.99,
        total: 40.97,
        address: '123 Main St, Downtown',
        status: 'delivered',
        deliveredAt: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
      Order(
        id: 'order_2',
        userId: userId,
        items: [
          OrderItem(
            mealId: 'm3',
            vendorId: 'v2',
            qty: 1,
            unitPrice: 16.99,
            lineTotal: 16.99,
          ),
        ],
        subtotal: 16.99,
        deliveryFee: 2.99,
        total: 19.98,
        address: '123 Main St, Downtown',
        status: 'delivered',
        deliveredAt: DateTime.now().subtract(const Duration(days: 3)),
        createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      ),
    ];
  }

  void dispose() {
    for (final controller in _orderControllers.values) {
      controller.close();
    }
    _orderControllers.clear();
  }
}
