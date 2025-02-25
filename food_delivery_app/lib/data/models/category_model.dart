import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

// Add this
part 'category_model.g.dart';

/// Category model for serialzation and storage
@JsonSerializable()
@HiveType(typeId: 1)
class CategoryModel extends CategoryEntity {
  /// Constructure
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  const CategoryModel(
      {required this.id, required this.name, required this.icon})
      : super(id: id, name: name, icon: icon);
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
