import 'package:flutter/material.dart';
import 'package:chat_crow/common/widgets/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.network(
                      'https://img.freepik.com/free-icon/crow_318-880607.jpg?w=2000'),
                ),
              ),
            ),
            RoundedButton(
              function: () {},
              textToUse: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
