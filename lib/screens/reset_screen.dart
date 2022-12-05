import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/input_widgets.dart';
import 'package:g12revision/widgets/main_button.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

import '../controllers/auth_controller.dart';
import '../controllers/validation_controler.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);
  static const String routeName = '/reset';

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: Text(
            "Reset Password",
            style: kHeaderTS,
          ),
        ),
        body: Obx(() => AuthController.instance.isLoading.value
            ? Center(child: CustomIndicator.passwordResset)
            : SingleChildScrollView(
                child: Form(
                key: resetFormKey,
                child: SizedBox(
                  width: UIParameters.getWidth(context),
                  height: UIParameters.getHeight(context),
                  child: Padding(
                    padding: const EdgeInsets.all(kMobileScreenPadding),
                    child: EasySeparatedColumn(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'We will send you a reset password link to your email that you can use to reset your password.',
                              style: inputStyle.copyWith(color: greyColor),
                              textAlign: TextAlign.center),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Email'.toUpperCase(),
                              style: kDetailsTS.copyWith(
                                  color: greyColor, fontSize: 15),
                            ),
                          ),

                          // bottom container
                          InputFields(
                            validator: (value) {
                              return '${ValidationController.instance.validateEmail(value!)}';
                            },
                            controller: emailController,
                          ),

                          // Reset button
                          Align(
                            alignment: Alignment.center,
                            child: MainButton(
                              onPressed: () => AuthController.instance.reset(
                                  emailController.text.trim(), resetFormKey),
                              widget: Text(
                                'Reset',
                                style: kDetailsTS.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ))));
  }
}
