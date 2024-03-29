import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/features/chat/views/widgets/contacts_list.dart';
import 'package:chat_crow/features/contacts/views/contact_view.dart';
import 'package:chat_crow/features/group/views/create_group_view.dart';
import 'package:chat_crow/features/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.detached:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  void logOut(BuildContext context) {
    ref.read(authControllerProvider).logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(notificationControllerProvider).initNotifications();
    ref.watch(notificationControllerProvider).saveFcmToken(context);
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CreateGroupScreen.route,
                );
              },
              icon: const Icon(
                Icons.group_add,
                size: 27,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.info,
                  title: "LOGOUT",
                  desc: "Do You Really Want to Logout?",
                  style: const AlertStyle(
                    titleStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    descStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  buttons: [
                    DialogButton(
                      color: Colors.red,
                      onPressed: () => logOut(context),
                      width: 120,
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DialogButton(
                      color: Colors.green,
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();
              },
              icon: const Icon(
                Icons.logout,
                size: 24,
              ),
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
