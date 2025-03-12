import 'package:food_delivery_app/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  /// Create a new order
  Future<OrderModel> createOrder(OrderModel order);

  /// Get all orders for a user
  Future<List<OrderModel>> getOrders();

  /// Get order by ID
  Future<OrderModel> getOrderById(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource{
  @override
  Future<OrderModel> createOrder(OrderModel order) {
    // TODO: implement createOrder
    throw UnimplementedError();
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
