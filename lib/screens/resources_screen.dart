import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/pay_controller.dart';
import 'package:g12revision/screens/pdf_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/loadinig_shimmer.dart';
import 'package:g12revision/widgets/shimmers.dart';

import '../widgets/ui_parameters.dart';

class ResourcesScreen extends StatefulWidget {
  final String courseId;
  final String imgUrl;
  final String title;
  final String amount;
  final bool showAppbar;

  const ResourcesScreen(
      {super.key,
      required this.courseId,
      required this.imgUrl,
      required this.showAppbar,
      required this.title,
      required this.amount});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen>
    with AutomaticKeepAliveClientMixin {
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

  Future<void> resolvepay(BuildContext context, String amount, String title,
      name, solutionUrl) async {
    final User? _user = FirebaseAuth.instance.currentUser;
    print(title);
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
                    'Loading your solution....',
                    style: googleStyle.copyWith(color: blackColor),
                  )
                ],
              ),
            ),
          );
        });
    final coursesRef =
        FirebaseFirestore.instance.collection('users').doc(_user!.email).get();

    var newt = await coursesRef.then((snapshot) => snapshot);

    //check if the timestamp is 0, then go to payment page
    if (newt["coursesPaymentsDate"][widget.title] == 0) {
      Navigator.of(context).pop();
      PayController.instance.pay(amount, widget.title);
    } else {
      //check if the expiry date is passed
      Timestamp t = newt["coursesPaymentsDate"][widget.title];
      DateTime expiry = t.toDate();
      DateTime today = DateTime.now();
      //if expiry is passed update to 0 then go to payments page
      if (today.isAfter(expiry)) {
        print("Nigga You done");
        Navigator.of(context).pop();
        var firestore = FirebaseFirestore.instance
            .collection('users')
            .doc(_user.email)
            .update({
          'coursesPaymentsDate.$widget.title': 0,
        });
        Fluttertoast.showToast(msg: 'Your Subscription Has Expired');
      } else {
        Navigator.of(context).pop();
        Get.to(() => PdfScreen(
              url: solutionUrl,
              id: name,
            ));
      }
      //print(newt["coursesPaymentsDate"][title]);
      //print(expiry);
      //String expiryDate = newr[title].toString();
      //print(expiryDate);
      //PayController.instance.pay(amount, title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIParameters.getWidth(context),
      height: UIParameters.getHeight(context),
      child: Stack(children: [
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
                            return Card(
                              child: ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          kCardBorderrRadius),
                                      child: const Icon(
                                        FontAwesomeIcons.question,
                                        color: redColor,
                                      )),
                                  onTap: () => Get.to(
                                        () => PdfScreen(
                                          id: data['name'],
                                          url: data['pdfQuestionUrl'],
                                        ),
                                      ),
                                  title: Text(
                                    data['name'] + ' Resourse',
                                    style: googleStyle,
                                  ),
                                  subtitle: Text(data['description'],
                                      style: inputStyle),
                                  trailing: InkWell(
                                      onTap: () {
                                        // resove payments for solution
                                        resolvepay(
                                            context,
                                            widget.amount,
                                            data["name"],
                                            '${widget.title} Solution',
                                            data['pdfSolutionUrl']);
                                      },
                                      child: const Icon(
                                          FontAwesomeIcons.userGraduate))),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ]),
    );
    ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
