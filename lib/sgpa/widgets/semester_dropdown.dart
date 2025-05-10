import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/sgpa/logic/semester_list_provider.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';
import 'package:riverpod_practice/sgpa/widgets/dummy_drop_down.dart';

class SemesterDropDown extends ConsumerWidget {
  const SemesterDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semesterList = ref.watch(semesterLists);

    return semesterList.when(
      data: (semester) {
        if (semester == null || semester.isEmpty) {
          return const DummyDropDown();
        }
        return DropdownButtonFormField2<String>(
          iconStyleData: const IconStyleData(
            icon: Icon(Iconsax.arrow_down),
            iconSize: 24,
            iconEnabledColor: Colors.grey,
          ),
          items:
              semester.map((value) {
                return DropdownMenuItem<String>(
                  value: "${value.semesterName} ${value.semesterYear}",
                  child: Text(
                    "${value.semesterName} ${value.semesterYear}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorConstants.offWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      // letterSpacing: 1,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              ref.read(semesterCodeProvider.notifier).state =
                  semester
                      .firstWhere(
                        (element) =>
                            "${element.semesterName} ${element.semesterYear}" ==
                            value,
                      )
                      .semesterId;
            }
          },
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            labelText: 'Select Semester',
            labelStyle: TextStyle(
              color: ColorConstants.offWhite,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade900,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.only(left: 16),
          ),
        );
      },
      error: (_, __) {
        return const DummyDropDown();
      },
      loading: () {
        return const DummyDropDown();
      },
    );
  }
}
