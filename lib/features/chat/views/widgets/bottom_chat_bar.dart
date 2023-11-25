import 'package:chat_crow/features/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomChatBar extends ConsumerStatefulWidget {
  final String receiverUserId;

  const BottomChatBar({
    super.key,
    required this.receiverUserId,
  });

  @override
  ConsumerState<BottomChatBar> createState() => _BottomChatBarState();
}

class _BottomChatBarState extends ConsumerState<BottomChatBar> {
  bool showSend = false;
  final TextEditingController messageController = TextEditingController();

  void sendTextMessage() async {
    if (showSend) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            messageController.text.trim(),
            widget.receiverUserId,
          );

      messageController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    showSend = false;
                  });
                } else {
                  setState(() {
                    showSend = true;
                  });
                }
              },
              decoration: InputDecoration(
                filled: true,
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.face,
                    size: 26,
                  ),
                ),
                hintText: 'Onee Chan Message..',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.attach_file_sharp,
                    size: 20,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7),
            child: CircleAvatar(
              radius: 22,
              child: IconButton(
                onPressed: () => sendTextMessage(),
                icon: Icon(
                  showSend ? Icons.send : Icons.mic,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
