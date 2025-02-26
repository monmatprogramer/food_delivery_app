import 'package:food_delivery_app/data/models/restaurant_model.dart';

abstract class RestaurantLocalDataSource {
  /// Cache restaurants
  Future<void> cachRestaurants(List<RestaurantModel> restaurants);

  /// Get cache restaurants
  Future<List<RestaurantModel>> getCacheRestaurants();

  /// Cache featured restaurants
  /// Cet cached featured restaurants
  /// Cache categories
  /// Get cache catogries
}
