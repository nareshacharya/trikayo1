// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutrients _$NutrientsFromJson(Map<String, dynamic> json) => Nutrients(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );

Map<String, dynamic> _$NutrientsToJson(Nutrients instance) => <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
    };

IntakeLog _$IntakeLogFromJson(Map<String, dynamic> json) => IntakeLog(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      mealId: json['mealId'] as String,
      status: json['status'] as String,
      fraction: (json['fraction'] as num).toDouble(),
      nutrients: Nutrients.fromJson(json['nutrients'] as Map<String, dynamic>),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$IntakeLogToJson(IntakeLog instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'mealId': instance.mealId,
      'status': instance.status,
      'fraction': instance.fraction,
      'nutrients': instance.nutrients,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
