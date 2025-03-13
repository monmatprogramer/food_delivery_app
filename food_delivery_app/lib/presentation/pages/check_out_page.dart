import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/models/order_model.dart';
import 'package:food_delivery_app/domain/usecases/create_order.dart';
import 'package:food_delivery_app/injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_event.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';
import 'package:food_delivery_app/presentation/pages/order_success_page.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String _paymentMethod = "Cash on Delivary";
  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Checkout"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoaded) {
          final cart = state.cart;
          if (cart.isEmpty) {
            return const Center(
              child: Text("Your cart is empty"),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.marginMedium),
              children: [
                const Text(
                  'Delivery Information',
                  style: TextStyle(
                    fontSize: AppDimensions.fontExtraLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your name"
                      : null,
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Delivary Address",
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) {
                    value = value!.trim();
                    if (value.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your phone number"
                      : null,
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                const Text(
                  "Payment Methond",
                  style: TextStyle(
                    fontSize: AppDimensions.fontExtraLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                Card(
                  child: RadioListTile<String>(
                    title: const Row(
                      children: [
                        Icon(Icons.money),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Cash on Delivary"),
                      ],
                    ),
                    value: "Cash on Delivery",
                    groupValue: _paymentMethod,
                    onChanged: (value) {
                      setState(
                        () => _paymentMethod = value!,
                      );
                    },
                  ),
                ),
                Card(
                  child: RadioListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.credit_card),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Credit Card")
                      ],
                    ),
                    value: "Credit Card",
                    groupValue: _paymentMethod,
                    onChanged: (value) => setState(
                      () => _paymentMethod = value!,
                    ),
                  ),
                ),
                Card(
                  child: RadioListTile(
                    value: "Digital Wallet",
                    groupValue: _paymentMethod,
                    onChanged: (value) => setState(
                      () => _paymentMethod = value!,
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.account_balance_wallet),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text("Digital Wallet")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.marginLarge,
                ),
                Container(
                  padding: const EdgeInsets.all(AppDimensions.marginMedium),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: AppDimensions.fontLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimensions.marginSmall,
                      ),
                      ...cart.items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${item.name} x${item.quantity}"),
                              Text(
                                  '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal"),
                          Text('\$${cart.totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // Tax
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tax (8%)"),
                          Text(
                              '\$${(cart.totalPrice * 0.08).toStringAsFixed(2)}'),
                        ],
                      ),
                      const Divider(),
                      // Total
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
                            '\$${(cart.totalPrice + 2.99 + (cart.totalPrice * 0.08)).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: AppDimensions.fontLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppDimensions.marginMedium),
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
            if (_formKey.currentState!.validate()) {
              final cartState = context.read<CartBloc>().state as CartLoaded;
              final cart = cartState.cart;
              //Calculate total
              final subtotal = cart.totalPrice;
              final deliveryFee = 2.99;
              final tax = subtotal * 0.08;
              final total = subtotal + deliveryFee + tax;

              final order = OrderModel(
                name: _nameController.text,
                address: _addressController.text,
                phone: _phoneController.text,
                paymentMethod: _paymentMethod,
                //Cart item from the CartBloc state
                items: cart.items,
              );
              //Item: CartLoaded(CartModel(items: [CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 1, restaurantId: 1)], restaurantId: 1))
              //item.cart.items: [CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 1, restaurantId: 1)]
              // {name: q, address: q, phone: 2, paymentMethod: Cash on Delivary, items: [CarItemModel(id: 1, name: Pepperoni Pizza, price: 12.99, quantity: 1, restaurantId: 1)]}
              //* Show loading dialog
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );

              // Create the order
              sl<CreateOrder>().call(order);

              context.read<CartBloc>().add(ClearCartEvent());

              // Navigate to success page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderSuccessPage(),
                ),
                (route) => false,
              );
            }
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
          child: const Text(
            "Place order",
            style: TextStyle(
              fontSize: AppDimensions.fontLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
