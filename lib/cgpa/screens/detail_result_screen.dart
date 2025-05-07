import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/data/models/result_model.dart';
import 'package:riverpod_practice/cgpa/widgets/background.dart';
import 'package:riverpod_practice/core%20/constants/grade_color.dart';

class DetailsResultScreen extends StatelessWidget {
  const DetailsResultScreen({
    super.key,
    required this.result,
    required this.semesterNameYear,
  });

  final List<Result> result;
  final String semesterNameYear;

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(color: ColorConstants.offWhite),
                ),
                Text(
                  semesterNameYear,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),

                // ...
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: ColorConstants.offDark,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                              .65,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              result[index].courseTitle
                                                  .toString(),
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.titleMedium,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(
                                              'Credit : ',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                            ),
                                            Text(
                                              result[index].totalCredit
                                                  .toInt()
                                                  .toString(),
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Text(
                                              'Grade : ',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                            ),
                                            Text(
                                              result[index].gradeLetter
                                                  .toString(),
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          getColorForPointEquivalent(
                                            result[index].pointEquivalent,
                                          ),
                                      child: Text(
                                        result[index].pointEquivalent
                                            .toString(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                    ),
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
