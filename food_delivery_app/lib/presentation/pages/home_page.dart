import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_event.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_state.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;
  int _selectedCategoryIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _setUpController();
  //   // Load initial data
  //   _loadData();
  // }

  // /// Set up scroll controller for collapsible app bar
  // void _setUpController() {
  //   _scrollController.addListener(() {
  //     if (_scrollController.offset > 150 && !_isAppBarCollapsed) {
  //       setState(() {
  //         _isAppBarCollapsed = true;
  //       });
  //     } else if (_scrollController.offset <= 150 && _isAppBarCollapsed) {
  //       setState(() {
  //         _isAppBarCollapsed = false;
  //       });
  //     }
  //   });
  // }

  // /// Load initial data (categories and rstaurants)
  // void _loadData() {
  //   // Load categories
  //   context.read<CategoryBloc>().add(GetCategoryEvent());

  //   // Load featured restaurants
  //   context.read<RestaurantBloc>().add(GetFeaturedRestaurantEvent());

  //   // Load all restaurants
  //   context.read<RestaurantBloc>().add(GetRestaurantsEvent());
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with Banner
          _builderAppBar(),

          // Category section
          _buildCategories(),
        ],
      ),
    );
  }

  /// Builder collapsible app bar with banner
  Widget _builderAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: _isAppBarCollapsed
            ? const Text(
                AppConstants.appTitle,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            : null,
        background: Stack(
          children: [
            // Banner image
            Image.network(
              "https://cdn.georgeinstitute.org/sites/default/files/styles/width1920_fallback/public/2020-10/world-food-day-2020.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),

            // Banner Text
            Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppConstants.appTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppDimensions.fontTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Oder your favorite food",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppDimensions.fontMedium,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  // Build categories section with horizontal list
  Widget _buildCategories() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70,
        child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          if (state is CategoryLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.error),
              ),
            );
          } else if (state is CategoryLoaded) {
            final categories = state.categories;

            // Add "All" category at the beginning
            final allCategories = [
              const CategoryEntity(id: 0, name: "All", icon: "restaurant"),
              ...categories,
            ];
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.marginSmall,
                  vertical: AppDimensions.marginSmall,
                ),
                itemCount: allCategories.length,
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  final isSelected = _selectedCategoryIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                      //Load restaurants by category
                      if (index == 0) {
                        // "All" category selected
                        context
                            .read<RestaurantBloc>()
                            .add(GetRestaurantsEvent());
                      } else {
                        //sepecif category selected
                        context
                            .read<RestaurantBloc>()
                            .add(GetRestaurantsByCategoryEvent(category.id));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.marginSmall,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.marginMedium,
                        vertical: AppDimensions.marginSmall,
                      ),
                      decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category,
                            size: 20,
                            color:
                                isSelected ? Colors.white : AppColors.primary,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            category.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
