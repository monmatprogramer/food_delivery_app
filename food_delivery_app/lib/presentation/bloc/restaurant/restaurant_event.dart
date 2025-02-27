import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch all restaurants
class GetRestaurantsEvent extends RestaurantEvent {}

/// Event to fetch featured restaurants
class GetFeaturedRestaurantEvent extends RestaurantEvent {}

/// Event to fetch restaurants by category
class GetRestaurantsByCategoryEvent extends RestaurantEvent {
  final int categoryId;
  const GetRestaurantsByCategoryEvent(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}
/// 