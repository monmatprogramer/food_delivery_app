
import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';

import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/core/network/network_info.dart';
import 'package:food_delivery_app/data/datasources/remote/order_remote_data_source.dart';
import 'package:food_delivery_app/data/models/order_model.dart';
import 'package:food_delivery_app/domain/reponsitories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, OrderModel>> createOrder(OrderModel order) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOrder = await remoteDataSource.createOrder(order);
        return Right(remoteOrder);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: "No internet connection"));
    }
  }

  @override
  Future<Either<Failures, OrderModel>> getOrderById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOrder = await remoteDataSource.getOrderById(id);
        return Right(remoteOrder);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: "No internet connection"));
    }
  }

  @override
  Future<Either<Failures, List<OrderModel>>> getOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOrder = await remoteDataSource.getOrders();
        return Right(remoteOrder);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(
        NetworkFailure(message: "No internet connection"),
      );
    }
  }
}
