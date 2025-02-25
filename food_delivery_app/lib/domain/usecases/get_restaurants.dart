import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository.dart';

class GetRestaurants {
  final RestaurantRepository repository;
  const GetRestaurants(this.repository);


  /// Call method to execute the use case
  Future<Either<Failures, List<RestaurantEntity>>> call() =>
      repository.getRestaurants();
}
