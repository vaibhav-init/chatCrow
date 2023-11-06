// ignore_for_file: use_build_context_synchronously

import 'package:chat_crow/common/utils.dart';
import 'package:chat_crow/features/auth/views/details_view.dart';
import 'package:chat_crow/features/auth/views/otp_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void phoneNumberSignIn(String phone, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credentials) async {
          await auth.signInWithCredential(credentials);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(
            context,
            OtpView.route,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context: context,
        text: e.message!,
      );
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        DetailsView.route,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context: context,
        text: e.message!,
      );
    }
  }
}
