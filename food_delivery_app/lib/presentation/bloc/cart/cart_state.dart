import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

// Loading at beginning
class CartInitial extends CartState {}

// After loading success.
class CartLoaded extends CartState {
  // CartModel assum as place holder
  // that store item(s) in it.
  final CartModel cart;

  // It is optional because
  // it can be empty or has item(s)
  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  // If it encounter error
  // it hould has messsage to user
  final String message;

  //Optinal
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
