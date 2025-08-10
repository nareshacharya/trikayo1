// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Macros _$MacrosFromJson(Map<String, dynamic> json) => Macros(
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );

Map<String, dynamic> _$MacrosToJson(Macros instance) => <String, dynamic>{
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
    };

AvailabilityWindow _$AvailabilityWindowFromJson(Map<String, dynamic> json) =>
    AvailabilityWindow(
      day: (json['day'] as num).toInt(),
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$AvailabilityWindowToJson(AvailabilityWindow instance) =>
    <String, dynamic>{
      'day': instance.day,
      'start': instance.start,
      'end': instance.end,
    };

EtaMinutesRange _$EtaMinutesRangeFromJson(Map<String, dynamic> json) =>
    EtaMinutesRange(
      min: (json['min'] as num).toInt(),
      max: (json['max'] as num).toInt(),
    );

Map<String, dynamic> _$EtaMinutesRangeToJson(EtaMinutesRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      id: json['id'] as String,
      vendorId: json['vendorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? "INR",
      calories: (json['calories'] as num).toDouble(),
      macros: Macros.fromJson(json['macros'] as Map<String, dynamic>),
      allergens:
          (json['allergens'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      cuisine: json['cuisine'] as String?,
      isVeg: json['isVeg'] as bool?,
      spiceLevel: (json['spiceLevel'] as num?)?.toInt(),
      portionSizeGrams: (json['portionSizeGrams'] as num?)?.toDouble(),
      availabilityWindows: (json['availabilityWindows'] as List<dynamic>?)
          ?.map((e) => AvailabilityWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      etaMinutesRange: json['etaMinutesRange'] == null
          ? null
          : EtaMinutesRange.fromJson(
              json['etaMinutesRange'] as Map<String, dynamic>),
      nutritionSource: json['nutritionSource'] as String,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'vendorId': instance.vendorId,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'currency': instance.currency,
      'calories': instance.calories,
      'macros': instance.macros,
      'allergens': instance.allergens,
      'tags': instance.tags,
      'cuisine': instance.cuisine,
      'isVeg': instance.isVeg,
      'spiceLevel': instance.spiceLevel,
      'portionSizeGrams': instance.portionSizeGrams,
      'availabilityWindows': instance.availabilityWindows,
      'etaMinutesRange': instance.etaMinutesRange,
      'nutritionSource': instance.nutritionSource,
    };
