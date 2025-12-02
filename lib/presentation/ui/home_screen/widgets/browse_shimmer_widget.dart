import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/colors/app_color.dart';

class BrowseShimmerWidget extends StatelessWidget {
  const BrowseShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.offWhite.withOpacity(0.3),
      highlightColor: AppColor.offWhite.withOpacity(0.1),
      child: Column(
        children: [
          // Genre chips shimmer
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) {
                return Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColor.goldenYellow,
                      width: 2,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Movies grid shimmer
          Expanded(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .62,
              ),
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

