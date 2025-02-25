import 'package:food_delivery_app/data/models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource{
  /// Get all restaurants from API
  Future<List<RestaurantModel>> getRestaurants();
  
  /// Get featured restaurants from API
  /// Get restaurants by category from API
  /// Get restaurant by ID from API
  /// Get all categories from API
}