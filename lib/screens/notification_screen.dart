import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/menu_button.dart';

import '../widgets/custom_indicater.dart';
import '../widgets/shimmers.dart';
import '../widgets/ui_parameters.dart';

class NotificationScreen extends StatefulWidget {
  final bool showAppBar;
  const NotificationScreen({Key? key, required this.showAppBar})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Stream<QuerySnapshot> notificationStream;

  @override
  void initState() {
    notificationStream =
        FirebaseFirestore.instance.collection('notifications').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar == true
          ? AppBar(
              backgroundColor: purpleColor,
              title: Text(
                'Notifications',
                style: kHeaderTS,
              ),
              actions: [MenuButton.instance.popUpMenuBtn(context)],
            )
          : null,
      body: SizedBox(
        width: UIParameters.getWidth(context),
        height: UIParameters.getHeight(context),
        child: Padding(
          padding: const EdgeInsets.all(kMobileScreenPadding),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: StreamBuilder<QuerySnapshot>(
                    stream: notificationStream,
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
                          final docId = snapshot.data!.docs[idx].id;
                          return Card(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: darkOrangeColor),
                                borderRadius:
                                    BorderRadius.circular(kCardBorderrRadius)),
                            child: ListTile(
                              leading: const Icon(
                                Icons.notifications,
                                color: darkOrangeColor,
                                size: 30,
                              ),
                              onTap: () {},
                              contentPadding:
                                  const EdgeInsets.all(kMobileScreenPadding),
                              title: Text(data['title'], style: googleStyle),
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
            ],
          ),
        ),
      ),
    );
  }
}
