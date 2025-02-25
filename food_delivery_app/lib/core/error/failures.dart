import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  const Failures({required this.message});

  @override
  List<Object?> get props => [message];
}

//? 1.Server Failure
class ServerFailure extends Failures {
  const ServerFailure({required super.message});
}

//? 2.Network Failure
class NetworkFailure extends Failures {
  const NetworkFailure({required super.message});
}

//? 3.Cache Failure
class CacheFailure extends Failures {
  const CacheFailure({required super.message});
}
