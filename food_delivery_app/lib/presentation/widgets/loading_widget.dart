import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[300]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(AppDimensions.marginMedium),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.white,
              ),
              const SizedBox(
                width: AppDimensions.marginMedium,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: AppDimensions.marginSmall,
                  ),
                  Container(
                    width: 100,
                    height: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: AppDimensions.marginSmall,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 15,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
