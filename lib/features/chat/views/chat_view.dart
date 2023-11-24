import 'package:flutter/material.dart';

class MobileChatScreen extends StatelessWidget {
  static const String route = '/mobile-chat';
  final String name;
  final String uid;

  const MobileChatScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 19,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person,
                    ),
                  ),
                ),
                const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.green,
                    ))
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.videocam,
              size: 27,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.call,
              size: 27,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions,
                        size: 26,
                      ),
                    ),
                    hintText: 'Message',
                    hintStyle: const TextStyle(fontSize: 10),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attach_file,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 20,
                          ),
                        ),
                      ],
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
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  radius: 22,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
