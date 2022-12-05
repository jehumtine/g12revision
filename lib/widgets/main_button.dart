import 'package:flutter/material.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';

class MainButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  final Widget? widget;
  const MainButton({Key? key, required this.onPressed, this.title, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: darkOrangeColor,
          minimumSize: const Size(200, 40), //////// HERE
        ),
        onPressed: onPressed,
        child: title == null ? widget : Text(title!, style: inputStyle));
  }
}
