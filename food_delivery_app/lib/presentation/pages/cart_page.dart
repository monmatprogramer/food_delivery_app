import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';
import 'package:food_delivery_app/presentation/pages/check_out_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Clear Cart"),
                  content:
                      const Text("Are your sure you want to clear your cart?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cacel"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<CartBloc>().add(ClearCartEvent());
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoaded) {
          final cart = state.cart;
          //Ex: CartModel(items: [CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 6, restaurantId: 1)], restaurantId: 1)
          if (cart.isEmpty) {
            return const Center(
              child: Text("Your cart is empty"),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      //Ex: CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 6, restaurantId: 1)
                      debugPrint("➡️ item: $item");

                      return CartItemTile(item: item);
                    }),
              ),
              _buildOrderSummary(cart.totalPrice),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      bottomNavigationBar:
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoaded && !state.cart.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(AppDimensions.marginLarge),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CheckOutPage()),
                );
              },
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
              child: const Text('Proceed to Checkout'),
            ),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }

  Widget _buildOrderSummary(double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
            top: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontLarge,
            ),
          ),
          const SizedBox(
            height: AppDimensions.marginSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal"),
              Text('\$${totalPrice.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(
            height: AppDimensions.marginSmall / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Fee'),
              Text('\$${2.99.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(
            height: AppDimensions.marginSmall / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tax"),
              Text('\$${(totalPrice * 0.08).toStringAsFixed(2)}'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${(totalPrice + 2.99 + (totalPrice * 0.08)).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.marginMedium,
        vertical: AppDimensions.marginMedium,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.marginMedium),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.fontMedium),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (item.quantity > 1) {
                      context.read<CartBloc>().add(UpdateCartItemEvent(
                          itemId: item.id, quantity: item.quantity - 1));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Remove Item"),
                          content: Text(
                              'Do you want to remove ${item.name} from your cart?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<CartBloc>().add(
                                      RemoveFromCartEvent(item.id),
                                    );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Remove'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.remove_circle_outline),
                ),
              ],
            ),
            Text(
              item.quantity.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartBloc>().add(
                      UpdateCartItemEvent(
                          itemId: item.id, quantity: item.quantity + 1),
                    );
              },
              icon: Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}
