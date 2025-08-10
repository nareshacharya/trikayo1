import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/meal.dart';
import '../../../../data/repositories/mock_meal_repository.dart';
import '../widgets/featured_meal_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/stats_summary.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Meal> _featuredMeals = [];
  bool _isLoadingFeatured = true;

  @override
  void initState() {
    super.initState();
    _loadFeaturedMeals();
  }

  Future<void> _loadFeaturedMeals() async {
    try {
      setState(() {
        _isLoadingFeatured = true;
      });

      final repository = MockMealRepository();
      final meals = await repository.search(
        page: 1,
        pageSize: 5,
      );

      setState(() {
        _featuredMeals = meals;
        _isLoadingFeatured = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingFeatured = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(),
                  const SizedBox(height: 24),
                  const QuickActions(),
                  const SizedBox(height: 24),
                  const StatsSummary(),
                  const SizedBox(height: 24),
                  _buildFeaturedSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Welcome back!',
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
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Navigate to notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.go('/settings'),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How are you feeling today?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildMoodButton('😊', 'Great'),
            const SizedBox(width: 12),
            _buildMoodButton('😐', 'Okay'),
            const SizedBox(width: 12),
            _buildMoodButton('😔', 'Not great'),
          ],
        ),
      ],
    );
  }

  Widget _buildMoodButton(String emoji, String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // TODO: Handle mood selection
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[700],
          elevation: 1,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Meals',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_isLoadingFeatured)
          const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_featuredMeals.isEmpty)
          const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'No featured meals available',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredMeals.length,
              itemBuilder: (context, index) {
                final meal = _featuredMeals[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: FeaturedMealCard(
                    mealId: meal.id,
                    name: meal.title,
                    description: meal.description ?? 'No description available',
                    imageUrl: meal.imageUrl ?? '',
                    calories: meal.calories.toInt(),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
