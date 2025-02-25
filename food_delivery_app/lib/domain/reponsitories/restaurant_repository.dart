import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  /// Get all restaurants
  Future<Either<Failures, List<RestaurantEntity>>> getRestaurants();

  /// Get featured restarants
  Future<Either<Failures, List<RestaurantEntity>>> getFeaturedRestaurants();

  /// Get restaurants by category
  Future<Either<Failures, List<RestaurantEntity>>> getRestaurantsByCategory(
      int categoryId);

  /// Get restaurants details by ID
  Future<Either<Failures, RestaurantEntity>> getRestaurantDetails(int id);

  /// Get all categories
  Future<Either<Failures, List<CategoryEntity>>> getCategories();
}
