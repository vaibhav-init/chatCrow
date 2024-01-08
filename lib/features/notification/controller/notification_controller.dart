import 'package:chat_crow/features/notification/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationControllerProvider = Provider((ref) {
  return NotificationController(
    ref: ref,
  );
});

class NotificationController {
  final ProviderRef ref;

  NotificationController({
    required this.ref,
  });

  void initNotifications() {
    ref.watch(notificationRepositoryProvider).initNotifications();
  }

  void saveFcmToken(BuildContext context) {
    ref.watch(notificationRepositoryProvider).saveFCMToken(context: context);
  }
}
