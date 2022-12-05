import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/pay_controller.dart';

import 'package:g12revision/screens/video_player_screen.dart';

import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/loadinig_shimmer.dart';
import 'package:g12revision/widgets/main_button.dart';
import 'package:g12revision/widgets/shimmers.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

import '../widgets/app_colors.dart';

class LessonsScreen extends StatefulWidget {
  final String courseId;
  final String title;
  final String amount;
  String imgUrl;
  LessonsScreen(
      {super.key,
      required this.courseId,
      required this.imgUrl,
      required this.amount,
      required this.title});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen>
    with AutomaticKeepAliveClientMixin {
  Future<void> resolvepay(
      BuildContext context,
      String amount,
      String title,
      String url,
      String name,
      topic,
      courseid,
      solutionUrl,
      pdfQuestionUrl) async {
    //final User? _user = FirebaseAuth.instance.currentUser;
    //print(title);
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CustomIndicator.circularIndicator,
                  const SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text(
                    'Loading your paper....',
                    style: googleStyle.copyWith(
                        color: blackColor, fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
          );
        });

    Navigator.of(context).pop();
    Get.to(() => VideoPlayerScreen(
          url: url,
          name: name,
          topic: topic,
          courseId: widget.title,
          pdfQuestionUrl: pdfQuestionUrl,
          pdfSolutionUrl: solutionUrl,
        ));
  }

  late Stream<QuerySnapshot> stream;
  @override
  void initState() {
    stream = FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.title)
        .collection("papers")
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIParameters.getWidth(context),
      height: UIParameters.getHeight(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kMobileScreenPadding - 9,
              right: kMobileScreenPadding - 9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const QuizScreenPlaceHolder();
                        }
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, idx) {
                              final data = snapshot.data!.docs[idx];
                              final topic = snapshot.data!.docs[idx].id;
                              return Card(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        kCardBorderrRadius),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: widget.imgUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    resolvepay(
                                        context,
                                        widget.amount,
                                        data["name"],
                                        data['solutionVideoUrl'],
                                        data['name'],
                                        topic,
                                        widget.courseId,
                                        data['solutionVideoUrl'],
                                        data['questionsPdfUrl']);

                                    // logo
                                  },
                                  title: Text(data['name'], style: googleStyle),
                                  /*subtitle: Text(data['topicdescription'],
                                      style: inputStyle),*/
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }

  @override
  bool get wantKeepAlive => true;
}
