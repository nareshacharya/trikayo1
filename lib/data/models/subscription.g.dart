// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) =>
    SubscriptionPlan(
      id: json['id'] as String,
      code: json['code'] as String,
      price: (json['price'] as num).toDouble(),
      perks: (json['perks'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SubscriptionPlanToJson(SubscriptionPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'price': instance.price,
      'perks': instance.perks,
    };

MacroTargets _$MacroTargetsFromJson(Map<String, dynamic> json) => MacroTargets(
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );

Map<String, dynamic> _$MacroTargetsToJson(MacroTargets instance) =>
    <String, dynamic>{
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
    };

PlanDayTarget _$PlanDayTargetFromJson(Map<String, dynamic> json) =>
    PlanDayTarget(
      date: DateTime.parse(json['date'] as String),
      kcalTarget: (json['kcalTarget'] as num).toDouble(),
      macroTargets:
          MacroTargets.fromJson(json['macroTargets'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanDayTargetToJson(PlanDayTarget instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'kcalTarget': instance.kcalTarget,
      'macroTargets': instance.macroTargets,
    };
