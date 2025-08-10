import 'package:flutter/material.dart';

class NutritionInfo extends StatelessWidget {
  final Map<String, dynamic> nutritionData;

  const NutritionInfo({
    super.key,
    required this.nutritionData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Facts',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              _buildNutritionRow(
                  'Calories', '${nutritionData['calories']}', 'cal'),
              const Divider(),
              _buildNutritionRow('Protein', '${nutritionData['protein']}', 'g'),
              const Divider(),
              _buildNutritionRow(
                  'Carbohydrates', '${nutritionData['carbs']}', 'g'),
              const Divider(),
              _buildNutritionRow('Fat', '${nutritionData['fat']}', 'g'),
              const Divider(),
              _buildNutritionRow('Fiber', '${nutritionData['fiber']}', 'g'),
              const Divider(),
              _buildNutritionRow('Sugar', '${nutritionData['sugar']}', 'g'),
              const Divider(),
              _buildNutritionRow('Sodium', '${nutritionData['sodium']}', 'mg'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildDailyValues(context),
      ],
    );
  }

  Widget _buildNutritionRow(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '$value $unit',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyValues(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Values',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDailyValueCard(
                context,
                'Protein',
                '${nutritionData['protein']}g',
                '${((nutritionData['protein'] / 50) * 100).round()}%',
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDailyValueCard(
                context,
                'Carbs',
                '${nutritionData['carbs']}g',
                '${((nutritionData['carbs'] / 275) * 100).round()}%',
                Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDailyValueCard(
                context,
                'Fat',
                '${nutritionData['fat']}g',
                '${((nutritionData['fat'] / 55) * 100).round()}%',
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDailyValueCard(
    BuildContext context,
    String label,
    String value,
    String percentage,
    Color color,
  ) {
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
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
