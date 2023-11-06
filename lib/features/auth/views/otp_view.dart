import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class OtpView extends ConsumerWidget {
  static const String route = '/otp-view';
  final String verificationId;
  const OtpView({
    super.key,
    required this.verificationId,
  });

  void verifyOTP(WidgetRef ref, BuildContext context, String otp) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          otp,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            'Please Enter the  OTP',
            style: defaultCustomTextStyle,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.7,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textStyle: defaultCustomTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
