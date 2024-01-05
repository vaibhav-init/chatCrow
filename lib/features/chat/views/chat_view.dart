import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_crow/common/widgets/loader.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/features/call/controller/call_controller.dart';
import 'package:chat_crow/features/call/views/call_pickup_view.dart';
import 'package:chat_crow/features/chat/views/widgets/bottom_chat_bar.dart';
import 'package:chat_crow/features/chat/views/widgets/chat_list.dart';
import 'package:chat_crow/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String route = '/mobile-chat';

  final String name;
  final String uid;
  final bool isGroup;
  final String profilePic;

  const MobileChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroup,
    required this.profilePic,
  });

  void makeCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeCall(
          context,
          name,
          uid,
          profilePic,
          isGroup,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: isGroup
              ? Text(name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder<UserModel>(
                      stream:
                          ref.read(authControllerProvider).userDatebyId(uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Loader();
                        }
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 21,
                              backgroundImage: CachedNetworkImageProvider(
                                snapshot.data!.profilePic,
                              ),
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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () => makeCall(ref, context),
                icon: const Icon(
                  Icons.videocam,
                  size: 27,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  size: 27,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                receiverId: uid,
                isGroup: isGroup,
              ),
            ),
            BottomChatBar(
              receiverUserId: uid,
              isGroup: isGroup,
            ),
          ],
        ),
      ),
    );
  }
}
