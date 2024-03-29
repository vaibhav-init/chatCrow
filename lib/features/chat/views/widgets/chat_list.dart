import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/common/providers/message_reply_provider.dart';
import 'package:chat_crow/common/widgets/loader.dart';
import 'package:chat_crow/features/chat/controller/chat_controller.dart';
import 'package:chat_crow/features/chat/views/widgets/my_message_card.dart';
import 'package:chat_crow/features/chat/views/widgets/sender_message_card.dart';
import 'package:chat_crow/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverId;
  final bool isGroup;

  const ChatList({
    super.key,
    required this.receiverId,
    required this.isGroup,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(message, isMe, messageEnum),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: widget.isGroup
            ? ref.read(chatControllerProvider).getGroupChats(widget.receiverId)
            : ref.read(chatControllerProvider).getChats(widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
          return ListView.builder(
            controller: scrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (!messageData.isSeen &&
                  messageData.recieverId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                      context,
                      widget.receiverId,
                      messageData.messageId,
                    );
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.message,
                  date: timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  repliedType: messageData.repliedType,
                  username: messageData.repliedTo,
                  onLeftSwipe: () => onMessageSwipe(
                    messageData.message,
                    true,
                    messageData.type,
                  ),
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessageCard(
                message: messageData.message,
                date: timeSent,
                type: messageData.type,
                username: messageData.repliedTo,
                repliedText: messageData.repliedMessage,
                repliedType: messageData.repliedType,
                onRightSwipe: () => onMessageSwipe(
                  messageData.message,
                  false,
                  messageData.type,
                ),
              );
            },
          );
        });
  }
}
