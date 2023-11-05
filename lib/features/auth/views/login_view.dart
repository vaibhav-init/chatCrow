// ignore_for_file: library_private_types_in_public_api

import 'package:chat_crow/common/widgets/custom_textfield.dart';
import 'package:chat_crow/constants/constants.dart';
import 'package:chat_crow/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:chat_crow/common/widgets/rounded_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';

class LoginView extends ConsumerStatefulWidget {
  static const route = '/login';
  const LoginView({
    super.key,
  });
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final numberController = TextEditingController();
  Country country = Country.worldWide;

  void selectCountry() {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
        searchTextStyle: defaultCustomTextStyle,
        textStyle: defaultCustomTextStyle,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      context: context,
      showPhoneCode: true,
      onSelect: (Country selectedCountry) {
        setState(() {
          country = selectedCountry;
        });
      },
    );
  }

  void loginWithPhone(BuildContext context) {
    String number = "+${country.phoneCode}${numberController.text.trim()}";
    ref.read(authControllerProvider).signInWithPhoneNumber(context, number);
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Enter Your Phone Number',
          style: defaultCustomTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: SvgPicture.asset(
                        'assets/svgs/logo.svg',
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomPhoneTextField(
                    controller: numberController,
                    country: country,
                    selectCountry: selectCountry,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Hero(
                tag: 'button',
                child: RoundedButton(
                  function: () => loginWithPhone(context),
                  textToUse: 'Get OTP',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
