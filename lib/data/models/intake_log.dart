import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'intake_log.g.dart';

@JsonSerializable()
class Nutrients extends Equatable {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  const Nutrients({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory Nutrients.fromJson(Map<String, dynamic> json) =>
      _$NutrientsFromJson(json);
  Map<String, dynamic> toJson() => _$NutrientsToJson(this);

  Nutrients copyWith({
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
  }) {
    return Nutrients(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
    );
  }

  Nutrients scaleByFraction(double fraction) {
    return Nutrients(
      calories: calories * fraction,
      protein: protein * fraction,
      carbs: carbs * fraction,
      fat: fat * fraction,
    );
  }

  @override
  List<Object?> get props => [calories, protein, carbs, fat];
}

@JsonSerializable()
class IntakeLog extends Equatable {
  final String id;
  final String orderId;
  final String mealId;
  final String status; // pending|consumed|partial|skipped
  final double fraction; // 1.0|0.75|0.5|0.25
  final Nutrients nutrients;
  final DateTime? confirmedAt;
  final DateTime createdAt;

  const IntakeLog({
    required this.id,
    required this.orderId,
    required this.mealId,
    required this.status,
    required this.fraction,
    required this.nutrients,
    this.confirmedAt,
    required this.createdAt,
  });

  factory IntakeLog.fromJson(Map<String, dynamic> json) =>
      _$IntakeLogFromJson(json);
  Map<String, dynamic> toJson() => _$IntakeLogToJson(this);

  IntakeLog copyWith({
    String? id,
    String? orderId,
    String? mealId,
    String? status,
    double? fraction,
    Nutrients? nutrients,
    DateTime? confirmedAt,
    DateTime? createdAt,
  }) {
    return IntakeLog(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      mealId: mealId ?? this.mealId,
      status: status ?? this.status,
      fraction: fraction ?? this.fraction,
      nutrients: nutrients ?? this.nutrients,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isPending => status == 'pending';
  bool get isConsumed => status == 'consumed';
  bool get isPartial => status == 'partial';
  bool get isSkipped => status == 'skipped';

  String get fractionLabel {
    switch (fraction) {
      case 1.0:
        return '100%';
      case 0.75:
        return '75%';
      case 0.5:
        return '50%';
      case 0.25:
        return '25%';
      default:
        return '${(fraction * 100).round()}%';
    }
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        mealId,
        status,
        fraction,
        nutrients,
        confirmedAt,
        createdAt,
      ];
}
