// ignore_for_file: library_private_types_in_public_api

import 'package:chat_crow/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_crow/common/widgets/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  static const route = '/login';
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
        elevation: 3,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Enter Your Phone Number',
          style: defaultTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Hero(
              tag: 'button',
              child: RoundedButton(
                function: () {},
                textToUse: 'LogIn',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
