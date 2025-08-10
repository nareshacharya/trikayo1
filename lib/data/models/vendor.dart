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

  const Vendor({
    required this.id,
    required this.name,
    this.logoUrl,
    this.rating,
    required this.area,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);
  Map<String, dynamic> toJson() => _$VendorToJson(this);

  Vendor copyWith({
    String? id,
    String? name,
    String? logoUrl,
    double? rating,
    String? area,
  }) {
    return Vendor(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      rating: rating ?? this.rating,
      area: area ?? this.area,
    );
  }

  @override
  List<Object?> get props => [id, name, logoUrl, rating, area];
}
