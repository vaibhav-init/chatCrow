import 'package:chat_crow/features/chat/views/widgets/contacts_list.dart';
import 'package:chat_crow/features/contacts/views/contact_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/svgs/logo.svg',
              height: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "ChatCrow",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search,
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
      body: const ContactsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          ContactsView.route,
        ),
        child: const Center(
          child: Icon(
            Icons.message_rounded,
          ),
        ),
      ),
    );
  }
}
