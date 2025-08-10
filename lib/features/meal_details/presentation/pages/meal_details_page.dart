import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../data/models/meal.dart';
import '../../../../data/repositories/mock_meal_repository.dart';

class MealDetailsPage extends StatefulWidget {
  final String mealId;

  const MealDetailsPage({
    super.key,
    required this.mealId,
  });

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  int _quantity = 1;
  bool _isLoading = false;
  bool _isLoadingMeal = true;
  Meal? _meal;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMeal();
  }

  Future<void> _loadMeal() async {
    try {
      setState(() {
        _isLoadingMeal = true;
        _error = null;
      });

      final repository = MockMealRepository();
      final meal = await repository.getById(widget.mealId);

      setState(() {
        _meal = meal;
        _isLoadingMeal = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load meal: ${e.toString()}';
        _isLoadingMeal = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingMeal) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _meal == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/catalog'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error ?? 'Meal not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadMeal,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMealImage(),
                  const SizedBox(height: 24),
                  _buildMealInfo(),
                  const SizedBox(height: 24),
                  _buildNutritionInfo(),
                  const SizedBox(height: 24),
                  _buildAllergensAndTags(),
                  const SizedBox(height: 24),
                  _buildAvailabilityInfo(),
                  const SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildAddToCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        ),
        onPressed: () => context.go('/catalog'),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 20,
            ),
          ),
          onPressed: () {
            // TODO: Add to favorites
          },
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.share,
              color: Colors.white,
              size: 20,
            ),
          ),
          onPressed: () {
            // TODO: Share meal
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: _meal?.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(_meal!.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _meal?.imageUrl == null
                  ? const Icon(
                      Icons.restaurant,
                      size: 80,
                      color: Colors.grey,
                    )
                  : null,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            image: _meal?.imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(_meal!.imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: _meal?.imageUrl == null
              ? const Icon(
                  Icons.restaurant,
                  size: 60,
                  color: Colors.grey,
                )
              : null,
        ),
      ),
    ).animate().fadeIn(delay: AppConstants.shortAnimation);
  }

  Widget _buildMealInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _meal!.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            Text(
              '₹${_meal!.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        )
            .animate()
            .slideX(begin: -0.3, end: 0, delay: AppConstants.shortAnimation),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 20,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              '${_meal!.etaMinutesRange?.min ?? 20}-${_meal!.etaMinutesRange?.max ?? 40} min',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
            if (_meal!.portionSizeGrams != null) ...[
              const SizedBox(width: 16),
              Icon(
                Icons.scale,
                size: 20,
                color: AppTheme.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '${_meal!.portionSizeGrams!.toInt()}g',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ],
        )
            .animate()
            .slideX(begin: -0.3, end: 0, delay: AppConstants.mediumAnimation),
        const SizedBox(height: 16),
        Text(
          _meal!.description ?? 'No description available',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: AppConstants.longAnimation),
      ],
    );
  }

  Widget _buildNutritionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(delay: AppConstants.shortAnimation),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildNutritionCard(
              'Calories',
              '${_meal!.calories.toInt()}',
              Icons.local_fire_department,
              AppTheme.secondaryColor,
            ),
            const SizedBox(width: 16),
            _buildNutritionCard(
              'Protein',
              '${_meal!.macros.protein.toInt()}g',
              Icons.fitness_center,
              Colors.blue,
            ),
            const SizedBox(width: 16),
            _buildNutritionCard(
              'Carbs',
              '${_meal!.macros.carbs.toInt()}g',
              Icons.grain,
              Colors.orange,
            ),
            const SizedBox(width: 16),
            _buildNutritionCard(
              'Fat',
              '${_meal!.macros.fat.toInt()}g',
              Icons.water_drop,
              Colors.red,
            ),
          ],
        )
            .animate()
            .slideY(begin: 0.3, end: 0, delay: AppConstants.mediumAnimation),
      ],
    );
  }

  Widget _buildNutritionCard(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllergensAndTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Allergens & Tags',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(delay: AppConstants.shortAnimation),
        const SizedBox(height: 16),

        // Allergens
        if (_meal!.allergens.isNotEmpty) ...[
          Text(
            'Allergens:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _meal!.allergens
                .map((allergen) => _buildAllergenTag(allergen))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],

        // Tags
        if (_meal!.tags.isNotEmpty) ...[
          Text(
            'Tags:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _meal!.tags.map((tag) => _buildTag(tag)).toList(),
          ),
          const SizedBox(height: 16),
        ],

        // Nutrition Source
        Row(
          children: [
            Icon(
              Icons.science,
              size: 20,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Nutrition Source: ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              _meal!.nutritionSource.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ]
          .animate()
          .slideY(begin: 0.3, end: 0, delay: AppConstants.mediumAnimation),
    );
  }

  Widget _buildAllergenTag(String allergen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Text(
        allergen,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.red[700],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildAvailabilityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meal Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(delay: AppConstants.shortAnimation),
        const SizedBox(height: 16),

        // Cuisine
        if (_meal!.cuisine != null) ...[
          Row(
            children: [
              Icon(
                Icons.restaurant,
                size: 24,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Cuisine: ${_meal!.cuisine}',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        // Spice Level
        if (_meal!.spiceLevel != null) ...[
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                size: 24,
                color: Colors.orange,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Spice Level: ${_meal!.spiceLevel == 0 ? "Mild" : _meal!.spiceLevel == 1 ? "Medium" : _meal!.spiceLevel == 2 ? "Hot" : "Very Hot"}',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        // Vegetarian Status
        Row(
          children: [
            Icon(
              _meal!.isVeg == true ? Icons.eco : Icons.restaurant,
              size: 24,
              color: _meal!.isVeg == true ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _meal!.isVeg == true ? 'Vegetarian' : 'Non-Vegetarian',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Availability Status
        Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 24,
              color: AppTheme.successColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'In stock',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ]
          .animate()
          .slideY(begin: 0.3, end: 0, delay: AppConstants.mediumAnimation),
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _quantity > 1
                      ? () {
                          setState(() {
                            _quantity--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '$_quantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _addToCart,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Add to Cart - ₹${((_meal!.price) * _quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual add to cart logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Added $_quantity ${_quantity == 1 ? 'item' : 'items'} to cart'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      // Navigate to checkout
      context.go('/checkout');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add to cart: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
