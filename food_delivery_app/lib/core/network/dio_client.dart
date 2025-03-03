import 'package:dio/dio.dart';
import 'package:food_delivery_app/core/network/api_urls.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger;

  ApiClient({required Dio dio, required Logger logger})
      : _dio = dio,
        _logger = logger {
    _dio.options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add intercpetor logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d("REQUEST[${options.method}] => URL: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger
              .d("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        //void Function(DioException, ErrorInterceptorHandler)?
        onError: (DioException e, handler) {
          _logger.e("ERROR[${e.response?.statusCode}] => ${e.message}");

          // Handle empty data for testing
          if (e.response?.statusCode == 404) {
            return handler.resolve(
              Response(requestOptions: e.requestOptions, data: {
                'success': true,
                'message': 'Mock data',
                'results': [],
              }),
            );
          }
          return handler.next(e);
        },
      ),
    );
  }

  /// Perform a GET request
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _logger.e("Get request failed: $e");
      rethrow;
    }
  }

  /// Perform a POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      _logger.e("POST requrest failed: $e");
      rethrow;
    }
  }

  /// Perform a PUT request
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      _logger.e("PUT request failed: $e");
      rethrow;
    }
  }

  /// Perform a DELETE request
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      _logger.e("DELETE request failed: $e");
      rethrow;
    }
  }
}
