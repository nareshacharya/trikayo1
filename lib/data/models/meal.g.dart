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

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
      macros: Macros.fromJson(json['macros'] as Map<String, dynamic>),
      allergens:
          (json['allergens'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      vendorId: json['vendorId'] as String,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'calories': instance.calories,
      'macros': instance.macros,
      'allergens': instance.allergens,
      'tags': instance.tags,
      'vendorId': instance.vendorId,
    };
