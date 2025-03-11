import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';

/**
 * This is brain:
 * 1. Receive actions from user (events)
 * 2. Decides what to do with them
 * 3. Updates the app's display (states)
 */
class CartBloc extends Bloc<CartEvent, CartState> {
  // Fistly, we need to add CartInitial state
  // because it as opening door to app
  CartBloc() : super(CartInitial()) {
    //Register event and handler of event

    // We register its type is AddToCartEvent.
    // Second, we call handler to do something to add item into Cart
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdatedCartItem);
    on<ClearCartEvent>(_onClearCart);

    // Initialize with empty cart.
    //emit(CartLoaded(CartModel(items: [], restaurantId: 0)));
    //---For testing---
    final pizzaItem = CartItemModel(
      id: 1,
      name: 'Pepperoni Pizza',
      price: 12.99,
      quantity: 1,
      restaurantId: 1,
    );
    final cart = CartModel(items: [pizzaItem], restaurantId: 1);
    emit(CartLoaded(cart));
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    print("👉event: $event");
    //Ex: AddToCartEvent(CartItemModel(
    //  CarItemModel(id: 3, name: Caesar Salad, price: 7.5, quantity: 1, restaurantId: 102)
    //));
    // Track the state of this event
    final currentState = state;
    //Ex: CartLoaded(CartModel(items: [], restaurantId: 0)) <== this is state
    // currentState = CartLoaded() => true
    print("👉currentState: $currentState");
    if (currentState is CartLoaded) {
      try {
        final currentCart = currentState.cart;
        //Ex: CartModel(items: [], restaurantId: 0) <== for the first state
        print("👉currentCart: $currentCart");

        // get currentCart data from this state
        // Check if item is from the same restaurant
        // User cannot add the same restaurant into cart but only update its quality
        // becase the restaurant already exist in the Cart.
        if (currentCart.items.isNotEmpty &&
            currentCart.restaurantId != event.item.restaurantId) {
          //Add item into cart, it require two things
          // 1. restaurantId: Which restaurant that you will purchase or buy the item
          // 2. items: choose items that you want to buy it latter, It can be one or multiples.
          final newCart = CartModel(
            items: [event.item],
            restaurantId: event.item.restaurantId,
          );

          // After we have item that want to add into Cart,
          // we call this state to add the a new item into the Cart.
          emit(CartLoaded(newCart));
        } else {
          // Check if item already exists in cart
          // even.item.id : It is user input.
          print('track on even: ${event.item}');
          print("currentCart.items: ${currentCart.items}");
          final existingItemIndex =
              currentCart.items.indexWhere((item) => item.id == event.item.id);
          print("existingItemIndex: $existingItemIndex");

          if (existingItemIndex >= 0) {
            //Existing
            final existingItem = currentCart.items[existingItemIndex];
            print("existingItem: ${currentCart.items[existingItemIndex]}");

            //If the Cart has item(s), we only need to update its quantity
            // and other information of this item(s) still keep the same.
            //Ex old: pizza(1) => update to pizza(2 or 3)
            final updatedItem = existingItem.copyWith(
              quantity: existingItem.quantity + event.item.quantity,
            );

            print("updatedItem: $updatedItem");
            print("event.item.restaurantId: ${event.item.restaurantId}"); //102
            print(
                "currentCart.restaurantId: ${currentCart.restaurantId}"); //102

            final updatedItems = List<CartItemModel>.from(currentCart.items);
            updatedItems[existingItemIndex] = updatedItem;

            final newCart = CartModel(
              items: updatedItems,
              restaurantId: currentCart.restaurantId != 0
                  ? currentCart.restaurantId
                  : event.item.restaurantId,
            );
            emit(CartLoaded(newCart));
          }
        }
      } catch (e) {
        emit(CartError("Failed to add item to cart"));
      }
    }
  }

  //* Remove Item from Cart
  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is CartLoaded) {
      try {
        print("➡️currentState.cart.items: ${currentState.cart.items}");
        final updatedItems = currentState.cart.items
            .where((item) => item.id != event.itemId)
            .toList();

        final newCart = CartModel(
          items: updatedItems,
          restaurantId:
              updatedItems.isEmpty ? 0 : currentState.cart.restaurantId,
        );
        print("➡️updatedItems: $updatedItems");
        emit(CartLoaded(newCart));
      } catch (e) {
        emit(CartError("Failed to remove item from Cart"));
      }
    }
  }

  //* Update item in the Cart
  void _onUpdatedCartItem(UpdateCartItemEvent event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedItems = List<CartItemModel>.from(currentState.cart.items);
      final itemIndex =
          updatedItems.indexWhere((item) => item.id == event.itemId);

      if (itemIndex >= 0) {
        if (event.quantity <= 0) {
          updatedItems.removeAt(itemIndex);
        } else {
          final item = updatedItems[itemIndex];
          updatedItems[itemIndex] = item.copyWith(quantity: event.quantity);
        }

        final newCart = CartModel(
            items: updatedItems,
            restaurantId:
                updatedItems.isEmpty ? 0 : currentState.cart.restaurantId);
        emit(CartLoaded(newCart));
      }

      try {} catch (e) {
        emit(CartError("Failed to update item in the Cart."));
      }
    }
  }

  //* CLear item from Cart
  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(CartLoaded(CartModel(items: [], restaurantId: 0)));
  }
}
