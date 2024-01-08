// ignore_for_file: use_build_context_synchronously

import 'package:chat_crow/common/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationRepositoryProvider = Provider((ref) => NotificationRepository(
      firebaseMessaging: FirebaseMessaging.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ));

Future<void> handleNotification(RemoteMessage message) async {}

class NotificationRepository {
  final FirebaseMessaging firebaseMessaging;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  NotificationRepository(
      {required this.firebaseMessaging,
      required this.firebaseFirestore,
      required this.firebaseAuth});

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handleNotification);
  }

  void saveFCMToken({
    required BuildContext context,
  }) async {
    try {
      final token = await firebaseMessaging.getToken();
      String uid = firebaseAuth.currentUser!.uid;
      if (token != null) {
        await firebaseFirestore.collection('tokens').doc(uid).set({
          'token': token,
        });
      } else {
        showSnackbar(
            context: context, text: 'Please give notification permission :(');
      }
    } catch (e) {
      showSnackbar(
        context: context,
        text: e.toString(),
      );
    }
  }
}
