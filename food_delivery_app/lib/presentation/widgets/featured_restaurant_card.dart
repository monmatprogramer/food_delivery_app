import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';

class FeaturedRestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  final VoidCallback onTap;
  const FeaturedRestaurantCard(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    debugPrint("👉👉👉 Restaurant: $restaurant");
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.marginSmall),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimensions.borderRadiusMedium),
                ),
                child: restaurant.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: restaurant.imageUrl!,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 120,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 120,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.restaurant,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    // Container(
                    //     height: 120,
                    //     width: double.infinity,
                    //     color: Colors.grey[300],
                    //   )
                    : Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.restaurant,
                          color: Colors.grey,
                        ),
                      ),
              ),
              // Restaurant details
              Padding(
                padding: const EdgeInsets.all(AppDimensions.marginSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant name
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.fontMedium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: AppDimensions.marginSmall / 2,
                    ),
                    // Restaurant rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            fontSize: AppDimensions.fontSmall,
                          ),
                        ),
                        const SizedBox(
                          width: AppDimensions.marginSmall / 2,
                        ),
                        // Dilvery time
                        Text(
                          restaurant.deliveryTime,
                          style: const TextStyle(
                              fontSize: AppDimensions.fontSmall,
                              color: AppColors.textSecondary),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
