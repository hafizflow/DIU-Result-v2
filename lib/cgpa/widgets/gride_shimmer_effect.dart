import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmerEffect extends StatelessWidget {
  const GridShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 140,
      ),
      itemBuilder: (_, index) {
        return Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          period: const Duration(seconds: 5),
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade500,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .25),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade50, width: 0.5),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 80,
                    height: 18,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 120,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
