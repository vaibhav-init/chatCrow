import 'package:chat_crow/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
  );
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository,
  });

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    authRepository.phoneNumberSignIn(
      phoneNumber,
      context,
    );
  }

  void verifyOTP(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      otp: otp,
    );
  }
}
