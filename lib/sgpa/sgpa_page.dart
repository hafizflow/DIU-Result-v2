import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:riverpod_practice/cgpa/widgets/page_title.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/core%20/constants/grade_color.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_model.dart';
import 'package:riverpod_practice/sgpa/widgets/error_message.dart';
import 'package:riverpod_practice/sgpa/widgets/semester_dropdown.dart';
import 'package:riverpod_practice/sgpa/widgets/sgpa_search_field.dart';
import 'package:riverpod_practice/sgpa/widgets/sgpa_student_info_card.dart';

class SgpaPage extends ConsumerStatefulWidget {
  const SgpaPage({super.key});

  @override
  ConsumerState<SgpaPage> createState() => _SgpaPageState();
}

class _SgpaPageState extends ConsumerState<SgpaPage>
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
      ref.refresh(sgpaResultListProvider.future).then((_) {}).catchError((
        error,
      ) {
        debugPrint('Error refreshing data: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultAsync = ref.watch(sgpaResultListProvider);

    return Scaffold(
      key: const ValueKey('sgpaScreen'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            spacing: 16,
            children: [
              const PageTitle(title: 'DIU Result SGPA'),
              const SemesterDropDown(),
              const SgpaSearchField(),
              const SgpaStudentInfoCard(),
              _buildResultList(resultAsync),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildResultList(AsyncValue<List<SgpaResult>> resultAsync) {
    return Expanded(
      child: resultAsync.when(
        data: (results) {
          if (results.isEmpty) {
            return const Center(child: Text('No Result Found'));
          }

          return AnimationLimiter(
            child: ListView.separated(
              controller: _scrollController,
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
            () => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                size: 50,
                color: ColorConstants.contentColorCyan,
              ),
            ),
      ),
    );
  }
}
