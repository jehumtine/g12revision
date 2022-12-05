import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:g12revision/widgets/app_colors.dart';
import '../screens/tab_view.dart';
import '../screens/welcome_screen.dart';

class AuthController extends GetxController {
// instance of Auth controller found everywhere
  static AuthController instance = Get.put(AuthController());
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  // isLoading
  var isLoading = false.obs;
  final _user = Rxn<User>();
  // User? user = FirebaseAuth.instance.currentUser!;

  // signup
  void signUp(
      String emailController,
      String password,
      GlobalKey<FormState> signUpFormKey,
      String firstname,
      lastname,
      city,
      country) async {
    late FirebaseAuth auth = FirebaseAuth.instance;
    final isValid = signUpFormKey.currentState!.validate();
    if (isValid) return;
    isLoading.value = true;
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController, password: password)
          .then((value) => FirebaseFirestore.instance
                  .collection('users')
                  .doc(emailController)
                  .set({
                'email': value.user!.email,
                'first name': firstname,
                'last name': lastname,
                'city': city,
                'country': country,
                'coursesPaymentsDate': {
                  'Chemistry': 0,
                  'Physics': 0,
                  "Biology": 0,
                  'Mathematics': 0,
                }
              }));

      Get.offAll(() => const TabView());
      Fluttertoast.showToast(msg: 'Welcome ${auth.currentUser!.email}');
      isLoading.value = false;
      // catch error
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      // firebase auth error messages
      errorMessages(e.message.toString());
    }
  }

  // sign in
  void signIn(String emailController, String password,
      GlobalKey<FormState> signUpFormKey) async {
    late FirebaseAuth auth = FirebaseAuth.instance;
    final isValid = signUpFormKey.currentState!.validate();
    if (isValid) return;
    isLoading.value = true;
    try {
      await auth
          .signInWithEmailAndPassword(
              email: emailController, password: password)
          .then((value) {});
      Get.to(() => const TabView());
      Fluttertoast.showToast(msg: 'Welcome back ${auth.currentUser!.email}');
      isLoading.value = false;
      // catch error
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      // firebase auth error messages
      errorMessages(e.message.toString());
    }
  }

  // reset
  void reset(String emailController, GlobalKey<FormState> resetFormKey) async {
    late FirebaseAuth auth = FirebaseAuth.instance;
    final isValid = resetFormKey.currentState!.validate();
    if (isValid) return;
    isLoading.value = true;
    try {
      await auth.sendPasswordResetEmail(
        email: emailController,
      );

      Fluttertoast.showToast(
          msg: 'A password reset link has been sent to $emailController');
      isLoading.value = false;
      // catch error
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      // firebase auth error messages
      errorMessages(e.message.toString());
    }
  }

  // signout
  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();

      Get.offAll(() => const WelcomeScreen());
      Fluttertoast.showToast(msg: 'Logged out');
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      errorMessages(e.message.toString());
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  // error messages
  void errorMessages(String errorMessage) {
    // translation
    switch (errorMessage) {
      case "Given String is empty or null":
        errorMessage = "Some fields are empty";
        break;
      case "A network error (such as timeout, interrupted connection or unreachable host) has occurred.":
        errorMessage = "Network error.";
        break;
      case "Password should be at least 6 characters":
        errorMessage = "Password should be at least 6 characters.";
        break;
      case "The email address is already in use by another account.":
        errorMessage =
            "The email address is already in use by another account. please login.";
        break;
      case "The email address is badly formatted.":
        errorMessage = "The email address is badly formatted.";
        break;
      case "There is no user record corresponding to this identifier. The user may have been deleted.":
        errorMessage = "User with email does not exist.";
        break;

      default:
        errorMessage =
            "An error happened. Please make sure you have active internet connection.";
    }
    Fluttertoast.showToast(msg: errorMessage);
  }
}
