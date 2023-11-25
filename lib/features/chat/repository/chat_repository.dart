import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/common/utils.dart';
import 'package:chat_crow/models/chat_contact_model.dart';
import 'package:chat_crow/models/message_model.dart';
import 'package:chat_crow/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void _saveDataToContactSubCollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    //this if for reciever
    var recieverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      lastMessage: text,
      timeSent: timeSent,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(
          recieverChatContact.toMap(),
        );

    //now for sender

    var senderChatContact = ChatContact(
      name: recieverUserData.name,
      profilePic: recieverUserData.profilePic,
      contactId: recieverUserData.uid,
      lastMessage: text,
      timeSent: timeSent,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessagesToMessageSubcollection({
    required String text,
    required String receiverId,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String recieverUsername,
    required MessageEnum type,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverId: receiverId,
      message: text,
      type: type,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    //for sender
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    //for reciever
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String message,
    required String receiverId,
    required UserModel sender,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      var userDataMap =
          await firestore.collection('users').doc(receiverId).get();
      UserModel recieverUserData = UserModel.fromMap(userDataMap.data()!);
      _saveDataToContactSubCollection(
        sender,
        recieverUserData,
        message,
        timeSent,
        receiverId,
      );

      _saveMessagesToMessageSubcollection(
        text: message,
        receiverId: receiverId,
        timeSent: timeSent,
        messageId: messageId,
        username: sender.name,
        recieverUsername: recieverUserData.name,
        type: MessageEnum.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context: context, text: e.toString());
    }
  }
}
