// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      paymentMethod: json['paymentMethod'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] as String? ?? "Pending",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'paymentMethod': instance.paymentMethod,
      'items': instance.items,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
