import 'package:flutter/material.dart';
import 'package:riverpod_practice/cgpa/widgets/student_info_text.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/core%20/constants/wish_messages.dart';

class AnimatedAcademicInfo extends StatelessWidget {
  final double cgpa;
  final double totalCredits;
  final int semesterCount;
  final int yearCount;

  const AnimatedAcademicInfo({
    super.key,
    required this.cgpa,
    required this.totalCredits,
    required this.semesterCount,
    required this.yearCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ColorConstants.offDark),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animate Academic Information text from left
          TweenAnimationBuilder<Offset>(
            tween: Tween(begin: const Offset(-1, 0), end: Offset.zero),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOut,
            builder: (context, offset, child) {
              return Transform.translate(offset: offset * 20, child: child);
            },
            child: Text(
              'Academic Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Animate Personal Info Texts from left
              TweenAnimationBuilder<Offset>(
                tween: Tween(begin: const Offset(-1, 0), end: Offset.zero),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOut,
                builder: (context, offset, child) {
                  return Transform.translate(offset: offset * 20, child: child);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PersonalInfoText(
                      label: 'Year ',
                      data: yearCount.toString(),
                    ),
                    const SizedBox(height: 2),
                    PersonalInfoText(
                      label: 'Credit ',
                      data: totalCredits.toStringAsFixed(0),
                    ),
                    const SizedBox(height: 2),
                    PersonalInfoText(
                      label: 'Semester ',
                      data: semesterCount.toString(),
                    ),
                  ],
                ),
              ),

              // Animate the motivational container from right
              TweenAnimationBuilder<Offset>(
                tween: Tween(begin: const Offset(1, 0), end: Offset.zero),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOut,
                builder: (context, offset, child) {
                  return Transform.translate(offset: offset * 20, child: child);
                },
                child: Container(
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
                    child: Text(WishMessages.motivationalMessage(cgpa)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
