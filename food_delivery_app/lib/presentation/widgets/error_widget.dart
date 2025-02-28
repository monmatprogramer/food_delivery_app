import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/contants/app_constants.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorDisplayWidget(
      {super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.marginLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 60,
            ),
            const SizedBox(
              height: AppDimensions.marginMedium,
            ),
            Text(
              AppConstants.errorTitle,
              style: const TextStyle(
                fontSize: AppDimensions.fontExtraLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: AppDimensions.marginLarge,
            ),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.marginSmall,
                  vertical: AppDimensions.marginSmall,
                ),
              ),
              child: const Text(AppConstants.retryText),
            )
          ],
        ),
      ),
    );
  }
}
