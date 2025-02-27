import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/core/network/network_info.dart';
import 'package:food_delivery_app/data/datasources/local/restaurant_local_data_source.dart';
import 'package:food_delivery_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, List<CategoryEntity>>> getCategories() async {}

  @override
  Future<Either<Failures, List<RestaurantEntity>>> getFeaturedRestaurants() {
    // TODO: implement getFeaturedRestaurants
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, RestaurantEntity>> getRestaurantDetails(int id) {
    // TODO: implement getRestaurantDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<RestaurantEntity>>> getRestaurants() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants = await remoteDataSource.getRestaurants();
        /**
         * remoteRestaurants stored data from fetching API
         */
        await localDataSource.cachRestaurants(remoteRestaurants);
        /**
         * After we got data, we store in localDataSource object
         */
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants = await localDataSource.getCacheRestaurants();
        return Right(localRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failures, List<RestaurantEntity>>> getRestaurantsByCategory(
      int categoryId) {
    // TODO: implement getRestaurantsByCategory
    throw UnimplementedError();
  }
}
