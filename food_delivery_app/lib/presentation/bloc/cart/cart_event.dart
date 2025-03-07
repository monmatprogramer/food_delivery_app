import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  // We add CartItemModel into Cart, that is add event.
  final CartItemModel item;

  // But add it inot Cart, it is optional.
  const AddToCartEvent(this.item);

  //unique property for this class
  @override
  List<Object?> get props => [item];
}

class RemoveFromCartEvent extends CartEvent {
  // We need only itemId to be removed from Cart.
  //Ex. id:1,pizza, id:2,chicken
  final int itemId;
  //Option remove item also
  const RemoveFromCartEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class ClearCartEvent extends CartEvent {}

class UpdateCartItemEvent extends CartEvent {
  /**
   * If we want to updadte item, we need to update two things
   *  1. itemId: Ex. id:1, id:2
   *  2. quantity: Ex. Pizza 3, Checken 1,
   */
  final int itemId;
  final int quantity;

  //This is telling that if you want to update
  //you must insert two things-itemId,quantiy
  const UpdateCartItemEvent({
    required this.itemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [itemId, quantity];
}
