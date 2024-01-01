import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/features/chat/views/widgets/video_player.dart';
import 'package:flutter/material.dart';

class MessageContent extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const MessageContent({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.image
            ? CachedNetworkImage(
                imageUrl: message,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : VideoPlayerUI(videoUrl: message);
  }
}
