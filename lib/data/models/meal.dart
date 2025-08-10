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
class AvailabilityWindow extends Equatable {
  final int day; // 0-6 (Sunday-Saturday)
  final String start; // HH:mm format
  final String end; // HH:mm format

  const AvailabilityWindow({
    required this.day,
    required this.start,
    required this.end,
  });

  factory AvailabilityWindow.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityWindowFromJson(json);
  Map<String, dynamic> toJson() => _$AvailabilityWindowToJson(this);

  @override
  List<Object?> get props => [day, start, end];
}

@JsonSerializable()
class EtaMinutesRange extends Equatable {
  final int min;
  final int max;

  const EtaMinutesRange({required this.min, required this.max});

  factory EtaMinutesRange.fromJson(Map<String, dynamic> json) =>
      _$EtaMinutesRangeFromJson(json);
  Map<String, dynamic> toJson() => _$EtaMinutesRangeToJson(this);

  @override
  List<Object?> get props => [min, max];
}

@JsonSerializable()
class Meal extends Equatable {
  final String id;
  final String vendorId;
  final String title;
  final String? description;
  final String? imageUrl;
  final double price;
  final String currency;
  final double calories;
  final Macros macros;
  final List<String> allergens;
  final List<String> tags;
  final String? cuisine;
  final bool? isVeg;
  final int? spiceLevel; // 0-3
  final double? portionSizeGrams;
  final List<AvailabilityWindow>? availabilityWindows;
  final EtaMinutesRange? etaMinutesRange;
  final String
      nutritionSource; // "vendor_provided" | "ai_estimated" | "lab_tested"

  const Meal({
    required this.id,
    required this.vendorId,
    required this.title,
    this.description,
    this.imageUrl,
    required this.price,
    this.currency = "INR",
    required this.calories,
    required this.macros,
    required this.allergens,
    required this.tags,
    this.cuisine,
    this.isVeg,
    this.spiceLevel,
    this.portionSizeGrams,
    this.availabilityWindows,
    this.etaMinutesRange,
    required this.nutritionSource,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);

  Meal copyWith({
    String? id,
    String? vendorId,
    String? title,
    String? description,
    String? imageUrl,
    double? price,
    String? currency,
    double? calories,
    Macros? macros,
    List<String>? allergens,
    List<String>? tags,
    String? cuisine,
    bool? isVeg,
    int? spiceLevel,
    double? portionSizeGrams,
    List<AvailabilityWindow>? availabilityWindows,
    EtaMinutesRange? etaMinutesRange,
    String? nutritionSource,
  }) {
    return Meal(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      calories: calories ?? this.calories,
      macros: macros ?? this.macros,
      allergens: allergens ?? this.allergens,
      tags: tags ?? this.tags,
      cuisine: cuisine ?? this.cuisine,
      isVeg: isVeg ?? this.isVeg,
      spiceLevel: spiceLevel ?? this.spiceLevel,
      portionSizeGrams: portionSizeGrams ?? this.portionSizeGrams,
      availabilityWindows: availabilityWindows ?? this.availabilityWindows,
      etaMinutesRange: etaMinutesRange ?? this.etaMinutesRange,
      nutritionSource: nutritionSource ?? this.nutritionSource,
    );
  }

  bool get hasGluten => allergens.contains('Gluten');
  bool get hasNuts => allergens.contains('Nuts');
  bool get hasDairy => allergens.contains('Dairy');
  bool get hasSoy => allergens.contains('Soy');
  bool get hasEgg => allergens.contains('Egg');
  bool get hasShellfish => allergens.contains('Shellfish');

  @override
  List<Object?> get props => [
        id,
        vendorId,
        title,
        description,
        imageUrl,
        price,
        currency,
        calories,
        macros,
        allergens,
        tags,
        cuisine,
        isVeg,
        spiceLevel,
        portionSizeGrams,
        availabilityWindows,
        etaMinutesRange,
        nutritionSource,
      ];
}
