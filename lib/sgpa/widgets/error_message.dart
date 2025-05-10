import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.errorMessage,
    this.onTap,
    this.isVisible = false,
  });

  final Object errorMessage;
  final void Function()? onTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5, red: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${errorMessage.toString()} !!!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade300),
            ),
            if (isVisible)
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
