import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/auth/views/details_view.dart';
import 'package:chat_crow/features/auth/views/login_view.dart';
import 'package:chat_crow/features/auth/views/otp_view.dart';
import 'package:chat_crow/features/chat/views/chat_view.dart';
import 'package:chat_crow/features/contacts/views/contact_view.dart';
import 'package:chat_crow/features/group/views/create_group_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.route:
      return MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
    case OtpView.route:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpView(
                verificationId: verificationId,
              ));
    case DetailsView.route:
      return MaterialPageRoute(
        builder: (context) => const DetailsView(),
      );
    case ContactsView.route:
      return MaterialPageRoute(
        builder: (context) => const ContactsView(),
      );
    case MobileChatScreen.route:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroup = arguments['isGroup'];

      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
          isGroup: isGroup,
        ),
      );
    case CreateGroupScreen.route:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                    child: Text(
                  'Error Screen ',
                  style: defaultCustomTextStyle,
                )),
              ));
  }
}
