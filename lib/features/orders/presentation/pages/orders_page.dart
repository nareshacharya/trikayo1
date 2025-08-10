import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/order.dart';
import '../../../../data/models/meal.dart';
import '../widgets/order_card.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActiveOrders(),
                _buildPastOrders(),
                _buildCancelledOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: TabBar(
        controller: _tabController,
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Theme.of(context).colorScheme.primary,
        tabs: const [
          Tab(text: 'Active'),
          Tab(text: 'Past'),
          Tab(text: 'Cancelled'),
        ],
      ),
    );
  }

  Widget _buildActiveOrders() {
    final activeOrders = _getActiveOrders();

    if (activeOrders.isEmpty) {
      return _buildEmptyState(
        context,
        'No Active Orders',
        'You don\'t have any active orders at the moment.',
        Icons.receipt_long,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OrderCard(
            order: activeOrders[index],
            onTap: () {
              // TODO: Navigate to order details
            },
          ),
        );
      },
    );
  }

  Widget _buildPastOrders() {
    final pastOrders = _getPastOrders();

    if (pastOrders.isEmpty) {
      return _buildEmptyState(
        context,
        'No Past Orders',
        'You haven\'t placed any orders yet.',
        Icons.history,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: pastOrders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OrderCard(
            order: pastOrders[index],
            onTap: () {
              // TODO: Navigate to order details
            },
          ),
        );
      },
    );
  }

  Widget _buildCancelledOrders() {
    final cancelledOrders = _getCancelledOrders();

    if (cancelledOrders.isEmpty) {
      return _buildEmptyState(
        context,
        'No Cancelled Orders',
        'You haven\'t cancelled any orders.',
        Icons.cancel_outlined,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: cancelledOrders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OrderCard(
            order: cancelledOrders[index],
            onTap: () {
              // TODO: Navigate to order details
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    String title,
    String message,
    IconData icon,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/catalog'),
            child: const Text('Browse Meals'),
          ),
        ],
      ),
    );
  }

  List<Order> _getActiveOrders() {
    // Mock data - in real app, this would come from a repository
    return [
      Order(
        id: 'ORD001',
        items: [
          OrderItem(mealId: '1', quantity: 1),
          OrderItem(mealId: '2', quantity: 1),
        ],
        total: 29.97,
        address: '123 Main St, City',
        slot: '12:30 PM - 1:30 PM',
        status: 'preparing',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Order(
        id: 'ORD002',
        items: [
          OrderItem(mealId: '3', quantity: 1),
        ],
        total: 15.99,
        address: '456 Oak Ave, City',
        slot: '2:15 PM - 3:15 PM',
        status: 'placed',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }

  List<Order> _getPastOrders() {
    // Mock data - in real app, this would come from a repository
    return [
      Order(
        id: 'ORD003',
        items: [
          OrderItem(mealId: '4', quantity: 2),
          OrderItem(mealId: '5', quantity: 1),
        ],
        total: 25.98,
        address: '789 Pine St, City',
        slot: '6:00 PM - 7:00 PM',
        status: 'delivered',
        deliveredAt:
            DateTime.now().subtract(const Duration(days: 1, hours: 17)),
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 18)),
      ),
      Order(
        id: 'ORD004',
        items: [
          OrderItem(mealId: '6', quantity: 1),
          OrderItem(mealId: '7', quantity: 1),
        ],
        total: 18.98,
        address: '321 Elm St, City',
        slot: '1:00 PM - 2:00 PM',
        status: 'delivered',
        deliveredAt:
            DateTime.now().subtract(const Duration(days: 2, hours: 13)),
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 23)),
      ),
    ];
  }

  List<Order> _getCancelledOrders() {
    // Mock data - in real app, this would come from a repository
    return [
      Order(
        id: 'ORD005',
        items: [
          OrderItem(mealId: '8', quantity: 1),
          OrderItem(mealId: '9', quantity: 1),
        ],
        total: 22.97,
        address: '654 Maple Dr, City',
        slot: '7:30 PM - 8:30 PM',
        status: 'cancelled',
        createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 16)),
      ),
    ];
  }
}
