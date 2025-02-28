import 'package:flutter/material.dart';
import 'package:food_delivery_app/domain/entities/category_entity.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:food_delivery_app/domain/entities/tag_entity.dart';
import 'package:food_delivery_app/presentation/widgets/error_widget.dart';
import 'package:food_delivery_app/presentation/widgets/loading_widget.dart';
import 'package:food_delivery_app/presentation/widgets/restaurant_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food delivery app',
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: RestaurantListCard(
            restaurant: RestaurantEntity(
                id: 1,
                name: "Food name",
                imageUrl: "",
                rating: 1.2,
                deliveryTime: "12:00AM",
                category:
                    CategoryEntity(id: 1, name: "Category name", icon: ""),
                tags: [
                  TagEntity(id: 1, name: "Tage name1"),
                  TagEntity(id: 2, name: "Tage name2"),
                  TagEntity(id: 3, name: "Tage name3"),
                  TagEntity(id: 4, name: "Tage name4"),
                  TagEntity(id: 5, name: "Tage name5"),
                ]),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
