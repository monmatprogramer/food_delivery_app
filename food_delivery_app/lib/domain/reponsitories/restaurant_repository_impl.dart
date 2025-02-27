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
  Future<Either<Failures, List<CategoryEntity>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        await localDataSource.cacheCategories(remoteCategories);
        return Right(remoteCategories);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localCategories = await localDataSource.getCachedCategories();
        return Right(localCategories);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failures, List<RestaurantEntity>>>
      getFeaturedRestaurants() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants =
            await remoteDataSource.getFeaturedRestaurants();
        await localDataSource.cacheFeaturedRestaurants(remoteRestaurants);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants =
            await localDataSource.getCachedFeaturedRestaurants();
        return Right(localRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failures, RestaurantEntity>> getRestaurantDetails(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurant = await remoteDataSource.getRestaurantById(id);
        return Right(remoteRestaurant);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants = await localDataSource.getCacheRestaurants();
        final restaurant = localRestaurants.firstWhere(
          (restaurant) => restaurant.id == id,
          orElse: () =>
              throw CacheException(message: "Restaurant not found in cache."),
        );
        return Right(restaurant);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
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
      int categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants =
            await remoteDataSource.getRestaurantsByCategory(categoryId);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants = await localDataSource.getCacheRestaurants();
        final filteredRestaurants = localRestaurants
            .where((restaurant) => restaurant.category.id == categoryId)
            .toList();
        return Right(filteredRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
}
