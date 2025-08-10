import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderItem extends Equatable {
  final String mealId;
  final String vendorId;
  final int qty;
  final double unitPrice;
  final double lineTotal;

  const OrderItem({
    required this.mealId,
    required this.vendorId,
    required this.qty,
    required this.unitPrice,
    required this.lineTotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  OrderItem copyWith({
    String? mealId,
    String? vendorId,
    int? qty,
    double? unitPrice,
    double? lineTotal,
  }) {
    return OrderItem(
      mealId: mealId ?? this.mealId,
      vendorId: vendorId ?? this.vendorId,
      qty: qty ?? this.qty,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotal: lineTotal ?? this.lineTotal,
    );
  }

  @override
  List<Object?> get props => [mealId, vendorId, qty, unitPrice, lineTotal];
}

@JsonSerializable()
class GeoLocation extends Equatable {
  final double lat;
  final double lng;

  const GeoLocation({required this.lat, required this.lng});

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);

  @override
  List<Object?> get props => [lat, lng];
}

@JsonSerializable()
class Order extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String address;
  final GeoLocation? geo;
  final String? slot;
  final String? notes;
  final String
      status; // placed|accepted|preparing|out_for_delivery|delivered|cancelled
  final DateTime? deliveredAt;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.address,
    this.geo,
    this.slot,
    this.notes,
    required this.status,
    this.deliveredAt,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? address,
    GeoLocation? geo,
    String? slot,
    String? notes,
    String? status,
    DateTime? deliveredAt,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      address: address ?? this.address,
      geo: geo ?? this.geo,
      slot: slot ?? this.slot,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isPlaced => status == 'placed';
  bool get isAccepted => status == 'accepted';
  bool get isPreparing => status == 'preparing';
  bool get isOutForDelivery => status == 'out_for_delivery';
  bool get isDelivered => status == 'delivered';
  bool get isCancelled => status == 'cancelled';

  int get totalItems => items.fold(0, (sum, item) => sum + item.qty);

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        subtotal,
        deliveryFee,
        total,
        address,
        geo,
        slot,
        notes,
        status,
        deliveredAt,
        createdAt,
      ];
}
