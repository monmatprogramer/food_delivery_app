import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/data/models/category_model.dart';
import 'package:food_delivery_app/data/models/restaurant_model.dart';
import 'package:hive/hive.dart';

abstract class RestaurantLocalDataSource {
  /// Cache restaurants
  Future<void> cachRestaurants(List<RestaurantModel> restaurants);

  /// Get cache restaurants
  Future<List<RestaurantModel>> getCacheRestaurants();

  /// Cache featured restaurants
  Future<void> cacheFeaturedRestaurants(List<RestaurantModel> restaurants);

  /// Cet cached featured restaurants
  Future<List<RestaurantModel>> getCachedFeaturedRestaurants();

  /// Cache categories
  Future<void> cacheCategories(List<CategoryModel> categories);

  /// Get cache catogries
  Future<List<CategoryModel>> getCachedCategories();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final Box<RestaurantModel> restaurantBox;
  final Box<CategoryModel> categoriesBox;

  const RestaurantLocalDataSourceImpl(
      {required this.restaurantBox, required this.categoriesBox});

  @override
  Future<void> cachRestaurants(List<RestaurantModel> restaurants) async {
    try {
      // Clear previous data
      await restaurantBox.clear();

      // Add new data - using id as key
      for (var restaurant in restaurants) {
        await restaurantBox.put(restaurant.id, restaurant);
      }
    } catch (e) {
      throw CacheException(message: AppConstants.cacheErrorMessage);
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      await categoriesBox.clear();

      for (var category in categories) {
        await categoriesBox.put(category.id, category);
      }
    } catch (e) {
      throw CacheException(message: AppConstants.cacheErrorMessage);
    }
  }

  @override
  Future<void> cacheFeaturedRestaurants(
      List<RestaurantModel> restaurants) async {
    try {
      // Get existing data
      final existingRestaurants =
          Map.fromEntries(restaurantBox.values.map((r) => MapEntry(r.id, r)));
      // Update with featured flag
      for (var restaurant in restaurants) {
        var updatedRestaurant = restaurant;
        if (existingRestaurants.containsKey(updatedRestaurant.id)) {
          // Restaurant already exists,just update featured flag
          await restaurantBox.put(updatedRestaurant.id, updatedRestaurant);
        } else {
          // New restaurant, add to box
          await restaurantBox.put(updatedRestaurant.id, updatedRestaurant);
        }
      }
    } catch (e) {
      throw CacheException(message: AppConstants.cacheErrorMessage);
    }
  }

  @override
  Future<List<RestaurantModel>> getCacheRestaurants() async {
    try {
      // Get all values in the box
      return restaurantBox.values
          .where((restaurant) => !restaurant.isFeatured)
          .toList();
    } catch (e) {
      throw CacheException(message: AppConstants.cacheErrorMessage);
    }
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    try {
      // Get all values in the box
      return categoriesBox.values.toList();
    } catch (e) {
      throw CacheException(message: AppConstants.cacheErrorMessage);
    }
  }

  @override
  Future<List<RestaurantModel>> getCachedFeaturedRestaurants() async {
    try {
      return restaurantBox.values
          .where((restaurant) => restaurant.isFeatured)
          .toList();
    } catch (e) {
      throw CacheException(message: AppConstants.cacheErrorMessage);
    }
  }
}
