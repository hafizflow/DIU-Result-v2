import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/core%20/constants/wish_messages.dart';
import 'package:riverpod_practice/cgpa/logic/result_provider.dart';
import 'package:riverpod_practice/cgpa/logic/total_result_provider.dart';
import 'package:riverpod_practice/cgpa/widgets/academic_bar_chart.dart';
import 'package:riverpod_practice/cgpa/widgets/student_info_text.dart';

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
              Text(
                'Academic Information',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PersonalInfoText(
                        label: 'Year ',
                        data: (allResult.length / 2)
                            .floorToDouble()
                            .toStringAsFixed(0),
                      ),
                      const SizedBox(height: 2),
                      PersonalInfoText(
                        label: 'Credit ',
                        data: controller.totalCredits.toStringAsFixed(0),
                      ),
                      const SizedBox(height: 2),
                      PersonalInfoText(
                        label: 'Semester ',
                        data: allResult.length.toString(),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        WishMessages.motivationalMessage(totalResult.cgpa),
                      ),
                    ),
                  ),
                ],
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
