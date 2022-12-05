import 'package:flutter/material.dart';

const kMobileScreenPadding = 16.0;
const kButtonCornerRadius = 10.0;
const kCardBorderrRadius = 11.0;

// ignore: avoid_classes_with_only_static_members
class UIParameters {
  static BorderRadius get cardBorderRadius =>
      BorderRadius.circular(kCardBorderrRadius);
  static EdgeInsets get screenPadding =>
      const EdgeInsets.all(kMobileScreenPadding);

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
