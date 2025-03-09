import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';
import 'package:food_delivery_app/presentation/pages/cart_page.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final RestaurantEntity restaurant;
  const RestaurantDetailsPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          //Restauratn info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimensions.marginSmall,
              ),
              child: Column(
                children: [
                  _buildRestaurantHeader(),
                  const SizedBox(
                    height: AppDimensions.marginMedium,
                  ),
                  _buildDeliveryInfo(),
                  const SizedBox(
                    height: AppDimensions.marginMedium,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppDimensions.marginMedium,
                  ),
                  // Category
                  _buildCategorySection(),
                  const SizedBox(height: AppDimensions.marginLarge),
                  _buildMenuSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildOrderButton(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blue,
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: restaurant.imageUrl != null
            ? CachedNetworkImage(
                imageUrl: restaurant.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              )
            : Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.restaurant,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              // Show a snackbar to indicate this is a mock feature
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Add to favorites"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.favorite_border),
          ),
        ),
      ],
    );
  }

  //Restaurant Header Widget
  Widget _buildRestaurantHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            restaurant.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //Rating
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.marginSmall,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusSmall),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                restaurant.rating.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // Delivary Widget
  Widget _buildDeliveryInfo() {
    return Row(
      children: [
        //Delivery time
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: 16,
              color: AppColors.textSecondary,
            ),
            Text(
              restaurant.deliveryTime,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: AppDimensions.marginMedium,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurant.tags.map((tag) {
                return Container(
                  margin:
                      const EdgeInsets.only(right: AppDimensions.marginSmall),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.marginSmall,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                  child: Text(
                    tag.name,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontSmall,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Category widget
  Widget _buildCategorySection() {
    return Row(
      children: [
        //* Category header
        const Text(
          "Category: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //* Category body
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.marginSmall,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.3),
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
          child: Text(
            restaurant.category.name,
            style: const TextStyle(
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  // Menu section widget
  Widget _buildMenuSection() {
    final menuItems = [
      {'id': 1, 'name': 'Specialty Burger', 'price': 9.99, 'popular': true},
      {'id': 2, 'name': 'Classic Pizza', 'price': 12.99, 'popular': true},
      {'id': 3, 'name': 'Fresh Salad', 'price': 7.99, 'popular': false},
      {'id': 4, 'name': 'Vegan Wrap', 'price': 8.99, 'popular': false},
      {'id': 5, 'name': 'Dessert Platter', 'price': 6.99, 'popular': true},
    ];
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Menu header (title)
              const Text(
                "Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.fontExtraLarge,
                ),
              ),
              const SizedBox(
                height: AppDimensions.marginMedium,
              ),
              //* Menu body (Popular menu)
              const Text(
                "Popular Items",
                style: TextStyle(
                  fontSize: AppDimensions.fontLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: AppDimensions.marginSmall,
              ),
              //* Menu items
              ...menuItems.map((item) {
                final bool isPopular = item['popular'] as bool;
                if (!isPopular) return const SizedBox.shrink();
                return Card(
                  margin:
                      const EdgeInsets.only(bottom: AppDimensions.marginSmall),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.marginMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //* Item name & price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${item['price']}",
                              style: const TextStyle(
                                color: AppColors.primary,
                              ),
                            )
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        //* Button for adding the item
                        ElevatedButton(
                          onPressed: () {
                            // Add the item to the cart

                            final cartItem = CartItemModel(
                              id: item['id'] as int,
                              name: item['name'] as String,
                              price: item['price'] as double,
                              quantity: 1,
                              restaurantId: restaurant.id,
                            );
                            context
                                .read<CartBloc>()
                                .add(AddToCartEvent(cartItem));

                            // Show a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${item['name']} added to cart"),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: "View Cart",
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CartPage()));
                                  },
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(40, 36),
                            shadowColor: Colors.amber,
                          ),
                          child: const Text("Add"),
                        ),
                        const SizedBox(
                          height: AppDimensions.marginMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              //* All items
              const Text(
                "All items",
                style: TextStyle(
                  fontSize: AppDimensions.fontLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: AppDimensions.marginSmall,
              ),
              //* Menu items
              ...menuItems.map(
                (item) {
                  return Card(
                    margin: const EdgeInsets.only(
                        bottom: AppDimensions.marginSmall),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.marginMedium),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  //* name of menu item
                                  Text(
                                    item['name'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //* tag of popular on the menu items
                                  if (item['popular'] as bool)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: AppDimensions.marginSmall),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.borderRadiusSmall),
                                      ),
                                      child: const Text(
                                        "Popular",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              //*
                              Text(
                                "\$${item['price'].toString()}",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(40, 36),
                            ),
                            child: const Text("Add"),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const SliverFillRemaining();
      },
    );
  }

  // Order Buttons
  Widget _buildOrderButton() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, -2),
        )
      ]),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.marginMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
        ),
        child: const Text(
          "Start Orders",
          style: TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
