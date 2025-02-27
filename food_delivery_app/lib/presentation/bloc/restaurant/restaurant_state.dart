import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
  @override
  List<Object?> get props => [];
}

/// Initial state
class RestaurantInitial extends RestaurantState {}

/// Loading state
class RestaurantLoading extends RestaurantState {}

/// Loaded state with restaurant data
class RestaurantLoaded extends RestaurantState {
  final List<RestaurantEntity> restaurants;
  const RestaurantLoaded(this.restaurants);
  @override
  List<Object?> get props => [restaurants];
}

/// Featured restaurants loaded state
class FeaturedRestaurantLoaded extends RestaurantState {
  final List<RestaurantEntity> restaurants;
  const FeaturedRestaurantLoaded(this.restaurants);
  @override
  List<Object?> get props => [restaurants];
}

/// Errror state
class RestaurantError extends RestaurantState {
  final String message;
  const RestaurantError(this.message);
  @override
  List<Object?> get props => [message];
}
