import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int? id;
  final String name;
  final String address;
  final String phone;
  final String paymentMethod;
  final List<CartItemModel> items;
  final double totalPrice;
  final String status;
  final DateTime? createdAt;

  OrderModel({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.paymentMethod,
    required this.items,
    required this.totalPrice,
    this.status = "Pending",
    this.createdAt,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> totalJson() => _$OrderModelToJson(this);
}

