import 'package:chat_crow/constants/router.dart';
import 'package:chat_crow/features/onboarding/views/welcome_screen.dart';
import 'package:chat_crow/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatCrow());
}

class ChatCrow extends StatelessWidget {
  const ChatCrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ChatCrow",
      theme: ThemeData(
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      home: const WelcomeView(),
    );
  }
}
