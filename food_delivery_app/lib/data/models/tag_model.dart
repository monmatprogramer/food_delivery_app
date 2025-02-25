import 'package:food_delivery_app/domain/entities/tag_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class TagModel extends TagEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  const TagModel({required this.id, required this.name})
      : super(id: id, name: name);

  //Convert from Json
  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  //Conver to json
  Map<String, dynamic> toSon() => _$TagModelToJson(this);
}
