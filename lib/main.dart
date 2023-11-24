import 'package:chat_crow/common/error_screen.dart';
import 'package:chat_crow/common/widgets/loader.dart';
import 'package:chat_crow/constants/router.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/features/auth/views/home_view.dart';
import 'package:chat_crow/features/onboarding/views/welcome_screen.dart';
import 'package:chat_crow/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: ChatCrow(),
    ),
  );
}

class ChatCrow extends ConsumerWidget {
  const ChatCrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ChatCrow",
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      home: ref.watch(userDataProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              } else {
                return const WelcomeView();
              }
            },
            error: (error, stackTrace) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
