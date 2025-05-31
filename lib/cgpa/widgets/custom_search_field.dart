import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/cgpa/widgets/safe_on_tap.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:riverpod_practice/cgpa/logic/result_provider.dart';
import 'package:riverpod_practice/cgpa/logic/student_info_provider.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_snackbar.dart';

class CustomSearchField extends ConsumerStatefulWidget {
  const CustomSearchField({super.key});

  @override
  ConsumerState<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends ConsumerState<CustomSearchField> {
  final studentIdController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Create local focus node

  @override
  void dispose() {
    studentIdController.dispose();
    _focusNode.dispose(); // Dispose the focus node
    super.dispose();
  }

  void searchResult() async {
    // First check internet connection
    final hasInternet = await SafeOnTap.hasInternetWithFeedback(
      context: context,
      showSnackbar: true,
    );

    // Exit immediately if no internet
    if (!hasInternet) return;

    // Only proceed with the rest if we have internet
    ref.read(studentIdProvider.notifier).state = '';
    _focusNode.unfocus();
    final studentId = studentIdController.text.trim();
    ref.invalidate(resultListProvider);

    if (studentId.isEmpty) {
      ref.read(studentIdProvider.notifier).state = '';
      ref.read(hasSearchedProvider.notifier).state = false;

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
      ref.read(hasSearchedProvider.notifier).state = true;
      ref.read(studentIdProvider.notifier).state = studentId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: studentIdController,
      maxLength: 20,
      onTapOutside: (_) => _focusNode.unfocus(),
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
      onTap: () => _focusNode.requestFocus(),
      onFieldSubmitted: (_) => searchResult(),
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
