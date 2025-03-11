import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/data/models/cart_item_model.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_state.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
          print("🆗state.cart: ${state.cart}");
          final cart = state.cart;
          return Form(
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
                  //TODO: add controller
                  decoration: const InputDecoration(
                    labelText: "Full name",
                    border: OutlineInputBorder(),
                  ),
                  //TODO: Add validator
                  validator: (value) {},
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                TextFormField(
                  //TODO: Add a controller
                  decoration: const InputDecoration(
                    labelText: "Delivary Address",
                    border: OutlineInputBorder(),
                  ),
                  //TODO: Add validator
                ),
                const SizedBox(
                  height: AppDimensions.marginMedium,
                ),
                TextFormField(
                  //TODO: Add a controller
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),

                  //TODO: Add a validator
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
                    //TODO: Add group value
                    groupValue: "Option1",
                    //TODO: Add onChange method
                    onChanged: (value) {},
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
                    //TODO: Add group value
                    groupValue: "Options1",
                    //TODO: Add this method
                    onChanged: (value) {},
                  ),
                ),
                Card(
                  child: RadioListTile(
                    value: "Digital Wallet",
                    //TODO: Add group value
                    groupValue: "Options1",
                    //TODO: Add this method
                    onChanged: (value) {},
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
                      //TODO: Item 
                      ...cart.items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Text("${item.name} x${item.quantity}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
