import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_snackbar.dart';
import 'package:riverpod_practice/core%20/services/connectivity_helper.dart';

class SafeOnTap {
  static Future<bool> hasInternetWithFeedback({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (!context.mounted) return false;

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final hasConnection =
          await ConnectivityHelper.hasRealInternetConnection();

      if (!hasConnection && showSnackbar && context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            customSnackBar(
              title: 'Connectivity Failed!',
              message: 'Please check your internet connection',
              contentType: ContentType.failure,
            ),
          );
      }
      return hasConnection;
    } catch (e) {
      if (showSnackbar && context.mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Connection check failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
  }
}
