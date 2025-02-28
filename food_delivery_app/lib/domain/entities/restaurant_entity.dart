import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/entities/tag_entity.dart';

class RestaurantEntity extends Equatable {
  final int id;
  final String name;
  final String? imageUrl;
  final double rating;
  final String deliveryTime;
  final CategoryEntity category;
  final List<TagEntity> tags;
  final bool isFeatured;

  const RestaurantEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.category,
    required this.tags,
    this.isFeatured = false,
  });

  @override
  List<Object?> get props => [id,name,imageUrl,rating,deliveryTime,category,tags,isFeatured];
}
