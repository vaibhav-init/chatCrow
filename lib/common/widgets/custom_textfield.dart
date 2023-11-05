import 'package:chat_crow/constants/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CustomPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final Country country;
  final VoidCallback selectCountry;

  const CustomPhoneTextField({
    super.key,
    required this.controller,
    required this.country,
    required this.selectCountry,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'Ubuntu',
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: '986**********',
        hintStyle: const TextStyle(
          fontSize: 20,
          fontFamily: 'Ubuntu',
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: selectCountry,
            child: Text(
              "${country.flagEmoji} +${country.phoneCode}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
