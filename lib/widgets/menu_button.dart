import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';

import '../controllers/links_controller.dart';
import '../screens/settings_screen.dart';
import 'dialogs.dart';

class MenuButton extends GetxController {
  static MenuButton instance = Get.put(MenuButton());
  // pop up menu button
  popUpMenuBtn(BuildContext context) => PopupMenuButton<String>(
        onSelected: (String value) {
          switch (value) {
            case 'Share':
              LinkController.instance.shareApp();
              break;

            case 'Help':
              Dialogs.helpDialog(context);
              break;

            case 'Settings':
              Get.to(() => const SettingsScreen());
              break;
            case 'About':
              Dialogs.aboutDialog();
              break;
          }
        },
        icon: const Icon(
          FontAwesomeIcons.ellipsisVertical,
          color: whiteColor,
        ),
        itemBuilder: (BuildContext context) {
          return {'Share', 'Help', 'Settings', 'About'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice, style: cDetailsTS),
            );
          }).toList();
        },
      );
}
