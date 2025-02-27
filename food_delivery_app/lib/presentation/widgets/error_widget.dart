import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorDisplayWidget(
      {super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(AppDimensions.marginLarge)),
    );
  }
}
