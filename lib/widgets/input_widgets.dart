import 'package:flutter/material.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';

class InputFields extends StatelessWidget {
  final TextInputType? inputType;
  final IconData? icon;
  final String? hintText;
  final String Function(String?)? validator;
  final TextEditingController? controller;
  final bool obsecureText;
  final FormFieldSetter<String>? onSaved;
  const InputFields(
      {Key? key,
      this.inputType,
      this.icon,
      this.hintText,
      this.validator,
      this.controller,
      this.obsecureText = false,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onSaved: onSaved,
        obscureText: obsecureText,
        cursorColor: Colors.black12,
        autofocus: false,
        validator: validator,
        controller: controller,
        keyboardType: inputType,
        style: inputStyle,
        cursorWidth: 1,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          errorStyle: inputStyle.copyWith(fontSize: 12),
          filled: true,
          fillColor: greyColor[300],
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),

          // prefix
        ));
  }
}
