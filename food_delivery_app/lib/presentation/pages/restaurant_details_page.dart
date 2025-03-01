import 'package:flutter/material.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final RestaurantEntity restaurant;
  const RestaurantDetailsPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Restaurant Details Page",
        ),
      ),
    );
  }
}
