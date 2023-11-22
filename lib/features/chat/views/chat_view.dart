import 'package:flutter/material.dart';

class MobileChatScreen extends StatelessWidget {
  static const String route = '/mobile-chat';
  const MobileChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vaibhav',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.video_call,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.more_vert,
              size: 27,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgImg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
                child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        color: Colors.grey,
                        icon: const Icon(
                          Icons.emoji_emotions,
                          size: 26,
                        ),
                      ),
                      hintText: 'Message',
                      hintStyle:
                          const TextStyle(fontSize: 10, color: Colors.white),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            color: Colors.grey,
                            icon: const Icon(
                              Icons.attach_file,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.grey,
                            icon: const Icon(
                              Icons.currency_rupee,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.grey,
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
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
