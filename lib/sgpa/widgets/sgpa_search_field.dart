import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/cgpa/widgets/safe_on_tap.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_snackbar.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_student_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SgpaSearchField extends ConsumerStatefulWidget {
  const SgpaSearchField({super.key});

  @override
  ConsumerState<SgpaSearchField> createState() => _SgpaSearchFieldState();
}

class _SgpaSearchFieldState extends ConsumerState<SgpaSearchField> {
  final sId = TextEditingController();
  static const String studentIDKey = 'student_id';

  Future<void> saveID(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(studentIDKey, id);
  }

  Future<void> loadID() async {
    final prefs = await SharedPreferences.getInstance();
    final savedID = prefs.getString(studentIDKey) ?? '';
    sId.text = savedID;
    ref.read(sIdProvider.notifier).state = savedID;
  }

  @override
  void initState() {
    loadID();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    sId.dispose();
  }

  void searchResult() async {
    // First check internet connection
    final hasInternet = await SafeOnTap.hasInternetWithFeedback(
      context: context,
      showSnackbar: true,
    );

    // Exit immediately if no internet
    if (!hasInternet) return;

    ref.read(sIdProvider.notifier).state = '';
    FocusScope.of(context).unfocus();
    final studentId = sId.text.trim();
    ref.invalidate(sgpaStudentInfoProvider);
    if (studentId.isEmpty) {
      ref.read(sIdProvider.notifier).state = '';
      ref.read(isSearchedProvider.notifier).state = false;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          customSnackBar(
            title: 'On Snap!',
            message: 'Please insert Student-ID',
            contentType: ContentType.warning,
          ),
        );
    } else {
      ref.read(isSearchedProvider.notifier).state = true;
      ref.read(sIdProvider.notifier).state = studentId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: sId,
      maxLength: 20,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: (value) => saveID(value),
      style: const TextStyle(
        color: ColorConstants.offWhite,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ID';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        searchResult();
        saveID(value);
      },
      decoration: InputDecoration(
        hintText: 'Enter Your ID',
        hintStyle: const TextStyle(color: Colors.grey),
        counterText: '',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () => searchResult(),
            icon: const Icon(
              Iconsax.search_normal_copy,
              size: 24,
              color: ColorConstants.offWhite,
            ),
          ),
        ),
      ),
      cursorColor: Colors.white,
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.search,
    );
  }
}
