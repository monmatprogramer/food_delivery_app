import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository.dart';

class GetCategories {
  final RestaurantRepository repository;
  const GetCategories(this.repository);

  /// Call method to execute repository
  Future<Either<Failures, List<CategoryEntity>>> call() => repository.getCategories();
}
