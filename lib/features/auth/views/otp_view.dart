import 'package:chat_crow/constants/constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        elevation: 3,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Waiting for OTP....',
          style: defaultCustomTextStyle,
        ),
      ),
    );
  }
}
