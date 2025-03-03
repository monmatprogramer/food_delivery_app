import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/domain/usecases/get_featured_restaurants.dart';
import 'package:food_delivery_app/domain/usecases/get_restaurants.dart';
import 'package:food_delivery_app/domain/usecases/get_restaurants_by_category.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_event.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurants getRestaurants; // usecase
  final GetFeaturedRestaurants getFeaturedRestaurants; // usecase
  final GetRestaurantsByCategory getRestaurantsByCategory; // usecase
  RestaurantBloc(
      {required this.getRestaurants,
      required this.getFeaturedRestaurants,
      required this.getRestaurantsByCategory})
      : super(RestaurantInitial()) {
    // Register event handlers
    on<GetRestaurantsEvent>(_onGetRestaurants);
    on<GetFeaturedRestaurantEvent>(_onGetFeaturedrestaurants);
    on<GetRestaurantsByCategoryEvent>(_onGetRestaurantsByCategory);
  }

  /// Hndle GetRestaurantsEvent
  Future<void> _onGetRestaurants(
      GetRestaurantsEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    final result = await getRestaurants();
    debugPrint("➡️ Result: $result");
    result.fold(
      (failure) => emit(RestaurantError(failure.message)),
      (restaurants) => emit(RestaurantLoaded(restaurants)),
    );
  }

  /// Handle GetFeaturedRestaurantEvent
  Future<void> _onGetFeaturedrestaurants(
      GetFeaturedRestaurantEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    final result = await getFeaturedRestaurants();
    result.fold((failure) => emit(RestaurantError(failure.message)),
        (restaurants) => emit(FeaturedRestaurantLoaded(restaurants)));
  }

  /// Handle GetRestaurantsByCategoryEvent
  Future<void> _onGetRestaurantsByCategory(GetRestaurantsByCategoryEvent event,
      Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    final result =
        await getRestaurantsByCategory(Params(categoryId: event.categoryId));
    result.fold(
      (failure) => emit(RestaurantError(failure.message)),
      (restaurants) => emit(FeaturedRestaurantLoaded(restaurants)),
    );
  }
}
