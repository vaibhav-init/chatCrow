import 'package:chat_crow/common/widgets/loader.dart';
import 'package:chat_crow/features/chat/controller/chat_controller.dart';
import 'package:chat_crow/features/chat/views/widgets/my_message_card.dart';
import 'package:chat_crow/features/chat/views/widgets/sender_message_card.dart';
import 'package:chat_crow/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerWidget {
  final String receiverId;

  const ChatList({
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).getChats(receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.message,
                  date: timeSent,
                );
              }
              return SenderMessageCard(
                message: messageData.message,
                date: timeSent,
              );
            },
          );
        });
  }
}
