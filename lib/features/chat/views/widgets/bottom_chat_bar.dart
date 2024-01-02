import 'dart:io';
import 'package:chat_crow/common/enums/message_enum.dart';
import 'package:chat_crow/common/utils.dart';
import 'package:chat_crow/features/chat/controller/chat_controller.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  bool showEmojiKeyboard = false;
  FocusNode focusNode = FocusNode();
  bool isRecording = false;
  bool isRecorderInit = false;
  FlutterSoundRecorder? recorder;

  @override
  void initState() {
    super.initState();
    recorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await recorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (showSend) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            messageController.text.trim(),
            widget.receiverUserId,
          );

      setState(() {
        messageController.text = '';
        showSend = false;
      });
    } else {
      var tempDirectory = await getTemporaryDirectory();
      var path = '${tempDirectory.path}/temp_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await recorder!.stopRecorder();
      } else {
        await recorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      // ignore: use_build_context_synchronously
      ref.read(chatControllerProvider).sendFileMessage(
            context,
            image,
            widget.receiverUserId,
            MessageEnum.image,
          );
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      // ignore: use_build_context_synchronously
      ref.read(chatControllerProvider).sendFileMessage(
            context,
            video,
            widget.receiverUserId,
            MessageEnum.video,
          );
    }
  }

  void hideEmojiContainer() {
    setState(() {
      showEmojiKeyboard = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      showEmojiKeyboard = true;
    });
  }

  void toggleEmojiContainer() {
    if (showEmojiKeyboard) {
      focusNode.requestFocus();
      hideEmojiContainer();
    } else {
      focusNode.unfocus();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    recorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
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
                      onPressed: toggleEmojiContainer,
                      icon: Icon(
                        Icons.face,
                        size: 26,
                        color: showEmojiKeyboard ? Colors.blue : null,
                      ),
                    ),
                    hintText: 'Onee Chan Message..',
                    suffixIcon: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              selectImage();
                            },
                            icon: const Icon(Icons.photo),
                            label: const Text('Gallery'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.gif),
                            label: const Text('Gif'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.mic),
                            label: const Text('Audio'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              selectVideo();
                            },
                            icon: const Icon(Icons.video_camera_back),
                            label: const Text('Video'),
                          ),
                        ),
                      ],
                      icon: const Icon(
                        Icons.attach_file,
                        size: 26,
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
                      showSend
                          ? Icons.send
                          : isRecording
                              ? Icons.cancel
                              : Icons.mic,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          showEmojiKeyboard
              ? SizedBox(
                  height: 310,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      messageController.text += emoji.emoji;

                      if (!showSend) {
                        setState(() {
                          showSend = !showSend;
                        });
                      }
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
