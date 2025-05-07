import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/logic/total_result_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AcademicBarChart extends ConsumerStatefulWidget {
  const AcademicBarChart({super.key});

  @override
  ConsumerState<AcademicBarChart> createState() => _AcademicBarChartState();
}

class _AcademicBarChartState extends ConsumerState<AcademicBarChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalResult = ref.watch(totalResultProvider);
    final gpaData = totalResult.semesterSgpaData;

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Semester-wise SGPA'),
        tooltipBehavior: _tooltip,
        primaryXAxis: const CategoryAxis(
          labelRotation: -90,
          labelStyle: TextStyle(
            color: Colors.black,
            height: 1.1,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 2,
          maximum: 4.0,
          interval: 0.25,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          ColumnSeries<dynamic, dynamic>(
            dataSource: gpaData,
            xValueMapper:
                (dynamic data, _) => data.semester.replaceAll(' ', '\n'),
            yValueMapper: (dynamic data, _) => data.gpa,
            pointColorMapper: (dynamic data, _) {
              final gpa = data.gpa;

              if (gpa >= 3.9) {
                return Colors.green[900];
              } else if (gpa >= 3.8) {
                return Colors.green[800];
              } else if (gpa >= 3.7) {
                return Colors.lightGreen[800];
              } else if (gpa >= 3.5) {
                return Colors.lime[800];
              } else if (gpa >= 3.25) {
                return Colors.amber[800];
              } else if (gpa >= 3.0) {
                return Colors.orange[800];
              } else if (gpa >= 2.75) {
                return Colors.deepOrange[800];
              } else if (gpa >= 2.5) {
                return Colors.red[800];
              } else {
                return Colors.red[800];
              }
            },

            color: ColorConstants.contentColorBlue,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            // dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
