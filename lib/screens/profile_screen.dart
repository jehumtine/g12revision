import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_separator/easy_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_indicater.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/dialogs.dart';
import 'package:g12revision/widgets/main_button.dart';
import 'package:g12revision/widgets/menu_button.dart';
import 'package:g12revision/widgets/ui_parameters.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser!;

  CollectionReference? usersCollection;
  @override
  void initState() {
    usersCollection = FirebaseFirestore.instance.collection('users');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: purpleColor,
          title: Text('Profile', style: kHeaderTS),
          actions: [MenuButton.instance.popUpMenuBtn(context)],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: usersCollection!.doc(user!.email).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Make sure you are connected'),
                );
              } else if (snapshot.hasData) {
                final user = snapshot.data;
                return SingleChildScrollView(
                    child: user == null
                        ? Center(child: CustomIndicator.workingndIndicator)
                        : SizedBox(
                            width: UIParameters.getWidth(context),
                            height: UIParameters.getHeight(context),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(kMobileScreenPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // logo
                                  Flexible(
                                    child: SvgPicture.asset(
                                      'assets/icons/user.svg',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),

                                  Text(
                                      snapshot.data!['first name'] +
                                          " " +
                                          snapshot.data!['last name'],
                                      style: GoogleFonts.secularOne(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: darkOrangeColor)),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    snapshot.data!['email'],
                                    style: inputStyle,
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: EasySeparatedColumn(
                                      separatorBuilder: (context, idx) =>
                                          const SizedBox(
                                        height: 5,
                                      ),
                                      children: [
                                        ListTile(
                                          title: Text('Email Address',
                                              style: inputStyle),
                                          leading: const Icon(
                                            FontAwesomeIcons.envelope,
                                            size: 25,
                                            color: blackColor,
                                          ),
                                          subtitle: Text(
                                            snapshot.data!['email'],
                                            style: inputStyle,
                                          ),
                                        ),
                                        const Divider(
                                          height: 0,
                                        ),
                                        ListTile(
                                          title: Text('Country/Region',
                                              style: inputStyle),
                                          leading: const Icon(
                                            FontAwesomeIcons.flag,
                                            size: 25,
                                            color: blackColor,
                                          ),
                                          subtitle: Text(
                                            snapshot.data!['country'],
                                            style: inputStyle,
                                          ),
                                        ),
                                        const Divider(
                                          height: 0,
                                        ),
                                        ListTile(
                                          title:
                                              Text('City', style: inputStyle),
                                          leading: const Icon(
                                            FontAwesomeIcons.location,
                                            size: 25,
                                            color: blackColor,
                                          ),
                                          subtitle: Text(
                                            snapshot.data!['city'],
                                            style: inputStyle,
                                          ),
                                        ),
                                        const Divider(
                                          height: 0,
                                        ),
                                        MainButton(
                                          onPressed: () =>
                                              Dialogs.signOutDialog(context),
                                          title: 'Logout',
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )));
              } else {
                return CustomIndicator.circularIndicator;
              }
            }));
  }
}
