import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/auth_controller.dart';
import 'package:g12revision/controllers/validation_controler.dart';
import 'package:g12revision/screens/signup_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/input_widgets.dart';
import 'package:g12revision/widgets/main_button.dart';
import 'package:g12revision/widgets/ui_parameters.dart';
import 'reset_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/login';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> welcomeFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => AuthController.instance.isLoading.value
          ? Center(child: CustomIndicator.signingIndicator)
          : SingleChildScrollView(
              child: Form(
              key: welcomeFormKey,
              child: SizedBox(
                width: UIParameters.getWidth(context),
                height: UIParameters.getHeight(context),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: purpleColor,
                        width: UIParameters.getWidth(context),
                        height: 190,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/logo1.png',
                              height: 70,
                              width: 70,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Transcended Institute'.toUpperCase(),
                              style: kHeaderTS,
                            )
                          ],
                        ),
                      ),
                      // bottom container
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(kMobileScreenPadding),
                          child: EasySeparatedColumn(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Email Address'.toUpperCase(),
                                  style: kDetailsTS.copyWith(
                                      color: greyColor, fontSize: 15),
                                ),
                              ),
                              InputFields(
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                controller: emailController,
                                inputType: TextInputType.emailAddress,
                                validator: (value) {
                                  return '${ValidationController.instance.validateEmail(value!)}';
                                },
                              ),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Password'.toUpperCase(),
                                  style: kDetailsTS.copyWith(
                                      color: greyColor, fontSize: 15),
                                ),
                              ),

                              InputFields(
                                  obsecureText: true,
                                  inputType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    return '${ValidationController.instance.validatePassword(value!)}';
                                  },
                                  onSaved: (value) {
                                    passwordController.text = value!;
                                  },
                                  controller: passwordController,
                                  icon: Icons.lock),
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => const ResetScreen(),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    height: 17,
                                    child: Text('Forgot password? Reset',
                                        style: inputStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: greyColor,
                                            fontSize: 15)),
                                  ),
                                ),
                              ),
                              // login button
                              MainButton(
                                onPressed: () => AuthController.instance.signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    welcomeFormKey),
                                widget: Text('Login', style: kHeaderTS),
                              ),

                              // create account screen
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => const SignUpScreen(),
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    height: 17,
                                    child: Text(
                                        "Don't have an account? Sign Up",
                                        style: inputStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: greyColor,
                                            fontSize: 15)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // email input field

                      // forgot password text
                    ]),
              ),
            )),
    ));
  }
}
