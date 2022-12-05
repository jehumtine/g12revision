import 'package:flutter/material.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';

class CustomIndicator {
  static Widget circularIndicator = const CircularProgressIndicator(
    color: darkOrangeColor,
  );

  static Widget workingndIndicator = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const CircularProgressIndicator(
        color: darkOrangeColor,
      ),
      const SizedBox(
        height: 10,
      ),
      // text
      Text(
        'Working',
        style: inputStyle.copyWith(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        'Getting services.....',
        style: inputStyle.copyWith(
            fontSize: 18, fontWeight: FontWeight.bold, color: greyColor),
      )
    ],
  );
   static Widget passwordResset = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const CircularProgressIndicator(
        color: darkOrangeColor,
      ),
      const SizedBox(
        height: 10,
      ),
      // text
      Text(
        'Working',
        style: inputStyle.copyWith(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        'Sending link.....',
        style: inputStyle.copyWith(
            fontSize: 18, fontWeight: FontWeight.bold, color: greyColor),
      )
    ],
  );
  static Widget signingIndicator = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const CircularProgressIndicator(
        color: darkOrangeColor,
      ),
      const SizedBox(
        height: 10,
      ),
      // text
      Text(
        'Working',
        style: inputStyle.copyWith(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        'Signing you in.....',
        style: inputStyle.copyWith(
            fontSize: 18, fontWeight: FontWeight.bold, color: greyColor),
      )
    ],
  );
}
