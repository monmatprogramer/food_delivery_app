import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/contants/theme_constants.dart';
import 'package:food_delivery_app/domain/entities/restaurant_entity.dart';
import 'package:hive/hive.dart';

class RestaurantListCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  final VoidCallback onTap;
  const RestaurantListCard(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.marginMedium,
        vertical: AppDimensions.marginSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.marginMedium),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusSmall),
                child: restaurant.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: restaurant.imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    // Container(
                    //     width: 80,
                    //     height: 80,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         image: NetworkImage(restaurant.imageUrl!, scale: 1),
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.restaurant,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(
                width: AppDimensions.marginMedium,
              ),
              Expanded(
                  child: Column(
                children: [
                  // Restaurant nme
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: AppDimensions.marginSmall / 2,
                  ),
                  //Restaurant rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(
                          fontSize: AppDimensions.fontMedium,
                        ),
                      ),
                      const SizedBox(
                        width: AppDimensions.marginSmall,
                      ),
                      Text(
                        ". ${restaurant.deliveryTime}",
                        style: const TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppDimensions.marginSmall,
                  ),
                  //Restaurant tags
                  Wrap(
                    spacing: AppDimensions.marginSmall,
                    children: restaurant.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.marginSmall,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              AppColors.secondaryLight.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusSmall,
                          ),
                        ),
                        child: Text(
                          tag.name,
                          style: const TextStyle(
                            fontSize: AppDimensions.fontSmall,
                            color: AppColors.secondary,
                          ),
                        ),
                      );
                    }).toList(),
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
