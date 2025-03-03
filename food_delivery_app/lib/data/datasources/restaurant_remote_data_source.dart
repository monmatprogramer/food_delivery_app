import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/network/dio_client.dart';
import 'package:food_delivery_app/data/models/category_model.dart';
import 'package:food_delivery_app/data/models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  /// Get all restaurants from API
  Future<List<RestaurantModel>> getRestaurants();

  /// Get featured restaurants from API
  Future<List<RestaurantModel>> getFeaturedRestaurants();

  /// Get restaurants by category from API
  Future<List<RestaurantModel>> getRestaurantsByCategory(int categoryId);

  /// Get restaurant by ID from API
  Future<RestaurantModel> getRestaurantById(int id);

  /// Get all categories from API
  Future<List<CategoryModel>> getCategories();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final ApiClient client;

  RestaurantRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await client.get(AppConstants.categoriesEndpoint);
      final responseConverted = (response.data['results'] as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      debugPrint("🆗 category response data: $responseConverted");
      return responseConverted;
    } on DioException catch (e) {
      throw ServerException(
          message:
              e.response?.statusMessage ?? AppConstants.serverErrorMessage);
    } catch (e) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }

  @override
  Future<List<RestaurantModel>> getFeaturedRestaurants() async {
    try {
      final response = await client.get(AppConstants.featuredEndpoint);

      // Conver response to list of model
      return (response.data['results'] as List)
          .map(
            (json) => RestaurantModel.fromJson(json),
          )
          .toList();
    } on DioException catch (e) {
      throw ServerException(
          message:
              e.response?.statusMessage ?? AppConstants.serverErrorMessage);
    } catch (e) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }

  @override
  Future<RestaurantModel> getRestaurantById(int id) async {
    try {
      final respone =
          await client.get("${AppConstants.restaurantsEndpoint}$id/");
      // Convert to list of model
      return RestaurantModel.fromJson(respone.data);
    } on DioException catch (e) {
      throw ServerException(
          message:
              e.response?.statusMessage ?? AppConstants.serverErrorMessage);
    } catch (e) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final response = await client.get(AppConstants.restaurantsEndpoint);
      // Convert response to list of model
      return (response.data['results'] as List)
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
          message:
              e.response?.statusMessage ?? AppConstants.serverErrorMessage);
    } catch (e) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsByCategory(int categoryId) async {
    try {
      final response = await client.get(AppConstants.restaurantsEndpoint,
          queryParameters: {'category': categoryId});
      // Convert to list of model
      return (response.data['results'] as List)
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
          message:
              e.response?.statusMessage ?? AppConstants.serverErrorMessage);
    } catch (e) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }
}
