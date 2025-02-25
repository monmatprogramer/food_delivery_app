import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository.dart';

class GetFeaturedRestaurants {
  final RestaurantRepository respositry;
  const GetFeaturedRestaurants(this.respositry);

  /// Call method to execute the use case
  Future<Either<Failures, List<RestaurantEntity>>> call() =>
      respositry.getFeaturedRestaurants();
}
