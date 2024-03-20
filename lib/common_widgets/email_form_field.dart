import 'package:flutter/material.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
    required this.emailController,
    required this.hintText,
    this.textInputType = TextInputType.emailAddress,
    this.validate = true,
    this.onChanged,
    this.onFiledSubmitt, // Add a parameter to control validation
  }) : super(key: key);

  final TextEditingController emailController;
  final String hintText;
  final TextInputType textInputType;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFiledSubmitt;
  final bool validate; // New parameter to control validation

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFiledSubmitt,
      onChanged: onChanged,
      controller: emailController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: regularTS(formHintColor, fontSize: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: Utils.scrHeight * .001,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(Utils.scrHeight * .015),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: Utils.scrHeight * .001,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(Utils.scrHeight * .015),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .02,
          vertical: Utils.scrHeight * .012,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: Utils.scrHeight * .001,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(Utils.scrHeight * .015),
        ),
      ),
      validator: validate ? _getValidator(textInputType) : null,
    );
  }

  String? Function(String?) _getValidator(TextInputType type) {
    switch (type) {
      case TextInputType.emailAddress:
        return _validateEmail;
      case TextInputType.phone:
        return _validatePhoneNumber;
      default:
        return _validateText;
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!_isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\+\d+$').hasMatch(value)) {
      return 'Please enter a valid phone number with country code';
    }
    return null;
  }

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  bool _isValidEmail(String email) {
    // Regular expression pattern for validating email addresses
    RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }
}
