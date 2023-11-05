import 'package:chat_crow/constants/constants.dart';
import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: defaultCustomTextStyle,
      ),
    ),
  );
}
