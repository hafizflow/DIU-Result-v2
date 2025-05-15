import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'dart:developer' as developer;

class ConnectivityHelper {
  static final Connectivity _connectivity = Connectivity();

  /// Checks if the device has network connectivity
  /// (Note: This doesn't guarantee internet access)
  static Future<bool> hasNetworkConnection() async {
    try {
      final List<ConnectivityResult> result =
          await _connectivity.checkConnectivity();
      return result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.vpn);
    } catch (e) {
      developer.log('Error checking connectivity: $e');
      return false;
    }
  }

  /// Checks if the device has actual internet access
  static Future<bool> hasRealInternetConnection() async {
    developer.log('Checking internet access by pinging google.com');
    try {
      final lookup = await InternetAddress.lookup('google.com');
      developer.log('Successfully reached google.com');
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      developer.log('Failed to reach google.com: $e');
      return false;
    }
  }
}
