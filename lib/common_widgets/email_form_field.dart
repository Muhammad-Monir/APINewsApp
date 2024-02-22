import 'package:flutter/material.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField(
      {super.key,
      required this.emailController,
      required this.hintText,
      this.textInputType = TextInputType.emailAddress});

  final TextEditingController emailController;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.always,
      controller: emailController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: regularTS(formHintColor, fontSize: 16),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: Utils.scrHeight * .001, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: Utils.scrHeight * .001, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
        contentPadding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .02,
            vertical: Utils.scrHeight * .012),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                width: Utils.scrHeight * .001, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        if (!_isValidEmail(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  bool _isValidEmail(String email) {
    // Regular expression pattern for validating email addresses
    RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }
}
