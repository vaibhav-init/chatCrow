import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuItems extends ConsumerWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Send Image'),
          onTap: () {
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Send Video'),
          onTap: () {
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
          },
        ),
        ListTile(
          leading: const Icon(Icons.file_copy),
          title: const Text('Send File'),
          onTap: () {
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
          },
        ),
      ],
    );
  }
}
