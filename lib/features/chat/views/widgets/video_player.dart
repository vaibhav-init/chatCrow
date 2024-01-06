import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';

class VideoPlayerUI extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerUI({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerUI> createState() => _VideoPlayerUIState();
}

class _VideoPlayerUIState extends State<VideoPlayerUI> {
  late CachedVideoPlayerPlusController controller;
  bool isPlaying = false;
  @override
  void initState() {
    controller = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        controller.setVolume(1);
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayerPlus(controller),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
