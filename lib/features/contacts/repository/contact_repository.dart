import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository({
    required this.firestore,
  });

  getContacts() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }
}
