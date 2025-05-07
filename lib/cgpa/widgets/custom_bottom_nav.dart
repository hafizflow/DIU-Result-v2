import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      backgroundColor: Colors.grey.withValues(alpha: 0.1),
      onTap: (index) => ref.read(bottomNavIndexProvider.notifier).state = index,
      selectedItemColor: ColorConstants.contentColorBlue,
      unselectedItemColor: ColorConstants.offWhite,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Iconsax.code_circle, size: 30),
          label: 'CGPA',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.code_circle_copy, size: 30),
          label: 'SGPA',
        ),
      ],
    );
  }
}
