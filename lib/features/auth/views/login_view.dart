// ignore_for_file: library_private_types_in_public_api

import 'package:chat_crow/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_crow/common/widgets/rounded_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Your Phone Number',
          style: defaultTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 10,
                ),
              ),
            ),
            RoundedButton(
              function: () {},
              textToUse: 'LogIn',
            ),
          ],
        ),
      ),
    );
  }
}
