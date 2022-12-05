import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/pay_controller.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/ui_parameters.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/menu_button.dart';
import '../widgets/shimmers.dart';
import 'tab_view.dart';
import 'web_screen.dart';

class CoursesScreen extends StatelessWidget {
  final String? categoryId;
  final String? courseId;
  CoursesScreen({super.key, this.categoryId, this.courseId});
  final keya = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: Text(
            'Courses',
            style: kHeaderTS,
          ),
          actions: [
            IconButton(
                onPressed: () => Get.offAll(() => const TabView()),
                icon: const Icon(
                  FontAwesomeIcons.house,
                  size: 20,
                  color: whiteColor,
                )),
            IconButton(
                onPressed: () => Get.to(
                      () => const WebScreen(
                        showAppbar: true,
                        url: 'https://www.youtube.com/c/g12revision',
                        name: 'Channel',
                      ),
                    ),
                icon: const Icon(
                  FontAwesomeIcons.youtube,
                  color: whiteColor,
                )),
            MenuButton.instance.popUpMenuBtn(context)
          ],
        ),
        body: SizedBox(
          width: UIParameters.getWidth(context),
          height: UIParameters.getHeight(context),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // bottom container
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(kMobileScreenPadding),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('home')
                            .doc(categoryId)
                            .collection('category')
                            .doc(courseId)
                            .collection('courses')
                            .snapshots(),
                        builder: (context, snapshot) {
                          // handle snapshot error
                          if (!snapshot.hasData) {
                            return const QuizScreenPlaceHolder();
                          }

                          return MasonryGridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int idx) {
                              // load data
                              final data = snapshot.data!.docs[idx];
                              //   final docId = snapshot.data!.docs[idx].id;
                              return Card(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: darkOrangeColor),
                                    borderRadius: BorderRadius.circular(
                                        kCardBorderrRadius)),
                                child: ListTile(
                                  onTap: () {
                                    PayController.instance
                                        .pay(data['amount'], data['name']);
                                  },
                                  contentPadding: const EdgeInsets.all(10),
                                  title: Text(data['name'] + '\n',
                                      style: googleStyle),
                                  subtitle: Text(
                                    data['des'],
                                    style: inputStyle,
                                  ),
                                ),
                              );
                            },
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                          );
                        }),
                  ),
                ),
              ]),
        ));
  }
}
