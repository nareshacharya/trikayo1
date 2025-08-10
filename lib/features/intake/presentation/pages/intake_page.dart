import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';

class IntakePage extends ConsumerStatefulWidget {
  const IntakePage({super.key});

  @override
  ConsumerState<IntakePage> createState() => _IntakePageState();
}

class _IntakePageState extends ConsumerState<IntakePage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedMealType = 'Breakfast';

  final List<String> _mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  // Mock intake data - TODO: Replace with actual data from API
  final Map<String, List<Map<String, dynamic>>> _intakeData = {
    'Breakfast': [
      {
        'id': '1',
        'name': 'Oatmeal with Berries',
        'calories': 280,
        'protein': 8,
        'carbs': 45,
        'fat': 5,
        'time': '08:30',
        'status': 'consumed',
      },
    ],
    'Lunch': [
      {
        'id': '2',
        'name': 'Grilled Chicken Salad',
        'calories': 320,
        'protein': 35,
        'carbs': 12,
        'fat': 8,
        'time': '12:30',
        'status': 'consumed',
      },
    ],
    'Dinner': [
      {
        'id': '3',
        'name': 'Salmon with Asparagus',
        'calories': 380,
        'protein': 42,
        'carbs': 8,
        'fat': 18,
        'time': '19:00',
        'status': 'pending',
      },
    ],
    'Snacks': [
      {
        'id': '4',
        'name': 'Greek Yogurt',
        'calories': 120,
        'protein': 15,
        'carbs': 8,
        'fat': 2,
        'time': '15:30',
        'status': 'consumed',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final totalCalories = _calculateTotalCalories();
    final totalProtein = _calculateTotalNutrient('protein');
    final totalCarbs = _calculateTotalNutrient('carbs');
    final totalFat = _calculateTotalNutrient('fat');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Intake'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add meal page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelector(),
            const SizedBox(height: 24),
            _buildNutritionSummary(
                totalCalories, totalProtein, totalCarbs, totalFat),
            const SizedBox(height: 24),
            _buildMealTypeSelector(),
            const SizedBox(height: 24),
            _buildMealList(),
            const SizedBox(height: 24),
            _buildAddMealButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedDate =
                      _selectedDate.subtract(const Duration(days: 1));
                });
              },
              icon: const Icon(Icons.chevron_left),
            ),
            Text(
              _formatDate(_selectedDate),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedDate = _selectedDate.add(const Duration(days: 1));
                });
              },
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionSummary(
      double calories, double protein, double carbs, double fat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Summary',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildNutrientCard(
                    'Calories',
                    '${calories.toStringAsFixed(0)}',
                    'kcal',
                    AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNutrientCard(
                    'Protein',
                    '${protein.toStringAsFixed(1)}g',
                    'Goal: 120g',
                    AppTheme.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildNutrientCard(
                    'Carbs',
                    '${carbs.toStringAsFixed(1)}g',
                    'Goal: 200g',
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNutrientCard(
                    'Fat',
                    '${fat.toStringAsFixed(1)}g',
                    'Goal: 65g',
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientCard(
      String label, String value, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMealTypeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _mealTypes.map((mealType) {
          final isSelected = _selectedMealType == mealType;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(mealType),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedMealType = mealType;
                });
              },
              selectedColor: AppTheme.primaryColor.withOpacity(0.2),
              checkmarkColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMealList() {
    final meals = _intakeData[_selectedMealType] ?? [];

    if (meals.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Icon(
                Icons.restaurant_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No meals added yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add your first meal for $_selectedMealType',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedMealType,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        ...(meals.map((meal) => _buildMealCard(meal))),
      ],
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    final status = meal['status'] as String;
    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.restaurant,
                color: AppTheme.primaryColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal['name'],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${meal['calories']} kcal • ${meal['protein']}g protein',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meal['time'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMealButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Navigate to add meal page
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Meal',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    }
    return '${date.month}/${date.day}/${date.year}';
  }

  double _calculateTotalCalories() {
    double total = 0;
    for (final meals in _intakeData.values) {
      for (final meal in meals) {
        total += (meal['calories'] as int).toDouble();
      }
    }
    return total;
  }

  double _calculateTotalNutrient(String nutrient) {
    double total = 0;
    for (final meals in _intakeData.values) {
      for (final meal in meals) {
        total += (meal[nutrient] as int).toDouble();
      }
    }
    return total;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'consumed':
        return AppTheme.successColor;
      case 'pending':
        return AppTheme.warningColor;
      case 'partial':
        return AppTheme.secondaryColor;
      case 'skipped':
        return AppTheme.errorColor;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'consumed':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'partial':
        return Icons.remove_circle;
      case 'skipped':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}
