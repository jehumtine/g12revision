import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/auth_controller.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';

import '../screens/web_screen.dart';
import 'main_button.dart';

class Dialogs {
  static aboutDialog() {
    return showDialog(
        context: Get.overlayContext!,
        builder: (context) => AlertDialog(
              title: Text(
                "About us",
                style: googleStyle,
              ),
              content: Text(
                "Transcended institute specializes in provision of High quality Online Lessons that include Live Lessons, pre- recorded sessions and Personal coaching for High school students, A-level students and College students Taking MATHEMATICS, CHEMISTRY , PHYSICS AND BIOLOGY.",
                style: inputStyle,
              ),
              actions: [
                TextButton(
                    style:
                        TextButton.styleFrom(foregroundColor: darkOrangeColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Okay',
                      style: inputStyle.copyWith(color: darkOrangeColor),
                    )),
                TextButton(
                    style:
                        TextButton.styleFrom(foregroundColor: darkOrangeColor),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Get.to(() => const WebScreen(
                          url: 'https://g12revision.com/about-us/',
                          name: 'About us'));
                    },
                    child: Text(
                      'More',
                      style: inputStyle.copyWith(color: darkOrangeColor),
                    )),
              ],
            ));
  }

  // loading
  static loadingDialog() {
    return showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: whiteColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIndicator.circularIndicator,
                ],
              ),
            ));
  }

  static paymentDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
            backgroundColor: whiteColor,
            content: Text(
              'Payment Successiful',
              style: googleStyle.copyWith(color: blackColor),
            )));
  }

  static helpDialog(BuildContext context) {
    return showDialog(
        context: Get.overlayContext!,
        builder: (context) => AlertDialog(
              title: Text(
                'Help',
                style: googleStyle,
              ),
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "You can quickly reach out to us using our contact information",
                      style: inputStyle,
                    ),
                    ListTile(
                      subtitle: Text(
                        'admin@g12revision.com',
                        style: inputStyle,
                      ),
                      leading: const Icon(
                        FontAwesomeIcons.message,
                      ),
                      title: Text(
                        'Email',
                        style: inputStyle,
                      ),
                    ),
                    ListTile(
                      subtitle: Text(
                        '+260767729927',
                        style: inputStyle,
                      ),
                      leading: const Icon(
                        FontAwesomeIcons.phone,
                      ),
                      title: Text(
                        'Phone',
                        style: inputStyle,
                      ),
                    ),
                  ]),
              actions: [
                TextButton(
                    style:
                        TextButton.styleFrom(foregroundColor: darkOrangeColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Okay',
                      style: inputStyle.copyWith(color: darkOrangeColor),
                    )),
              ],
            ));
  }

  static signOutDialog(BuildContext context) {
    return showDialog(
        context: Get.overlayContext!,
        builder: (context) => AlertDialog(
              title: Text(
                'Logout?',
                style: googleStyle,
              ),
              content: Text(
                'Are you sure you want to log out?',
                style: inputStyle,
              ),
              actions: [
                TextButton(
                    style:
                        TextButton.styleFrom(foregroundColor: darkOrangeColor),
                    onPressed: () {
                      AuthController.instance.signOut();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Yes',
                      style: inputStyle.copyWith(color: darkOrangeColor),
                    )),
                TextButton(
                    style:
                        TextButton.styleFrom(foregroundColor: darkOrangeColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'No',
                      style: inputStyle.copyWith(color: darkOrangeColor),
                    )),
              ],
            ));
  }

  static Widget enrollDialog() {
    return AlertDialog(
      title: Text(
        'Enrol',
        style: inputStyle,
      ),
      content: Text(
        "You will need to enroll in this course in order to access content",
        style: inputStyle,
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text('Enroll?')),
        TextButton(onPressed: () {}, child: Text('Cancel'))
      ],
    );
  }
}
