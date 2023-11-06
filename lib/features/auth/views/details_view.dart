import 'dart:io';
import 'package:chat_crow/common/utils.dart';
import 'package:chat_crow/common/widgets/custom_textfield.dart';
import 'package:chat_crow/common/widgets/rounded_button.dart';
import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:chat_crow/features/auth/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsView extends ConsumerStatefulWidget {
  static const route = '/update-details';
  const DetailsView({super.key});

  @override
  ConsumerState<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends ConsumerState<DetailsView> {
  final nameController = TextEditingController();
  File? image;
  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void saveUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
        (route) => false,
      );
    } else {
      showSnackbar(
        context: context,
        text: 'Name can\'t be Null',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Update Your Details',
          style: defaultCustomTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        image == null
                            ? const CircleAvatar(
                                radius: 75,
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  size: 75,
                                )),
                              )
                            : CircleAvatar(
                                radius: 75,
                                backgroundImage: FileImage(image!),
                              ),
                        Positioned(
                          bottom: -11,
                          left: 100,
                          child: IconButton(
                            onPressed: () => selectImage(),
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Enter Your Name :D',
                      keyboardType: TextInputType.name,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: RoundedButton(
                    function: () => saveUserData(),
                    textToUse: 'Let\'s Go',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
