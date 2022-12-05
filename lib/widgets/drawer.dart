import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/auth_controller.dart';
import 'package:g12revision/controllers/links_controller.dart';
import 'package:g12revision/screens/profile_screen.dart';
import 'package:g12revision/screens/settings_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/dialogs.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: purpleColor,
        child: SingleChildScrollView(
          child: Column(
            children: [buildheader(context), buildItems(context)],
          ),
        ),
      );

  Widget buildheader(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: kMobileScreenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Transcended Institute',
                style: googleStyle.copyWith(color: whiteColor, fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/icons/logo1.png',
              width: 60,
              height: 60,
            ),
          ],
        ),
      );
  Widget buildItems(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(kMobileScreenPadding),
        child: Column(
          children: [
            ListTile(
                onTap: () => Get.to(() => const ProfileScreen()),
                title: Text(
                  'Profile',
                  style: googleStyle.copyWith(color: whiteColor),
                ),
                leading: const Icon(
                  Icons.person,
                  size: 20,
                  color: whiteColor,
                )),
            ListTile(
              onTap: () => LinkController.instance.shareApp(),
              title: Text(
                'Share App',
                style: googleStyle.copyWith(color: whiteColor),
              ),
              leading: const Icon(
                Icons.share,
                size: 20,
                color: whiteColor,
              ),
            ),
            ListTile(
                onTap: () => LinkController.instance.update(),
                title: Text(
                  'Rate Us',
                  style: googleStyle.copyWith(color: whiteColor),
                ),
                leading: const Icon(
                  Icons.star,
                  size: 20,
                  color: whiteColor,
                )),
            //

            ListTile(
                onTap: () => LinkController.instance.openPlayStore(),
                title: Text(
                  'More Apps',
                  style: googleStyle.copyWith(color: whiteColor),
                ),
                leading: const Icon(
                  Icons.message_outlined,
                  size: 20,
                  color: whiteColor,
                )
                // subtitle: Text(year ?? ''),
                ),
            ListTile(
                onTap: () => Get.to(() => const SettingsScreen()),
                title: Text(
                  'Settings',
                  style: googleStyle.copyWith(color: whiteColor),
                ),
                leading: const Icon(
                  Icons.settings,
                  size: 20,
                  color: whiteColor,
                )
                // subtitle: Text(year ?? ''),
                ),
            ListTile(
                onTap: () => Dialogs.signOutDialog(context),
                title: Text(
                  'Logout',
                  style: googleStyle.copyWith(color: whiteColor),
                ),
                leading: const Icon(
                  Icons.logout,
                  size: 20,
                  color: whiteColor,
                )
                // subtitle: Text(year ?? ''),
                ),
          ],
        ),
      );
}
