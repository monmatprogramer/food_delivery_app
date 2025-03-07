import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final currentState = state;
  }
}
