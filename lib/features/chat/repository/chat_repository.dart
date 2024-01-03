import 'dart:io';
import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/common/providers/message_reply_provider.dart';
import 'package:chat_crow/common/repositories/firebase_storage_repository.dart';
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

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<Message>> getMessages(String receiverId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        var message = Message.fromMap(document.data());
        messages.add(message);
      }

      return messages;
    });
  }

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            lastMessage: chatContact.lastMessage,
            timeSent: chatContact.timeSent));
      }
      return contacts;
    });
  }

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
    required MessageEnum messageType,
    //for replied part
    required MessageReply? messageReply,
    required String senderUsername,
    required String? receiverUsername,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverId: receiverId,
      message: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      // for replied part
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUsername
              : receiverUsername ?? '',
      repliedType:
          messageReply == null ? MessageEnum.text : messageReply.messageEnum,
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
    //reply feature
    required MessageReply? messageReply,
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
        messageType: MessageEnum.text,
        username: sender.name,
        recieverUsername: recieverUserData.name,
        messageReply: messageReply,
        receiverUsername: recieverUserData.name,
        senderUsername: sender.name,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context: context, text: e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel userModel,
    required ProviderRef ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      String imageUrl = await ref
          .read(firebaseStoreageRepositoryProvider)
          .uploadFile(
              'chat/${messageEnum.type}/${userModel.uid}/$recieverUserId/$messageId',
              file);

      UserModel receiverUserData =
          await firestore.collection('users').doc(recieverUserId).get().then(
                (value) => UserModel.fromMap(
                  value.data()!,
                ),
              );
      String message;
      switch (messageEnum) {
        case MessageEnum.image:
          message = '📷 Image';
          break;
        case MessageEnum.audio:
          message = '🔊 Audio';
          break;
        case MessageEnum.video:
          message = '🎥 Video';
          break;
        case MessageEnum.gif:
          message = '🖼️ Gif';
          break;
        default:
          message = 'File';
          break;
      }

      _saveDataToContactSubCollection(
        userModel,
        receiverUserData,
        message,
        timeSent,
        recieverUserId,
      );

      _saveMessagesToMessageSubcollection(
        text: imageUrl,
        receiverId: recieverUserId,
        timeSent: timeSent,
        messageId: messageId,
        messageType: messageEnum,
        username: userModel.name,
        recieverUsername: receiverUserData.name,
        messageReply: messageReply,
        receiverUsername: receiverUserData.name,
        senderUsername: userModel.name,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context: context, text: e.toString());
    }
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) async {
    try {
      //for sender
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });
      //for reciever
      await firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context: context, text: e.toString());
    }
  }
}
