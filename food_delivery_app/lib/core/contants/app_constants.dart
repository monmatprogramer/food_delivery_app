// lib/core/constants/app_constants.dart

class AppConstants {
  // API endpoints
  static const String restaurantsEndpoint = 'restaurants/';
  static const String featuredEndpoint = 'restaurants/featured/';
  static const String categoriesEndpoint = 'categories/';
  static const String tagsEndpoint = 'tags/';
  
  // Hive box names
  static const String restaurantsBox = 'restaurants_box';
  static const String categoriesBox = 'categories_box';
  static const String tagsBox = 'tags_box';
  
  // Error messages
  static const String serverErrorMessage = 'Server error occurred. Please try again later.';
  static const String networkErrorMessage = 'No internet connection. Please check your network.';
  static const String cacheErrorMessage = 'Cache error occurred. Please try again.';
  
  // App text
  static const String appTitle = 'Food Delivery';
  static const String featuredRestaurants = 'Featured Restaurants';
  static const String allRestaurants = 'All Restaurants';
  static const String errorTitle = 'Something went wrong';
  static const String retryText = 'Retry';
}

