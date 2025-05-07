import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SemesterCodeField extends ConsumerStatefulWidget {
  const SemesterCodeField({super.key});

  @override
  ConsumerState<SemesterCodeField> createState() => _SemesterCodeFieldState();
}

class _SemesterCodeFieldState extends ConsumerState<SemesterCodeField> {
  final semester = TextEditingController();
  static const String semesterCodeKey = 'semester_code';

  @override
  void initState() {
    super.initState();
    loadCode();
  }

  Future<void> loadCode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(semesterCodeKey) ?? '251';
    semester.text = savedCode;
    ref.read(semesterCodeProvider.notifier).state = savedCode;
  }

  Future<void> saveCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(semesterCodeKey, code);
  }

  @override
  void dispose() {
    super.dispose();
    semester.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            backgroundColor: ColorConstants.offDark,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add Semester Code',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: semester,
                        onChanged: (value) => saveCode(value),
                        maxLength: 4,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        cursorColor: ColorConstants.contentColorBlue,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                          ref.read(semesterCodeProvider.notifier).state = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.code_1_copy,
                            color: Colors.blue[800],
                            size: 24,
                          ),
                          label: const Text(
                            'Semester Code (Example: 243, 251, 252)',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          hintText: "Semester Code (e.g. 252, 251)",
                          filled: true,
                          fillColor: Colors.black26,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorConstants.contentColorBlue,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: const Center(child: Text('Cancel')),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                ref.read(semesterCodeProvider.notifier).state =
                                    semester.text.trim();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: const Center(child: Text('Save')),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Iconsax.code_1_copy, color: Colors.white),
      ),
    );
  }
}
