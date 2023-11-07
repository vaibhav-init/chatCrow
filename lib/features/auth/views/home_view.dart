import 'package:chat_crow/features/contacts/views/contact_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home'),
      ),
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
