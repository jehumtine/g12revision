import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g12revision/controllers/pay_controller.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/main_button.dart';
import 'package:g12revision/widgets/shimmers.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

class SavedCoursesScreen extends StatelessWidget {
  final bool? showAppbar;

  const SavedCoursesScreen({Key? key, this.showAppbar}) : super(key: key);
  Future<void> resolvepay(String amount, String title) async {
    final User? _user = FirebaseAuth.instance.currentUser;
    final coursesRef =
        FirebaseFirestore.instance.collection('users').doc(_user!.email).get();

    var newt = await coursesRef.then((snapshot) => snapshot);

    //check if the timestamp is 0, then go to payment page
    if (newt["coursesPaymentsDate"][title] == 0) {
      PayController.instance.pay(amount, title);
    } else {
      //check if the expiry date is passed
      Timestamp t = newt["coursesPaymentsDate"][title];
      DateTime expiry = t.toDate();
      DateTime today = DateTime.now();
      //if expiry is passed update to 0 then go to payments page
      if (today.isAfter(expiry)) {
        print("Nigga You done");
        var firestore = FirebaseFirestore.instance
            .collection('users')
            .doc(_user.email)
            .update({
          'coursesPaymentsDate.$title': 0,
        });
        PayController.instance.pay(amount, title);
      } else {
        print("Its all good nigga");
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
    return Scaffold(
        backgroundColor: Colors.grey[50],
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
                            .collection('courses')
                            .snapshots(),
                        builder: (context, snapshot) {
                          // handle snapshot error
                          if (!snapshot.hasData) {
                            return const QuizScreenPlaceHolder();
                          }

                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int idx) {
                              // load data
                              final data = snapshot.data!.docs[idx];
                              //   final docId = snapshot.data!.docs[idx].id;
                              return ListTile(
                                leading: Image.asset(
                                  'assets/icons/logo1.png',
                                  width: 40,
                                  height: 40,
                                ),
                                trailing: Text(
                                  data['category'],
                                  style: googleStyle.copyWith(color: redColor),
                                ),
                                tileColor: whiteColor,
                                onTap: () {
                                  Get.bottomSheet(Container(
                                      color: whiteColor,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                height: 200,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/bk.jpg'),
                                                  fit: BoxFit.cover,
                                                )),
                                                width: UIParameters.getWidth(
                                                    context),
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/icons/logo1.png',
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Flexible(
                                            //     child:
                                            //         const SizedBox(height: 10)),
                                            MainButton(
                                              onPressed: () {
                                                resolvepay(data['amount'],
                                                    data['title']);
                                              },
                                              title: 'Purchase this course',
                                            ),
                                          ]))); // logo
                                },
                                contentPadding: const EdgeInsets.all(10),
                                title: Text(data['title'], style: googleStyle),
                                subtitle: Text(
                                  data['description'],
                                  style: inputStyle,
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ),
              ]),
        ));
  }
}
