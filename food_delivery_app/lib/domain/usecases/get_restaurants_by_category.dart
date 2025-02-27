import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository.dart';

class GetRestaurantsByCategory {
  final RestaurantRepository repository;

  const GetRestaurantsByCategory(this.repository);

  /// Call method to execute repository
  Future<Either<Failures, List<RestaurantEntity>>> call(Params params) =>
      repository.getRestaurantsByCategory(params.categoryId);
}

class Params extends Equatable {
  final int categoryId;
  const Params({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
