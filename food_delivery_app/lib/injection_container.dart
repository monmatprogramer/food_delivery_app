import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/data/models/category_model.dart';
import 'package:food_delivery_app/data/models/restaurant_model.dart';
import 'package:food_delivery_app/data/models/tag_model.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

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
  sl.registerFactory(() => RestaurantBloc(
      getRestaurants: sl(),
      getFeaturedRestaurants: sl(),
      getRestaurantsByCategory: sl()));
}
