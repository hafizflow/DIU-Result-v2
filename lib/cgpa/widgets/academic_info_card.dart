import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/widgets/animated_academicinfo.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/logic/result_provider.dart';
import 'package:riverpod_practice/cgpa/logic/total_result_provider.dart';
import 'package:riverpod_practice/cgpa/widgets/academic_bar_chart.dart';

class AcademicInfoCard extends ConsumerWidget {
  const AcademicInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(totalResultProvider);
    final allResult = ref.watch(resultListProvider).asData?.value ?? [];
    final totalResult = ref.watch(totalResultProvider);

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.offDark,
          border: Border.all(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedAcademicInfo(
                cgpa: totalResult.cgpa,
                totalCredits: controller.totalCredits,
                semesterCount: allResult.length,
                yearCount: (allResult.length / 2).floor(),
              ),
              const SizedBox(height: 24),
              const AcademicBarChart(), // Ensure the BarChart widget is defined and imported correctly
            ],
          ),
        ),
      ),
    );
  }
}
