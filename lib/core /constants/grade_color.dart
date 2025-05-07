import 'package:flutter/material.dart';

Color getColorForPointEquivalent(double pointEquivalent) {
  switch (pointEquivalent) {
    case 4.0:
      return Colors.green.shade900;
    case 3.75:
      return Colors.teal.shade800;
    case 3.5:
      return Colors.teal.shade600;
    case 3.25:
      return Colors.teal.shade400;
    case 3.0:
      return Colors.blue.shade700;
    case 2.75:
      return Colors.yellow.shade900;
    case 2.5:
      return Colors.orange.shade900;
    case 2.25:
      return Colors.orange;
    case 2.0:
      return Colors.red;
    case 0.0:
      return Colors.red.shade900;
    default:
      return Colors.grey; // Default color if no match is found
  }
}
