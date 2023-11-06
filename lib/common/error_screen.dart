import 'package:chat_crow/constants/constants.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          error,
          style: defaultCustomTextStyle,
        ),
      ),
    );
  }
}
