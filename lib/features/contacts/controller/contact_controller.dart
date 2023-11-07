import 'package:chat_crow/features/contacts/repository/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getContactsProvider = FutureProvider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return contactRepository.getContacts();
});

class ContactController {
  final ProviderRef ref;
  final ContactRepository contactRepository;

  ContactController({
    required this.ref,
    required this.contactRepository,
  });
  void selectContact(Contact contact, BuildContext context) {
    contactRepository.selectContact(contact, context);
  }
}
