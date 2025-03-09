import 'package:food_delivery_app/data/models/cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;
  final int restaurantId;

  CartModel({required this.items, required this.restaurantId});

  //Ex. phone=400$, quantity=2 => total = 400$ * 2 = 800$
  double get totalPrice => items.fold(
        0,
        (total, item) => total + (item.price * item.quantity),
      );
  //Ex. total 800$, quantity 3 => totalItems = 800$ + 3 = 8003
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

  bool get isEmpty => items.isEmpty;

  @override
  String toString() {
    return "CartModel(items: $items, restaurantId: $restaurantId)";
  }
}
