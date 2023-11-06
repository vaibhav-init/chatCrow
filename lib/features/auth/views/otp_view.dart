import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpView extends ConsumerStatefulWidget {
  static const String route = '/otp-view';
  final String verificationId;
  const OtpView({
    super.key,
    required this.verificationId,
  });

  @override
  ConsumerState<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends ConsumerState<OtpView> {
  String otpCode = "";
  @override
  void initState() {
    _listenOtp();
    super.initState();
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  void verifyOTP(WidgetRef ref, BuildContext context, String otp) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          widget.verificationId,
          otp,
        );
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

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
      body: Center(
        child: PinFieldAutoFill(
          currentCode: otpCode,
          codeLength: 6,
          onCodeChanged: (code) {
            otpCode = code.toString();
          },
          onCodeSubmitted: (val) {},
        ),
      ),
    );
  }
}
