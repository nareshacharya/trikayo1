import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';
import '../widgets/meal_card.dart';
import '../widgets/category_filter.dart';
import '../widgets/search_bar.dart' as custom;

class CatalogPage extends ConsumerStatefulWidget {
  const CatalogPage({super.key});

  @override
  ConsumerState<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends ConsumerState<CatalogPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Desserts',
    'Beverages',
  ];

  // Mock data - TODO: Replace with actual data from API
  final List<Map<String, dynamic>> _meals = [
    {
      'id': '1',
      'name': 'Grilled Chicken Salad',
      'description': 'Fresh mixed greens with grilled chicken breast',
      'price': 12.99,
      'calories': 320,
      'category': 'Lunch',
      'rating': 4.5,
      'prepTime': '15 min',
    },
    {
      'id': '2',
      'name': 'Quinoa Bowl',
      'description': 'Nutritious quinoa with roasted vegetables',
      'price': 14.99,
      'calories': 450,
      'category': 'Lunch',
      'rating': 4.3,
      'prepTime': '20 min',
    },
    {
      'id': '3',
      'name': 'Oatmeal with Berries',
      'description': 'Steel-cut oats topped with fresh berries',
      'price': 8.99,
      'calories': 280,
      'category': 'Breakfast',
      'rating': 4.7,
      'prepTime': '10 min',
    },
    {
      'id': '4',
      'name': 'Salmon with Asparagus',
      'description': 'Grilled salmon fillet with roasted asparagus',
      'price': 18.99,
      'calories': 380,
      'category': 'Dinner',
      'rating': 4.6,
      'prepTime': '25 min',
    },
    {
      'id': '5',
      'name': 'Greek Yogurt Parfait',
      'description': 'Creamy Greek yogurt with granola and honey',
      'price': 6.99,
      'calories': 220,
      'category': 'Breakfast',
      'rating': 4.4,
      'prepTime': '5 min',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = _getFilteredMeals();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  custom.SearchBar(
                    controller: _searchController,
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CategoryFilter(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildResultsHeader(filteredMeals.length),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final meal = filteredMeals[index];
                  return MealCard(
                    meal: meal,
                    onTap: () => context.go('/meal/${meal['id']}'),
                  ).animate().fadeIn(
                        delay: Duration(milliseconds: index * 100),
                      );
                },
                childCount: filteredMeals.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Meal Catalog',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.primary.withOpacity(0.05),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // TODO: Show advanced filters
          },
        ),
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () {
            // TODO: Show sorting options
          },
        ),
      ],
    );
  }

  Widget _buildResultsHeader(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$count meals found',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            // TODO: Navigate to meal planner
          },
          icon: const Icon(Icons.calendar_today, size: 18),
          label: const Text('Plan Meals'),
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredMeals() {
    List<Map<String, dynamic>> filtered = _meals;

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((meal) => meal['category'] == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((meal) {
        final name = meal['name'].toString().toLowerCase();
        final description = meal['description'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || description.contains(query);
      }).toList();
    }

    return filtered;
  }
}
