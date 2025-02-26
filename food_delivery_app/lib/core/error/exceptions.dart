// lib/core/error/exceptions.dart

/// Exception thrown when a server error occurs
class ServerException implements Exception {
  final String message;
  
  /// Constructor
  ServerException({required this.message});
}

/// Exception thrown when a network error occurs
class NetworkException implements Exception {
  final String message;
  
  /// Constructor
  NetworkException({required this.message});
}

/// Exception thrown when a cache error occurs
class CacheException implements Exception {
  final String message;
  
  /// Constructor
  CacheException({required this.message});
}