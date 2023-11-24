import 'dart:io';
import 'package:chat_crow/features/auth/repository/auth_repository.dart';
import 'package:chat_crow/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserData();
});

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

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

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserData(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Future<UserModel?> getCurrentUserData() async {
    var user = await authRepository.getCurrentUserData();
    return user;
  }

  Stream<UserModel> userDatebyId(String userId) {
    return authRepository.userData(userId);
  }
}
