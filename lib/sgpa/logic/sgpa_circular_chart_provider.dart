import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';

final sgpaCircularChartProvider = Provider<CircularChartModel>((ref) {
  final result = ref.watch(sgpaResultListProvider).asData?.value;

  if (result == null || result.isEmpty) {
    return CircularChartModel(percentage: 0, cgpa: 0);
  }

  final cgpa = result.first.cgpa;
  final percentage = (cgpa / 4) * 100;

  return CircularChartModel(percentage: percentage, cgpa: cgpa);
});

class CircularChartModel {
  final double percentage;
  final double cgpa;

  CircularChartModel({required this.percentage, required this.cgpa});
}
