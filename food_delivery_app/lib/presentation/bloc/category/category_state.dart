import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object?> get props => [];
}

/// Initail sate
class CategoryInitial extends CategoryState {}

/// Loading state
class CategoryLoading extends CategoryState {}

/// Loaded state with category data
class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  const CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

/// Error state
class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);
  @override
  List<Object?> get props => [message];
}
