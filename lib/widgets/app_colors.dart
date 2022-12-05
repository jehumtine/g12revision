import 'package:flutter/material.dart';

const darkPurple = Color(0xff9f27f5);
const lightPurple = Color(0xff895fc5);
const whiteColor = Colors.white;
const blackColor = Colors.black87;
const darkYellow = Color(0xfffcbc3e);
const containerColor = Color(0xfff2f2f7);
const pinkColor = Color.fromARGB(173, 236, 77, 93);
const darkOrangeColor = Color(0xfffb8b2c);
const redColor = Color(0xffFF0000);
const facebookColor = Color.fromARGB(255, 96, 160, 184);
const whatsappColor = Color(0xff25D366);
const navColor = Color(0xfff2f2f7);
const lightYellow = Color(0xfffbdb5b);
const blueColor = Color(0xffececfb);
const backGroundColor = Color.fromARGB(250, 244, 243, 243);
// used
const greyColor = Colors.grey;
const greenColor = Color(0xff06ca40);
const purpleColor = Color.fromARGB(255, 1, 1, 114);
// main gradient pattern for light theme
const mainGradientLT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      darkPurple,
      lightPurple,
    ]);

LinearGradient mainGradient(BuildContext context) => mainGradientLT;
