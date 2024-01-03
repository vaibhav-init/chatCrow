import 'package:chat_crow/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String message;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  // replied things
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedType;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.message,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'recieverId': recieverId,
      'message': message,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedType': repliedType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      message: map['message'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'],
      isSeen: map['isSeen'],
      repliedMessage: map['repliedMessage'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      repliedType: (map['repliedType'] as String).toEnum(),
    );
  }
}
