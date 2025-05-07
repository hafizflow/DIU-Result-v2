import 'package:flutter/material.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/widgets/academic_info_card.dart';
import 'package:riverpod_practice/cgpa/widgets/background.dart';
import 'package:riverpod_practice/cgpa/widgets/circular_chart.dart';

class CgpaScreen extends StatelessWidget {
  const CgpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(color: ColorConstants.offWhite),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      children: [
                        CircularChart(),
                        AcademicInfoCard(),
                        // LineChartSample2(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
