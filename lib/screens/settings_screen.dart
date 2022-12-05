import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g12revision/screens/web_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

import '../controllers/links_controller.dart';
import '../widgets/menu_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: purpleColor,
        title: Text('Settings', style: kHeaderTS),
        actions: [MenuButton.instance.popUpMenuBtn(context)],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: UIParameters.getWidth(context),
          height: UIParameters.getHeight(context),
          child: Padding(
            padding: const EdgeInsets.all(kMobileScreenPadding),
            child: EasySeparatedColumn(
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              children: [
                // image

                // main content
                Flexible(
                  child: Image.asset(
                    'assets/icons/logo1.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                Flexible(
                    child: Text('Transcended Institute',
                        style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: darkOrangeColor))),

                Text(
                  """
      Transcended institute specializes in provision of High quality Online Lessons that include Live Lessons.""",
                  style: inputStyle,
                  textAlign: TextAlign.center,
                ),

                //
                SizedBox(
                  child: EasySeparatedColumn(
                    separatorBuilder: (context, idx) => const SizedBox(
                      height: 10,
                    ),
                    children: [
                      ListTile(
                          onTap: () => Get.to(() => const WebScreen(
                              url: 'https://g12revision.com/',
                              name: 'Our Website')),
                          title: Text('Go to website', style: inputStyle),
                          leading: const Icon(FontAwesomeIcons.airbnb,
                              size: 20, color: darkOrangeColor)),
                      ListTile(
                          onTap: () => LinkController.instance.email(),
                          title: Text(
                            'Email us',
                            style: inputStyle,
                          ),
                          leading: const Icon(FontAwesomeIcons.envelope,
                              size: 20, color: darkOrangeColor)),
                      ListTile(
                          onTap: () => Get.to(() => const WebScreen(
                              url: 'https://www.facebook.com/TRASCENDED',
                              name: 'Our Facebook Page')),
                          title: Text('Visit our facebook page',
                              style: inputStyle),
                          leading: const Icon(FontAwesomeIcons.facebook,
                              size: 20, color: darkOrangeColor)),
                      ListTile(
                          onTap: () => LinkController.instance.openPlayStore(),
                          title: Text('Rate our app', style: inputStyle),
                          leading: const Icon(FontAwesomeIcons.star,
                              size: 20, color: darkOrangeColor)),
                      ListTile(
                          onTap: () => LinkController.instance.privacyPolicy(),
                          title: Text('Privacy Policy', style: inputStyle),
                          leading: const Icon(FontAwesomeIcons.shield,
                              size: 20, color: darkOrangeColor)),
                      ListTile(
                          onTap: () => Get.to(() => const WebScreen(
                              url: 'https://g12revision.com/about-us/',
                              name: 'About us')),
                          title: Text('About us', style: inputStyle),
                          leading: const Icon(FontAwesomeIcons.info,
                              size: 20, color: darkOrangeColor)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
