import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:g12revision/screens/welcome_screen.dart';
import 'package:g12revision/widgets/custom_indicater.dart';

import 'tab_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            // waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomIndicator.circularIndicator;
            }
            // error
            if (snapshot.hasError) {
              return CustomIndicator.circularIndicator;
            }
            if (snapshot.hasData) {
              return const TabView();
              //  VerifyEmailScreen();
            } else {
              return const WelcomeScreen();
            }
          }),
    );
  }
}
