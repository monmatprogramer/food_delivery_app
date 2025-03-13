import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/data/models/order_model.dart';

abstract class OrderRepository {
  /// Create a new order
  Future<Either<Failures, OrderModel>> createOrder(OrderModel order);

  /// Get all orders
  Future<Either<Failures, List<OrderModel>>> getOrders();

  /// Get order by ID
  Future<Either<Failures, OrderModel>> getOrderById(int id);
}
