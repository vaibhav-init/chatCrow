import 'package:chat_crow/constants/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String textToUse;
  final VoidCallback function;
  const RoundedButton({
    super.key,
    required this.function,
    required this.textToUse,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        textToUse,
        style: defaultTextStyle.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
