// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/data/models/order_model.dart';
import 'package:food_delivery_app/domain/reponsitories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;
  const CreateOrder({
    required this.repository,
  });

  Future<Either<Failures, OrderModel>> call(OrderModel order) =>
      repository.createOrder(order);
}
