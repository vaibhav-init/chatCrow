import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;

  final String textToUse;
  final Function function;
  const RoundedButton({
    super.key,
    required this.color,
    required this.function,
    required this.textToUse,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            //Go to registration screen.
            function();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            textToUse,
          ),
        ),
      ),
    );
  }
}
