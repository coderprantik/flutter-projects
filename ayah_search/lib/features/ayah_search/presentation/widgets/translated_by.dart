import 'package:flutter/material.dart';

class TranslatedBy extends StatelessWidget {
  const TranslatedBy({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 12.0),
        children: [
          TextSpan(
            text: 'Translated by ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
