import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),
      body: const SizedBox(
        height: 300,
        child: Placeholder(),
      ),
    );
  }
}
