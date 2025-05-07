import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_circular_chart_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SgpaCircularChart extends ConsumerWidget {
  const SgpaCircularChart({
    this.cgFontSize = 42,
    this.width = 50,
    this.radiusFactor = 0.8,
    this.thickness = 50,
    this.fontSize = 20,
    super.key,
  });

  final double radiusFactor;
  final double thickness;
  final double fontSize;
  final double width;
  final double cgFontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(sgpaCircularChartProvider);
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: [
        RadialAxis(
          radiusFactor: radiusFactor,
          pointers: [
            RangePointer(
              value: controller.percentage,
              width: width,
              cornerStyle: CornerStyle.bothCurve,
              gradient: const SweepGradient(
                colors: [
                  ColorConstants.contentColorYellow,
                  ColorConstants.contentColorOrange,
                ],
              ),
            ),
          ],
          axisLineStyle: AxisLineStyle(
            thickness: thickness,
            color: Colors.white.withValues(alpha: .3),
          ),
          startAngle: 1,
          endAngle: 1,
          showLabels: false,
          showTicks: false,
          annotations: [
            GaugeAnnotation(
              widget: Text(
                'SGPA',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              angle: 270,
              positionFactor: 0.18,
            ),
            GaugeAnnotation(
              widget: Text(
                controller.cgpa.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: cgFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              angle: 270,
              verticalAlignment: GaugeAlignment.near,
              positionFactor: 0.08,
            ),
          ],
        ),
      ],
    );
  }
}
