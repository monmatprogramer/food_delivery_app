import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_event.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_state.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_event.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_state.dart';
import 'package:food_delivery_app/presentation/pages/restaurant_details_page.dart';
import 'package:food_delivery_app/presentation/widgets/error_widget.dart';
import 'package:food_delivery_app/presentation/widgets/featured_restaurant_card.dart';
import 'package:food_delivery_app/presentation/widgets/loading_widget.dart';
import 'package:food_delivery_app/presentation/widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _setUpController();
    // Load initial data
    _loadData();
  }

  /// Set up scroll controller for collapsible app bar
  void _setUpController() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 150 && !_isAppBarCollapsed) {
        setState(() {
          _isAppBarCollapsed = true;
        });
      } else if (_scrollController.offset <= 150 && _isAppBarCollapsed) {
        setState(() {
          _isAppBarCollapsed = false;
        });
      }
    });
  }

  /// Load initial data (categories and rstaurants)
  void _loadData() {
    debugPrint("ℹ _loadData is called");
    // Load categories
    context.read<CategoryBloc>().add(GetCategoryEvent());

    // Load featured restaurants
    context.read<RestaurantBloc>().add(GetFeaturedRestaurantEvent());

    // Load all restaurants
    context.read<RestaurantBloc>().add(GetRestaurantsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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

          //Featured Restaurants
          _buildFeaturedRestaurants(),

          // All Restaurant List
          _buildRestaurantList(),
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
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        background: Stack(
          children: [
            // Banner image
            Image.network(
              "https://www.thetakeout.com/img/gallery/this-is-the-ideal-amount-of-time-to-spend-at-a-restaurant/slide--1724859999.webp",
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
                ),
              ),
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
          if (state is CategoryLoading) {
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
                            _getCategoryIcon(category.icon),
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

  /// Build featured restaurants section with horizontal scrolling cards
  Widget _buildFeaturedRestaurants() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppDimensions.marginSmall),
            child: Text(
              AppConstants.featuredRestaurants,
              style: TextStyle(
                fontSize: AppDimensions.fontExtraLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FeaturedRestaurantLoaded) {
                  final restaurants = state.restaurants;

                  if (restaurants.isEmpty) {
                    return const Center(
                      child: Text("No Featured restaurants available"),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.marginSmall,
                    ),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return FeaturedRestaurantCard(
                        restaurant: restaurant,
                        onTap: () => _navigateToRestaurantDetails(restaurant),
                      );
                    },
                  );
                } else if (state is RestaurantError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: AppColors.error),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantList() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        debugPrint("🆗 state is : $state");
        if (state is RestaurantLoading) {
          return const SliverFillRemaining(
            child: LoadingWidget(),
          );
        } else if (state is RestaurantLoaded) {
          final restaurants = state.restaurants;

          if (restaurants.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text("No restaurants avaialable"),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  // Section header
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppDimensions.marginMedium,
                      AppDimensions.marginMedium,
                      AppDimensions.marginMedium,
                      AppDimensions.marginSmall,
                    ),
                    child: Text(
                      AppConstants.allRestaurants,
                      style: TextStyle(
                        fontSize: AppDimensions.fontExtraLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                final restaurant = restaurants[index - 1];
                return RestaurantListCard(
                  restaurant: restaurant,
                  onTap: () => _navigateToRestaurantDetails(restaurant),
                );
              },
              childCount: restaurants.length + 1,
            ),
          );
        } else if (state is RestaurantError) {
          return SliverFillRemaining(
            child: ErrorDisplayWidget(
              message: state.message,
              onRetry: () {
                debugPrint("🔼 OnRetry is pressed");
                context.read<RestaurantBloc>().add(GetRestaurantsEvent());
              },
            ),
          );
        }
        return const SliverFillRemaining(
          child: SizedBox.shrink(),
        );
      },
    );
  }

  /// Navigate to restaurant detail page
  void _navigateToRestaurantDetails(RestaurantEntity restaurant) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RestaurantDetailsPage(restaurant: restaurant)));
  }

  /// Helper method to convert category icon string to IconData
  IconData _getCategoryIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'restaurant':
        return Icons.restaurant;
      case 'fastfood':
        return Icons.fastfood;
      case 'local_pizza':
        return Icons.local_pizza;
      case 'eco':
        return Icons.eco;
      case 'cake':
        return Icons.cake;
      case 'local_drink':
        return Icons.local_drink;
      default:
        return Icons.restaurant;
    }
  }
}
