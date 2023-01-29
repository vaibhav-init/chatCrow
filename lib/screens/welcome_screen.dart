import 'package:chat_crow/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_crow/Components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = '/welcome';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(controller?.value ?? 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 100.0,
                    child: Image.network(
                        'https://img.freepik.com/free-icon/crow_318-880607.jpg?w=2000'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'ChatCrow',
                      textStyle: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 10,
                  pause: const Duration(milliseconds: 200),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.teal,
                function: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                textToUse: 'Login'),
            RoundedButton(
                color: Colors.tealAccent,
                function: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                textToUse: 'Register'),
          ],
        ),
      ),
    );
  }
}
