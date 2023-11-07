// ignore_for_file: use_build_context_synchronously

import 'package:chat_crow/common/utils.dart';
import 'package:chat_crow/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactRepositoryProvider = Provider(
  (ref) => ContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollections = await firestore.collection('users').get();
      bool found = false;
      for (var document in userCollections.docs) {
        var userData = UserModel.fromMap(document.data());
      }
    } catch (e) {
      showSnackbar(
        context: context,
        text: e.toString(),
      );
    }
  }
}
