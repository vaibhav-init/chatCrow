import 'package:chat_crow/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_crow/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;
  final _firestore = FirebaseFirestore.instance;

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: const Text('🗣️ ️Chat'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('msg').snapshots(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapShot.data?.docs.reversed;
                List<MessageBox> messageWidget = [];
                for (var message in messages!) {
                  var data = message.data() as Map;
                  final msgText = data['content'];
                  final sender = data['email'];
                  final currentUser = loggedInUser.email;
                  final messageData = MessageBox(
                      sender: sender,
                      msg: msgText,
                      isMe: sender == currentUser);
                  messageWidget.add(messageData);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: messageWidget,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.clear();
                      _firestore.collection('msg').add({
                        'content': messageText,
                        'email': loggedInUser.email,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  final String sender;
  final String msg;
  final bool isMe;
  const MessageBox(
      {super.key, required this.sender, required this.msg, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender,
          style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: isMe ? Colors.blueGrey[400] : Colors.white,
            elevation: 10,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? const Radius.circular(30) : Radius.zero,
              bottomLeft: const Radius.circular(30),
              bottomRight: const Radius.circular(30),
              topRight: isMe ? Radius.zero : const Radius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                msg,
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
