import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';

class MealCard extends StatelessWidget {
  final Map<String, dynamic> meal;
  final VoidCallback onTap;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(context),
                  const SizedBox(height: 8),
                  _buildDescriptionSection(),
                  const SizedBox(height: 8),
                  _buildFooterSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppConstants.defaultRadius),
          ),
          child: Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(
              Icons.restaurant,
              size: 40,
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  size: 14,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  (meal['rating'] ?? 0.0).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        // TODO: Add dietary badges when dietary info is available
        // if (isVegetarian || isVegan || isGlutenFree)
        //   Positioned(
        //     top: 8,
        //     left: 8,
        //     child: _buildDietaryBadge(),
        //   ),
      ],
    );
  }

  // Widget _buildDietaryBadge() {
  //   String label = '';
  //   Color color = Colors.green;

  //   if (isVegan) {
  //     label = 'Vegan';
  //     color = Colors.green;
  //   } else if (isVegetarian) {
  //     label = 'Veg';
  //     color = Colors.lightGreen;
  //   } else if (isGlutenFree) {
  //     label = 'GF';
  //     color = Colors.orange;
  //   }

  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  //     decoration: BoxDecoration(
  //       color: color,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Text(
  //         label,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 10,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     );
  //   }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            meal['name'] ?? 'Unknown Meal',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '\$${(meal['price'] ?? 0.0).toStringAsFixed(2)}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Text(
      meal['description'] ?? 'No description available',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_fire_department,
              size: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 4),
            Text(
              '${meal['calories'] ?? 0} cal',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            meal['category'] ?? 'Unknown',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
