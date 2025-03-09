import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';

void mainReresentor() {
  // 1. Create food items
  final pizzaItem = CartItemModel(
    id: 1,
    name: 'Pepperoni Pizza',
    price: 12.99,
    quantity: 1,
    restaurantId: 101,
  );

  final burgerItem = CartItemModel(
    id: 2,
    name: 'Cheese Burger',
    price: 8.99,
    quantity: 1,
    restaurantId: 101,
  );

  final saladItem = CartItemModel(
    id: 3,
    name: 'Caesar Salad',
    price: 7.50,
    quantity: 1,
    restaurantId: 102,
  );

  final cartBloc = CartBloc();
  debugPrint("Initial state: ${cartBloc.state}");

  debugPrint("\nAdding pizza to cart...");
  //cartBloc.add(AddToCartEvent(pizzaItem));

  final stateAfterPizza = CartLoaded(
    CartModel(items: [pizzaItem], restaurantId: 101),
  );
  //resutl: CartLoaded(CartModel(items: [CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 1, restaurantId: 101)], restaurantId: 101))

  debugPrint("State after adding pizza: $stateAfterPizza");

  debugPrint("\nAdding another pizza...");
  //cartBloc.add(AddToCartEvent(pizzaItem));

  //Simulate state after adding another pizza
  final pizzaWithQty2 = pizzaItem.copyWith(quantity: 2);
  final stateAfterSecondPizza = CartLoaded(
    CartModel(items: [pizzaWithQty2], restaurantId: 101),
  );
  //Output: CartLoaded(CartModel(items: [CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 2, restaurantId: 101)], restaurantId: 101))

  debugPrint("State after adding another pizza: $stateAfterSecondPizza");

  debugPrint("\nAdding burger from same restaurant...");
  //cartBloc.add(AddToCartEvent(burgerItem));

  // Simulated state after adding burger
  final stateAfterBurger = CartLoaded(
      CartModel(items: [pizzaWithQty2, burgerItem], restaurantId: 101));

  debugPrint("\nTrying to add salad from different restaurant...");
  //cartBloc.add(AddToCartEvent(saladItem));
  debugPrint("👉saladItem: $saladItem");

  final saladWithQty3 = saladItem.copyWith(quantity: 3);
  final stateAfterSalad = CartLoaded(
      CartModel(items: [saladWithQty3], restaurantId: saladItem.restaurantId));
  debugPrint("Salad after update its quantity: $stateAfterSalad");

  //* ----Remove an item from Cart testing-----
  cartBloc.add(RemoveFromCartEvent(1));
}
