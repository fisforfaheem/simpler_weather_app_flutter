import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$errorMessage City Not Found',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
