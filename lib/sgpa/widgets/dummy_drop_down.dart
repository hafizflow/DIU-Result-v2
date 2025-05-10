import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';

class DummyDropDown extends StatelessWidget {
  const DummyDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      iconStyleData: const IconStyleData(
        icon: Icon(Iconsax.refresh_circle_copy),
      ),
      items: const [],
      onChanged: (value) {},
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
  }
}
