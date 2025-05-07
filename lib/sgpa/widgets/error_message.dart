import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.errorMessage});

  final Object errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '${errorMessage.toString()} !!!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
