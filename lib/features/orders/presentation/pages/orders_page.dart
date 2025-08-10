import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
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

  List<Map<String, dynamic>> _getActiveOrders() {
    // Mock data - in real app, this would come from a repository
    return [
      {
        'id': 'ORD001',
        'orderNumber': '#ORD001',
        'date': '2024-01-15',
        'time': '12:30 PM',
        'status': 'preparing',
        'total': 29.97,
        'items': [
          {'name': 'Grilled Chicken Bowl', 'quantity': 1, 'price': 14.99},
          {'name': 'Veggie Power Bowl', 'quantity': 1, 'price': 11.99},
        ],
        'estimatedDelivery': '1:30 PM',
        'restaurant': 'Healthy Eats Kitchen',
      },
      {
        'id': 'ORD002',
        'orderNumber': '#ORD002',
        'date': '2024-01-15',
        'time': '2:15 PM',
        'status': 'placed',
        'total': 15.99,
        'items': [
          {'name': 'Salmon Quinoa Bowl', 'quantity': 1, 'price': 15.99},
        ],
        'estimatedDelivery': '3:15 PM',
        'restaurant': 'Fresh & Co',
      },
    ];
  }

  List<Map<String, dynamic>> _getPastOrders() {
    // Mock data - in real app, this would come from a repository
    return [
      {
        'id': 'ORD003',
        'orderNumber': '#ORD003',
        'date': '2024-01-14',
        'time': '6:00 PM',
        'status': 'delivered',
        'total': 25.98,
        'items': [
          {'name': 'Breakfast Burrito', 'quantity': 2, 'price': 9.99},
          {'name': 'Greek Yogurt Parfait', 'quantity': 1, 'price': 6.00},
        ],
        'deliveredAt': '7:15 PM',
        'restaurant': 'Morning Delights',
      },
      {
        'id': 'ORD004',
        'orderNumber': '#ORD004',
        'date': '2024-01-13',
        'time': '1:00 PM',
        'status': 'delivered',
        'total': 18.98,
        'items': [
          {'name': 'Mediterranean Wrap', 'quantity': 1, 'price': 10.99},
          {'name': 'Side Salad', 'quantity': 1, 'price': 7.99},
        ],
        'deliveredAt': '1:45 PM',
        'restaurant': 'Fresh & Co',
      },
    ];
  }

  List<Map<String, dynamic>> _getCancelledOrders() {
    // Mock data - in real app, this would come from a repository
    return [
      {
        'id': 'ORD005',
        'orderNumber': '#ORD005',
        'date': '2024-01-12',
        'time': '7:30 PM',
        'status': 'cancelled',
        'total': 22.97,
        'items': [
          {'name': 'Pasta Primavera', 'quantity': 1, 'price': 16.99},
          {'name': 'Garlic Bread', 'quantity': 1, 'price': 5.98},
        ],
        'cancelledAt': '7:45 PM',
        'restaurant': 'Italian Delight',
        'cancellationReason': 'Restaurant was too busy',
      },
    ];
  }
}
