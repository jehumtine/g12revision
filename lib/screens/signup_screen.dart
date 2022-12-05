import 'package:easy_separator/easy_separator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/auth_controller.dart';
import 'package:g12revision/models/country_dropdown.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/dialogs.dart';
import 'package:g12revision/widgets/input_widgets.dart';
import 'package:g12revision/widgets/main_button.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

import '../controllers/validation_controler.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
// country
  String initialSelectedItem = 'Zambia';
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    passwordController.dispose();
    cityController.dispose();
    countryController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: Text(
            'Sign up',
            style: kHeaderTS,
          ),
        ),
        body: Obx(
          () => AuthController.instance.isLoading.value
              ? Center(child: CustomIndicator.signingIndicator)
              : Form(
                  key: signUpFormKey,
                  child: SizedBox(
                    width: UIParameters.getWidth(context),
                    height: UIParameters.getHeight(context),
                    child: Padding(
                      padding: const EdgeInsets.all(kMobileScreenPadding),
                      child: SingleChildScrollView(
                        child: EasySeparatedColumn(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                            // email input fiel
                            InputFields(
                              controller: nameController,

                              validator: (value) {
                                return '${ValidationController.instance.validateFirstname(value!)}';
                              },
                              //  validator: (firstName)=>,
                            ),
                            Text(
                              'Last Name'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                            // email input fiel
                            InputFields(
                              controller: surnameController,
                              validator: (value) {
                                return '${ValidationController.instance.validateLastName(value!)}';
                              },
                            ),
                            // email input fiel
                            Text(
                              'Email'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                            InputFields(
                              controller: emailController,
                              validator: (value) {
                                return '${ValidationController.instance.validateEmail(value!)}';
                              },
                            ),
                            Text(
                              'Country'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                            Container(
                              height: 50,
                              color: greyColor[300],
                              width: UIParameters.getWidth(context),
                              child: DropdownButtonFormField<String>(
                                  hint: Text(
                                    'Select country',
                                    style: inputStyle,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value == null ? '' : null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 14.0, bottom: 0.0, top: 0.0),
                                  ),
                                  style: inputStyle.copyWith(color: blackColor),
                                  items: countries
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child:
                                                Text(item, style: inputStyle)),
                                      )
                                      .toList(),
                                  onChanged: (value) => setState(() {
                                        initialSelectedItem = value!;
                                      })),
                            ),
                            Text(
                              'City'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                            InputFields(
                              controller: cityController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Field required' : '',
                            ),
                            Text(
                              'Password'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                            // password fie
                            InputFields(
                              controller: passwordController,
                              obsecureText: true,
                              validator: (value) {
                                return '${ValidationController.instance.validatePassword(value!)}';
                              },
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: MainButton(
                                onPressed: () {
                                  AuthController.instance.signUp(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      signUpFormKey,
                                      nameController.text.trim(),
                                      surnameController.text.trim(),
                                      cityController.text.trim(),
                                      initialSelectedItem.toString());
                                  // otp send message
                                  // AuthController.instance.sendOTP(emailController.text.trim());
                                },
                                widget: Text(
                                  'Sign Up',
                                  style: kDetailsTS.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.topCenter,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "By creating an account you agree to our",
                                        style: inputStyle),
                                    TextSpan(
                                        text: ' Terms and Conditions',
                                        style: inputStyle.copyWith(
                                            color: greyColor)),
                                    TextSpan(
                                        text: " and that you have read our",
                                        style: inputStyle),
                                    TextSpan(
                                        text: ' Privacy Policy.',
                                        style: inputStyle.copyWith(
                                            color: greyColor)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
  // sign up
}
