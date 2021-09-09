import 'package:flutter/material.dart';

class ErrorMessageDisplay extends StatelessWidget {
  const ErrorMessageDisplay({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
