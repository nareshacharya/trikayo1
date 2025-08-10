import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderItem extends Equatable {
  final String mealId;
  final int quantity;

  const OrderItem({required this.mealId, required this.quantity});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  OrderItem copyWith({String? mealId, int? quantity}) {
    return OrderItem(
      mealId: mealId ?? this.mealId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [mealId, quantity];
}

@JsonSerializable()
class Order extends Equatable {
  final String id;
  final List<OrderItem> items;
  final double total;
  final String address;
  final String slot;
  final String status;
  final DateTime? deliveredAt;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.address,
    required this.slot,
    required this.status,
    this.deliveredAt,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    List<OrderItem>? items,
    double? total,
    String? address,
    String? slot,
    String? status,
    DateTime? deliveredAt,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      address: address ?? this.address,
      slot: slot ?? this.slot,
      status: status ?? this.status,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isPlaced => status == 'placed';
  bool get isPreparing => status == 'preparing';
  bool get isDelivered => status == 'delivered';
  bool get isCancelled => status == 'cancelled';

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [
    id,
    items,
    total,
    address,
    slot,
    status,
    deliveredAt,
    createdAt,
  ];
}
