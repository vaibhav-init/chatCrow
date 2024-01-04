import 'dart:io';
import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/common/providers/message_reply_provider.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/features/chat/repository/chat_repository.dart';
import 'package:chat_crow/models/chat_contact_model.dart';
import 'package:chat_crow/models/group_model.dart';
import 'package:chat_crow/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContact() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Group>> chatGroups() {
    return chatRepository.getChatGroups();
  }

  Stream<List<Message>> getChats(String receiverId) {
    return chatRepository.getMessages(receiverId);
  }

  void sendTextMessage(BuildContext context, String text, String receiverId) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataProvider).whenData(
          (value) => chatRepository.sendTextMessage(
              context: context,
              message: text,
              receiverId: receiverId,
              sender: value!,
              messageReply: messageReply),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(BuildContext context, File file, String receiverId,
      MessageEnum messageEnum) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataProvider).whenData(
          (value) => chatRepository.sendFileMessage(
              context: context,
              file: file,
              recieverUserId: receiverId,
              userModel: value!,
              ref: ref,
              messageEnum: messageEnum,
              messageReply: messageReply),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    chatRepository.setChatMessageSeen(context, recieverUserId, messageId);
  }
}
