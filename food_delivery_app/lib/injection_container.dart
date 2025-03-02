import 'package:dio/dio.dart';
import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/network/dio_client.dart';
import 'package:food_delivery_app/core/network/network_info.dart';
import 'package:food_delivery_app/data/datasources/local/restaurant_local_data_source.dart';
import 'package:food_delivery_app/data/datasources/restaurant_remote_data_source.dart';
import 'package:food_delivery_app/data/models/category_model.dart';
import 'package:food_delivery_app/data/models/restaurant_model.dart';
import 'package:food_delivery_app/data/models/tag_model.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository.dart';
import 'package:food_delivery_app/domain/reponsitories/restaurant_repository_impl.dart';
import 'package:food_delivery_app/domain/usecases/get_categories.dart';
import 'package:food_delivery_app/domain/usecases/get_featured_restaurants.dart';
import 'package:food_delivery_app/domain/usecases/get_restaurants.dart';
import 'package:food_delivery_app/domain/usecases/get_restaurants_by_category.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initialize dependencies
Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapter
  Hive.registerAdapter(RestaurantModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TagModelAdapter());

  // Open Hive boxes
  final restaurantsBox =
      await Hive.openBox<RestaurantModel>(AppConstants.categoriesBox);
  final categoriesBox =
      await Hive.openBox<CategoryModel>(AppConstants.categoriesBox);

  // BloCs
  sl.registerFactory(
    () => RestaurantBloc(
      getRestaurants: sl(),
      getFeaturedRestaurants: sl(),
      getRestaurantsByCategory: sl(),
    ),
  );

  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategories: sl<GetCategories>(),
    ),
  );

  //Use case
  sl.registerLazySingleton(() => GetRestaurants(sl()));
  sl.registerLazySingleton(() => GetFeaturedRestaurants(sl()));
  sl.registerLazySingleton(() => GetRestaurantsByCategory(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data source
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RestaurantLocalDataSourceImpl>(
    () => RestaurantLocalDataSourceImpl(
      restaurantBox: sl(),
      categoriesBox: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(
    () => ApiClient(
      dio: sl(),
      logger: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(
    () => Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 75,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
    ),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
