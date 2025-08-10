// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      area: json['area'] as String,
      cuisines:
          (json['cuisines'] as List<dynamic>).map((e) => e as String).toList(),
      serviceAreas: (json['serviceAreas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isOpen: json['isOpen'] as bool,
      avgPrepMinutes: (json['avgPrepMinutes'] as num?)?.toInt(),
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble(),
      minOrderValue: (json['minOrderValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'rating': instance.rating,
      'area': instance.area,
      'cuisines': instance.cuisines,
      'serviceAreas': instance.serviceAreas,
      'isOpen': instance.isOpen,
      'avgPrepMinutes': instance.avgPrepMinutes,
      'deliveryFee': instance.deliveryFee,
      'minOrderValue': instance.minOrderValue,
    };
