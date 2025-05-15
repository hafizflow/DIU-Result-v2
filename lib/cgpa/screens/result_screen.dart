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
import 'package:riverpod_practice/cgpa/widgets/page_title.dart';
import 'package:riverpod_practice/cgpa/widgets/sgpa_card.dart';
import 'package:riverpod_practice/cgpa/widgets/student_info_card.dart';
import 'package:riverpod_practice/sgpa/widgets/error_message.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.refresh(resultListProvider.future).then((_) {}).catchError((error) {
        debugPrint('Error refreshing data: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultAsync = ref.watch(resultListProvider);

    return Scaffold(
      key: const ValueKey('resultScreen'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              const DevInfo(),
              Column(
                children: [
                  const PageTitle(title: 'DIU Result CGPA'),
                  const SizedBox(height: 16),
                  const CustomSearchField(),
                  const SizedBox(height: 16),
                  const StudentInfoCard(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: resultAsync.when(
                      data: (results) {
                        if (results.isEmpty) {
                          return resultAsync.isLoading
                              ? const GridShimmerEffect()
                              : const InitialAnimation();
                        }
                        return AnimationLimiter(
                          child: GridView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CustomRoute(
                                            page: DetailsResultScreen(
                                              result: semesterResults,
                                              semesterNameYear:
                                                  semesterNameYear,
                                            ),
                                          ),
                                        );
                                      },
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
