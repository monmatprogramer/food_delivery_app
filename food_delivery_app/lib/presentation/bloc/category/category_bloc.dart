import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/domain/usecases/get_categories.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_event.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  CategoryBloc({required this.getCategories}) : super(CategoryInitial()) {
    // Register event handles
    on<GetCategoryEvent>(_onGetCategories);
  }

  /// Handle CategoriesEvent
  Future<void> _onGetCategories(
    GetCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await getCategories();
    result.fold((failure) => emit(CategoryError(failure.message)),
        (categories) => emit(CategoryLoaded(categories)));
  }
}
