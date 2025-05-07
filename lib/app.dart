import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/screens/result_screen.dart';
import 'package:riverpod_practice/cgpa/widgets/background.dart';
import 'package:riverpod_practice/cgpa/widgets/custom_bottom_nav.dart';
import 'package:riverpod_practice/sgpa/sgpa_page.dart';

class AppScreen extends ConsumerWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    const screens = [ResultScreen(), SgpaPage()];

    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(index: selectedIndex, children: screens),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}
