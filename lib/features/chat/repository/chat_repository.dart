import 'package:chat_crow/common/utils.dart';
import 'package:chat_crow/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void _saveDataToContactSubCollection() {}

  void sendTextMessage({
    required BuildContext context,
    required String message,
    required String receiverId,
    required UserModel sender,
  }) async {
    try {
      var timeSent = DateTime.now();

      var userDataMap =
          await firestore.collection('users').doc(receiverId).get();
      UserModel recieverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactSubCollection();
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }
}
