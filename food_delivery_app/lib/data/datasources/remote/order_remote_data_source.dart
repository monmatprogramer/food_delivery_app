import 'package:dio/dio.dart';
import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/network/dio_client.dart';
import 'package:food_delivery_app/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  /// Create a new order
  Future<OrderModel> createOrder(OrderModel order);

  /// Get all orders for a user
  Future<List<OrderModel>> getOrders();

  /// Get order by ID
  Future<OrderModel> getOrderById(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient client;

  const OrderRemoteDataSourceImpl({required this.client});
  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      final response = await client.post(
        AppConstants.orderEndpoint,
        data: order.toJson(),
      );
      return OrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.statusMessage ?? AppConstants.serverErrorMessage,
      );
    }
  }

  @override
  Future<OrderModel> getOrderById(int id) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }

  @override
  Future<List<OrderModel>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }
}
