// ignore_for_file: use_build_context_synchronously, unused_element

import 'dart:developer';

import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/view/change_password/widgets/reset_popup.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/action_button.dart';
import '../../common_widgets/password_form_field.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.emailOtp});

  final CombineEmailOtp emailOtp;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _resetCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthProvider _authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(Utils.scrHeight * 0.024),
          children: [
            Column(children: [
              Text('Change Password', style: largeTS(loginTextColor)),
              SizedBox(height: Utils.scrHeight * 0.022),
              Text(
                  'Reset code was sent to your email. Please enter the code and create new password.',
                  textAlign: TextAlign.center,
                  style: regularTS(loginTextColor, fontSize: 14)),
              SizedBox(height: Utils.scrHeight * 0.048)
            ]),

            // Reset Code Part
            // _buildResetCodeSection(),

            // New Password Part
            _buildNewPasswordSection(),

            // Confirm Password Part
            _buildConfirmPasswordSection(),

            // Change Password Part
            ActionButton(
              buttonColor: appThemeColor,
              buttonName: 'Change Password',
              onTap: () {
                _changePassword();
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildConfirmPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CONFIRM PASSWORD', style: mediumTS(loginTextColor)),
        SizedBox(height: Utils.scrHeight * 0.008),
        PasswordFormField(
            passwordController: _confirmPasswordController,
            hintText: '* * * * * * * *'),
        SizedBox(height: Utils.scrHeight * 0.024)
      ],
    );
  }

  Column _buildNewPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NEW PASSWORD', style: mediumTS(loginTextColor)),
        SizedBox(height: Utils.scrHeight * 0.008),
        PasswordFormField(
            passwordController: _newPasswordController,
            hintText: '* * * * * * * *'),
        SizedBox(height: Utils.scrHeight * 0.024)
      ],
    );
  }

  Column _buildResetCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RESET CODE', style: mediumTS(loginTextColor)),
        SizedBox(height: Utils.scrHeight * 0.008),
        TextFormField(
          controller: _resetCodeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'OTP',
            hintStyle: regularTS(loginTextColor, fontSize: 16),
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
                vertical: Utils.scrHeight * .016),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: Utils.scrHeight * .001, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(Utils.scrHeight * .015)),
          ),
        ),
        SizedBox(height: Utils.scrHeight * 0.024)
      ],
    );
  }

  @override
  void dispose() {
    _resetCodeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void getPopUp(
    BuildContext context,
    Widget Function(BuildContext) childBuilder,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true, // Prevent dismissal by tapping outside
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent, // Optional customization
            child: childBuilder(context),
          );
        });
  }

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final String email = widget.emailOtp.email;
      final String uniqueString = widget.emailOtp.uniqueString;
      final String newPassword = _newPasswordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      try {
        final Map<String, dynamic>? result = await _authProvider.resetPassword(
          email: email,
          uniqueString: uniqueString,
          password: newPassword,
          confirmPassword: confirmPassword,
        );

        if (result != null) {
          if (result["status"] == false) {
            // Handle error
            Map<String, dynamic> errors = result['message'];
            errors.forEach((field, messages) {
              Utils.showSnackBar(context, '$field: ${messages[0]}');
            });
          } else {
            // Handle success
            Utils.showSnackBar(context, 'Password reset successful');
            Navigator.pop(context); // Close the current screen
            getPopUp(
              context,
              (p0) => const ResetPopup(),
            );
            // You can navigate to a success screen or take other actions here
          }
        } else {
          Utils.showSnackBar(
            context,
            'Failed to reset password. Please try again.',
          );
        }
      } catch (e) {
        log('Error: $e');
        Utils.showSnackBar(
          context,
          'Failed to reset password. Please try again.',
        );
      }
    }
  }
}

class CombineEmailOtp {
  String email, uniqueString;

  CombineEmailOtp({required this.email, required this.uniqueString});
}
