import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:riverpod_practice/cgpa/logic/result_provider.dart';
import 'package:riverpod_practice/cgpa/screens/detail_result_screen.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_route.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_search_field.dart';
import 'package:riverpod_practice/cgpa/widgets/dev_info.dart';
import 'package:riverpod_practice/cgpa/widgets/gride_shimmer_effect.dart';
import 'package:riverpod_practice/cgpa/widgets/initial_animation.dart';
import 'package:riverpod_practice/cgpa/widgets/sgpa_card.dart';
import 'package:riverpod_practice/cgpa/widgets/student_info_card.dart';
import 'package:riverpod_practice/sgpa/widgets/error_message.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(resultListProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              const DevInfo(),
              Column(
                spacing: 16,
                children: [
                  Text(
                    'DIU Result CGPA',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const CustomSearchField(),
                  const StudentInfoCard(),
                  Expanded(
                    child: resultAsync.when(
                      data: (results) {
                        if (results.isEmpty) {
                          return const InitialAnimation(
                            animationPath: 'assets/a.json',
                          );
                        }
                        return AnimationLimiter(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  mainAxisExtent: 140,
                                ),
                            itemBuilder: (context, index) {
                              final semesterResults = results[index];
                              final first = semesterResults.first;
                              final semesterNameYear =
                                  '${first.semesterName} ${first.semesterYear}';

                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap:
                                          () => Navigator.push(
                                            context,
                                            CustomRoute(
                                              page: DetailsResultScreen(
                                                result: semesterResults,
                                                semesterNameYear:
                                                    semesterNameYear,
                                              ),
                                            ),
                                          ),
                                      child: SgpaCard(first: first),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => const GridShimmerEffect(),
                      error: (e, st) => ErrorMessage(errorMessage: e),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
