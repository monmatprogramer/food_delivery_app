import 'package:food_delivery_app/data/models/category_model.dart';
import 'package:food_delivery_app/data/models/restaurant_model.dart';
import 'package:food_delivery_app/data/models/tag_model.dart';

class MockRestaurantData {
  // Categories
  static final List<CategoryModel> categories = [
    const CategoryModel(id: 1, name: 'Chinese', icon: 'restaurant'),
    const CategoryModel(id: 2, name: 'Italian', icon: 'local_pizza'),
    const CategoryModel(id: 3, name: 'Mexican', icon: 'fastfood'),
    const CategoryModel(id: 4, name: 'Vegetarian', icon: 'eco'),
    const CategoryModel(id: 5, name: 'Desserts', icon: 'cake'),
  ];

  // Resturants
  static final List<TagModel> tags = [
    const TagModel(id: 1, name: 'Fast Food'),
    const TagModel(id: 2, name: 'Healthy'),
    const TagModel(id: 3, name: 'Spicy'),
    const TagModel(id: 4, name: 'Vegan'),
    const TagModel(id: 5, name: 'Breakfast'),
    const TagModel(id: 6, name: 'Lunch'),
    const TagModel(id: 7, name: 'Dinner'),
  ];

  // Get restaurants
  static List<RestaurantModel> getRestaurants() {
    return [
      RestaurantModel(
        id: 1,
        name: 'Sushi Paradise',
        imageUrl:
            'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        rating: 4.8,
        deliveryTime: '30-40 min',
        category: categories[0], // Chinese
        tags: [tags[1], tags[6]], // Healthy, Dinner
        isFeatured: true,
      ),
      RestaurantModel(
        id: 2,
        name: 'Pizza Express',
        imageUrl:
            'https://images.unsplash.com/photo-1590947132387-155cc02f3212?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        rating: 4.5,
        deliveryTime: '20-30 min',
        category: categories[1], // Italian
        tags: [tags[0], tags[5], tags[6]], // Fast Food, Lunch, Dinner
        isFeatured: true,
      ),
      RestaurantModel(
        id: 3,
        name: 'Taco Town',
        imageUrl:
            'https://images.unsplash.com/photo-1564767609342-620cb19b2357?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        rating: 4.3,
        deliveryTime: '25-35 min',
        category: categories[2], // Mexican
        tags: [tags[0], tags[2]], // Fast Food, Spicy
        isFeatured: false,
      ),
      RestaurantModel(
        id: 4,
        name: 'Green Garden',
        imageUrl:
            'https://images.unsplash.com/photo-1540420773420-3366772f4999?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        rating: 4.6,
        deliveryTime: '35-45 min',
        category: categories[3], // Vegetarian
        tags: [tags[1], tags[3]], // Healthy, Vegan
        isFeatured: false,
      ),
      RestaurantModel(
        id: 5,
        name: 'Sweet Treats',
        imageUrl:
            'https://images.unsplash.com/photo-1559598467-f8b76c8155d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        rating: 4.7,
        deliveryTime: '15-25 min',
        category: categories[4], // Desserts
        tags: [tags[4]], // Breakfast
        isFeatured: true,
      ),
    ];
  }

  // Get featured restaurant
  static List<RestaurantModel> getFeaturedRestaurants() {
    return getRestaurants()
        .where((restaurant) => restaurant.isFeatured)
        .toList();
  }

  // Get restaurant by category
  static List<RestaurantModel> getRestaurantsByCategory(int categoryId) {
    return getRestaurants()
        .where((restaurant) => restaurant.category.id == categoryId)
        .toList();
  }

  // Get restaurant by id
  static RestaurantModel? getRestaurantById(int id) {
    try {
      return getRestaurants().firstWhere((restaurant) => restaurant.id == id);
    } catch (e) {
      return null;
    }
  }
}
