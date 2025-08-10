import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'meal.g.dart';

@JsonSerializable()
class Macros extends Equatable {
  final double protein;
  final double carbs;
  final double fat;

  const Macros({required this.protein, required this.carbs, required this.fat});

  factory Macros.fromJson(Map<String, dynamic> json) => _$MacrosFromJson(json);
  Map<String, dynamic> toJson() => _$MacrosToJson(this);

  double get totalCalories => (protein * 4) + (carbs * 4) + (fat * 9);

  @override
  List<Object?> get props => [protein, carbs, fat];
}

@JsonSerializable()
class Meal extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final double calories;
  final Macros macros;
  final List<String> allergens;
  final List<String> tags;
  final String vendorId;

  const Meal({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.calories,
    required this.macros,
    required this.allergens,
    required this.tags,
    required this.vendorId,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);

  Meal copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? price,
    double? calories,
    Macros? macros,
    List<String>? allergens,
    List<String>? tags,
    String? vendorId,
  }) {
    return Meal(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      calories: calories ?? this.calories,
      macros: macros ?? this.macros,
      allergens: allergens ?? this.allergens,
      tags: tags ?? this.tags,
      vendorId: vendorId ?? this.vendorId,
    );
  }

  bool get hasGluten => allergens.contains('gluten');
  bool get hasNuts => allergens.contains('nuts');
  bool get hasDairy => allergens.contains('dairy');
  bool get hasSoy => allergens.contains('soy');
  bool get hasEgg => allergens.contains('egg');
  bool get hasShellfish => allergens.contains('shellfish');

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    price,
    calories,
    macros,
    allergens,
    tags,
    vendorId,
  ];
}
