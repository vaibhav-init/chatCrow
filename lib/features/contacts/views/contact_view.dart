import 'package:chat_crow/common/error_screen.dart';
import 'package:chat_crow/common/widgets/loader.dart';
import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/contacts/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsView extends ConsumerWidget {
  static const route = '/contact-view';
  const ContactsView({super.key});

  void selectContact(
      WidgetRef ref, BuildContext context, Contact selectedContact) {
    ref.read(contactControllerProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        elevation: 3,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Select Contact',
          style: defaultCustomTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => selectContact(
                      ref,
                      context,
                      data[index],
                    ),
                    child: ListTile(
                      leading: (data[index].photo == null)
                          ? const CircleAvatar(
                              radius: 30,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage: MemoryImage(data[index].photo!),
                            ),
                      title: Text(
                        data[index].displayName,
                        style: defaultCustomTextStyle,
                      ),
                      subtitle: Text(
                        (data[index].phones.isEmpty)
                            ? 'No Phone Number'
                            : data[index].phones[0].number.replaceAll(' ', ''),
                        style: defaultCustomTextStyle.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }),
            error: (error, stackTrace) => ErrorScreen(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
