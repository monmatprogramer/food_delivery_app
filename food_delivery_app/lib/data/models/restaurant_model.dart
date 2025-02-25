import 'package:food_delivery_app/data/models/category_model.dart';
import 'package:food_delivery_app/data/models/tag_model.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/domain/entities/tag_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

/// Restaurant model for serializatin and storage
@JsonSerializable()
@HiveType(typeId: 0)
class RestaurantModel extends RestaurantEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? imageUrl;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final String deliveryTime;

  @HiveField(5)
  final CategoryModel category;

  @HiveField(6)
  final List<TagModel> tags;

  @HiveField(7)
  final bool isFeatured;

  const RestaurantModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.category,
    required this.tags,
    this.isFeatured = false,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          rating: rating,
          deliveryTime: deliveryTime,
          category: category,
          tags: tags,
          isFeatured: isFeatured,
        );

  /// Convert from Json
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

