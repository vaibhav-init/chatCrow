import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/auth/views/login_view.dart';
import 'package:chat_crow/features/auth/views/otp_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.route:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case OtpView.route:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpView(
                verificationId: verificationId,
              ));

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                    child: Text(
                  'Error Screen ',
                  style: defaultCustomTextStyle,
                )),
              ));
  }
}
