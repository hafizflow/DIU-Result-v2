import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StudentInfoShimmerCard extends StatelessWidget {
  const StudentInfoShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade500,
      period: const Duration(seconds: 5),
      direction: ShimmerDirection.rtl,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 145,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade50, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.white.withValues(alpha: 0.01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  height: 18,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  height: 12,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 12,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 12,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
