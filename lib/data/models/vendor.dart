import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'vendor.g.dart';

@JsonSerializable()
class Vendor extends Equatable {
  final String id;
  final String name;
  final String? logoUrl;
  final double? rating;
  final String area;
  final List<String> cuisines;
  final List<String> serviceAreas;
  final bool isOpen;
  final int? avgPrepMinutes;
  final double? deliveryFee;
  final double? minOrderValue;

  const Vendor({
    required this.id,
    required this.name,
    this.logoUrl,
    this.rating,
    required this.area,
    required this.cuisines,
    required this.serviceAreas,
    required this.isOpen,
    this.avgPrepMinutes,
    this.deliveryFee,
    this.minOrderValue,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);
  Map<String, dynamic> toJson() => _$VendorToJson(this);

  Vendor copyWith({
    String? id,
    String? name,
    String? logoUrl,
    double? rating,
    String? area,
    List<String>? cuisines,
    List<String>? serviceAreas,
    bool? isOpen,
    int? avgPrepMinutes,
    double? deliveryFee,
    double? minOrderValue,
  }) {
    return Vendor(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      rating: rating ?? this.rating,
      area: area ?? this.area,
      cuisines: cuisines ?? this.cuisines,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      isOpen: isOpen ?? this.isOpen,
      avgPrepMinutes: avgPrepMinutes ?? this.avgPrepMinutes,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minOrderValue: minOrderValue ?? this.minOrderValue,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        logoUrl,
        rating,
        area,
        cuisines,
        serviceAreas,
        isOpen,
        avgPrepMinutes,
        deliveryFee,
        minOrderValue
      ];
}
