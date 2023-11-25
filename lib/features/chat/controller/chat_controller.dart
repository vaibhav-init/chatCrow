import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/features/chat/repository/chat_repository.dart';
import 'package:chat_crow/models/chat_contact_model.dart';
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

  Stream<List<Message>> getChats(String receiverId) {
    return chatRepository.getMessages(receiverId);
  }

  void sendTextMessage(BuildContext context, String text, String receiverId) {
    ref.read(userDataProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            message: text,
            receiverId: receiverId,
            sender: value!,
          ),
        );
  }
}
