import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'subscription.g.dart';

@JsonSerializable()
class SubscriptionPlan extends Equatable {
  final String id;
  final String code;
  final double price;
  final List<String> perks;

  const SubscriptionPlan({
    required this.id,
    required this.code,
    required this.price,
    required this.perks,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionPlanToJson(this);

  SubscriptionPlan copyWith({
    String? id,
    String? code,
    double? price,
    List<String>? perks,
  }) {
    return SubscriptionPlan(
      id: id ?? this.id,
      code: code ?? this.code,
      price: price ?? this.price,
      perks: perks ?? this.perks,
    );
  }

  bool get isBasic => code == 'Basic';
  bool get isPlus => code == 'Plus';
  bool get isPro => code == 'Pro';

  @override
  List<Object?> get props => [id, code, price, perks];
}

@JsonSerializable()
class MacroTargets extends Equatable {
  final double protein;
  final double carbs;
  final double fat;

  const MacroTargets({
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory MacroTargets.fromJson(Map<String, dynamic> json) =>
      _$MacroTargetsFromJson(json);
  Map<String, dynamic> toJson() => _$MacroTargetsToJson(this);

  MacroTargets copyWith({double? protein, double? carbs, double? fat}) {
    return MacroTargets(
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
    );
  }

  @override
  List<Object?> get props => [protein, carbs, fat];
}

@JsonSerializable()
class PlanDayTarget extends Equatable {
  final DateTime date;
  final double kcalTarget;
  final MacroTargets macroTargets;

  const PlanDayTarget({
    required this.date,
    required this.kcalTarget,
    required this.macroTargets,
  });

  factory PlanDayTarget.fromJson(Map<String, dynamic> json) =>
      _$PlanDayTargetFromJson(json);
  Map<String, dynamic> toJson() => _$PlanDayTargetToJson(this);

  PlanDayTarget copyWith({
    DateTime? date,
    double? kcalTarget,
    MacroTargets? macroTargets,
  }) {
    return PlanDayTarget(
      date: date ?? this.date,
      kcalTarget: kcalTarget ?? this.kcalTarget,
      macroTargets: macroTargets ?? this.macroTargets,
    );
  }

  @override
  List<Object?> get props => [date, kcalTarget, macroTargets];
}
