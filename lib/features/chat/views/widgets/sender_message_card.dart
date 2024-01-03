import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/features/chat/views/widgets/message_content.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class SenderMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  //more for replied section
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedType;

  const SenderMessageCard({
    super.key,
    required this.message,
    required this.date,
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedType,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (DragUpdateDetails details) {
        onRightSwipe();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 7,
                          right: 7,
                          top: 7,
                          bottom: 25,
                        ),
                  child: MessageContent(message: message, type: type),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
