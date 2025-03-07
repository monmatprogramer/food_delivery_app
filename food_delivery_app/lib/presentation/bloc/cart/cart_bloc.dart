import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // Fistly, we need to add CartInitial state
  // because it as opening door to app
  CartBloc() : super(CartInitial()) {
    //Register event and handler of event

    // We register its type is AddToCartEvent.
    // Second, we call handler to do something to add item into Cart
    on<AddToCartEvent>(_onAddToCart);

    // Initialize with empty cart.
    emit(CartLoaded(
      CartModel(items: [], restaurantId: 0),
    ));
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    // Track the state of this event
    final currentState = state;

    if (currentState is CartLoaded) {
      try {
        final currentCart =
            currentState.cart; // get currentCart data from this state

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
          final existingItemIndex =
              currentCart.items.indexWhere((item) => item.id == event.item.id);

          if (existingItemIndex >= 0) {
            //Existing
            final existingItem = currentCart.items[existingItemIndex];

            //If the Cart has item(s), we only need to update its quantity
            // and other information of this item(s) still keep the same.
            //Ex old: pizza(1) => update to pizza(2 or 3)
            final updatedItem = existingItem.copyWith(
              quantity: existingItem.quantity + event.item.quantity,
            );

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
}
