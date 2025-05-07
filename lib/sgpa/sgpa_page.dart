import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:riverpod_practice/cgpa/data/models/result_model.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/core%20/constants/grade_color.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';
import 'package:riverpod_practice/sgpa/widgets/error_message.dart';
import 'package:riverpod_practice/sgpa/widgets/semester_code_field.dart';
import 'package:riverpod_practice/sgpa/widgets/sgpa_search_field.dart';
import 'package:riverpod_practice/sgpa/widgets/sgpa_student_info_card.dart';

class SgpaPage extends ConsumerWidget {
  const SgpaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(sgpaResultListProvider);

    final semesterName = resultAsync.when(
      data: (results) {
        if (results.isNotEmpty) {
          return '${results[0].semesterName} ${results[0].semesterYear}';
        }
        return '';
      },
      error: (e, st) => '',
      loading: () => '',
    );

    return Scaffold(
      floatingActionButton: const SemesterCodeField(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            spacing: 16,
            children: [
              Text(
                'DIU Result SGPA',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SgpaSearchField(),
              const SgpaStudentInfoCard(),
              if (semesterName != '' || semesterName.isNotEmpty)
                Text(
                  semesterName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              resultList(resultAsync),
            ],
          ),
        ),
      ),
    );
  }

  Expanded resultList(AsyncValue<List<Result>> resultAsync) {
    return Expanded(
      child: resultAsync.when(
        data: (results) {
          if (results.isEmpty) {
            return const Center(child: Text('No Result Found'));
          }

          return AnimationLimiter(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 700),
                  child: SlideAnimation(
                    verticalOffset: 40.0,
                    child: FadeInAnimation(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorConstants.offDark,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade800),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .65,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      results[index].courseTitle.toString(),
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
                                      results[index].totalCredit
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
                                      results[index].gradeLetter.toString(),
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
                              backgroundColor: getColorForPointEquivalent(
                                results[index].pointEquivalent,
                              ),
                              child: Text(
                                results[index].pointEquivalent.toString(),
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
          );
        },
        error: (e, st) => ErrorMessage(errorMessage: e),
        loading:
            () => const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.contentColorCyan,
              ),
            ),
      ),
    );
  }
}
