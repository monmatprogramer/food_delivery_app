import 'package:flutter/material.dart';
import 'package:food_delivery_app/presentation/widgets/error_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food delivery app',
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ErrorDisplayWidget(
          message: "Error test",
          onRetry: () {
            debugPrint("Error is pressed");
          }),
    );
  }
}
