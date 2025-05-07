import 'package:flutter/material.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/data/models/result_model.dart';

class SgpaCard extends StatelessWidget {
  const SgpaCard({super.key, required this.first});

  final Result first;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.offDark,
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              first.cgpa.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '${first.semesterName} ${first.semesterYear}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
