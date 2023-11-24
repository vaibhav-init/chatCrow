import 'package:flutter/material.dart';

class BottomChatBar extends StatefulWidget {
  const BottomChatBar({super.key});

  @override
  State<BottomChatBar> createState() => _BottomChatBarState();
}

class _BottomChatBarState extends State<BottomChatBar> {
  bool showSend = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
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
                onPressed: () {},
                icon: Icon(
                  showSend ? Icons.send : Icons.mic,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
