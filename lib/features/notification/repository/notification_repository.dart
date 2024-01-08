import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationRepositoryProvider = Provider((ref) => NotificationRepository(
      firebaseMessaging: FirebaseMessaging.instance,
    ));

class NotificationRepository {
  final FirebaseMessaging firebaseMessaging;

  NotificationRepository({
    required this.firebaseMessaging,
  });

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print(fcmToken.toString());
  }
}
