import 'package:flutter/material.dart';

// Error message Widget
class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorMessageWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
