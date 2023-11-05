import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  static const String route = '/otp-view';
  final String verificationId;
  const OtpView({
    super.key,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
