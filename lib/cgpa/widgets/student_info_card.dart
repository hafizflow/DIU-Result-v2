import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/logic/student_info_provider.dart';
import 'package:riverpod_practice/cgpa/screens/cgpa_screen.dart';
import 'package:riverpod_practice/cgpa/widgets/circular_chart.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_route.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_snackbar.dart';
import 'package:riverpod_practice/cgpa/widgets/student_info_shimmer_card.dart';
import 'package:riverpod_practice/cgpa/widgets/student_info_text.dart';
import 'package:shimmer/shimmer.dart';

class StudentInfoCard extends ConsumerWidget {
  const StudentInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentInfoAsync = ref.watch(studentInfoProvider);
    final hasSearched = ref.watch(hasSearchedProvider);

    return studentInfoAsync.when(
      data: (info) {
        if (info == null && hasSearched) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                customSnackBar(
                  title: 'Wrong ID!',
                  message: 'Please insert valid Student-ID',
                  contentType: ContentType.help,
                ),
              );
          });
          return const SizedBox.shrink();
        }

        if (info == null || info.studentName.trim().isEmpty) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                CustomRoute(page: const CgpaScreen()),
              ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade300, width: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: ColorConstants.offDark,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student Info',
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .4,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: PersonalInfoText(
                                    label: '',
                                    data: info.studentName,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              PersonalInfoText(
                                label: 'Batch',
                                data: info.batchNo.toString(),
                              ),
                              const SizedBox(height: 2),
                              PersonalInfoText(
                                label: 'Major',
                                data: info.progShortName,
                              ),
                            ],
                          ),
                        ),
                        const Flexible(
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularChart(
                              width: 15,
                              fontSize: 14,
                              thickness: 15,
                              radiusFactor: 1,
                              cgFontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white.withValues(alpha: 0.3),
                    period: const Duration(seconds: 5),
                    direction: ShimmerDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const StudentInfoShimmerCard(),
      error: (error, _) => const SizedBox.shrink(),
    );
  }
}
