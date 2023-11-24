import 'package:chat_crow/common/widgets/loader.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String route = '/mobile-chat';
  final String name;
  final String uid;

  const MobileChatScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).userDatebyId(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 21,
                      backgroundImage: NetworkImage(snapshot.data!.profilePic),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (snapshot.data!.isOnline)
                              ? Colors.green
                              : Colors.red),
                    ),
                  ],
                );
              },
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
          const Expanded(
            child: Text('Icons'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.face,
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
                              Icons.attach_file_sharp,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo_camera,
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
                  padding: const EdgeInsets.all(7),
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
            ),
          )
        ],
      ),
    );
  }
}
