// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_crow/common/widgets/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SvgPicture.asset(
                      'assets/svgs/logo.svg',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'ChatCrow',
                        textStyle: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Ubuntu',
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 15,
                    isRepeatingAnimation: true,
                    pause: const Duration(milliseconds: 200),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RoundedButton(
                  function: () {},
                  textToUse: "Let's Go",
                ),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
