import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/presentation/pages/home_page.dart';

class OrderSuccessPage extends StatelessWidget {
  final int? orderId;
  const OrderSuccessPage({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.marginLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.secondary,
                size: 100,
              ),
              const SizedBox(
                height: AppDimensions.marginLarge,
              ),
              const Text(
                "Order Placed Successful!",
                style: TextStyle(
                  fontSize: AppDimensions.fontTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppDimensions.marginMedium,
              ),
              if (orderId != null)
                Text(
                  'Order #$orderId',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontLarge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(
                height: AppDimensions.marginMedium,
              ),
              const Text(
                'Your order has been placed successfully. You will receive a confirmation shortly',
                style: TextStyle(
                  fontSize: AppDimensions.fontMedium,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppDimensions.marginLarge * 2,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.marginMedium,
                      horizontal: AppDimensions.marginLarge),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                ),
                child: const Text("Return to Home"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
