import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String tier;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.tier,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? tier,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      tier: tier ?? this.tier,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  bool get isBasicTier => tier == 'Basic';
  bool get isPlusTier => tier == 'Plus';
  bool get isProTier => tier == 'Pro';

  @override
  List<Object?> get props => [id, name, email, phone, tier, avatarUrl];
}
