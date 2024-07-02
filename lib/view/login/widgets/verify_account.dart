// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:flutter/material.dart';

import '../../../data/auth_data.dart';
import '../../../route/routes_name.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthenticationProvider _authProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: Utils.scrHeight * .02,
              vertical: Utils.scrHeight * .016),
          children: [
            Column(children: [
              Text('Please Verify Account', style: largeTS(loginTextColor)),
              SizedBox(height: Utils.scrHeight * 0.022),
              Text(
                  'Enter the digit code we send to your email address to verify your account',
                  textAlign: TextAlign.center,
                  style: regularTS(loginTextColor, fontSize: 14)),
              SizedBox(height: Utils.scrHeight * 0.048)
            ]),
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'OTP',
                hintStyle: regularTS(loginTextColor, fontSize: 16),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: Utils.scrHeight * .001,
                        color: Colors.grey.shade300),
                    borderRadius:
                        BorderRadius.circular(Utils.scrHeight * .015)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: Utils.scrHeight * .001,
                        color: Colors.grey.shade300),
                    borderRadius:
                        BorderRadius.circular(Utils.scrHeight * .015)),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Utils.scrHeight * .02,
                    vertical: Utils.scrHeight * .016),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: Utils.scrHeight * .001,
                        color: Colors.grey.shade300),
                    borderRadius:
                        BorderRadius.circular(Utils.scrHeight * .015)),
              ),
            ),
            SizedBox(height: Utils.scrHeight * .06),
            ActionButton(
              onTap: () {
                _verifyAccount();
              },
              buttonColor: appThemeColor,
              buttonName: 'Verify Account',
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyAccount() async {
    if (_formKey.currentState!.validate()) {
      final String enteredOtp = _otpController.text;
      try {
        final Map<String, dynamic>? result = await _authProvider.accountVerify(
            email: widget.email, otp: enteredOtp);

        if (result != null && result["status"] == true) {
          // Account verification successful
          Utils.showSnackBar(context, 'Account Verify Successful');
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (route) => false,
          );
        } else {
          Utils.showSnackBar(context,
              'Account Verification Failed. Please check your OTP and try again.');
        }
      } catch (e) {
        log('Account verification failed with an exception: $e');
        Utils.showSnackBar(
            context, 'Account Verification Failed. Please try again.');
      }
    } else {
      Utils.showSnackBar(context, 'Please enter a valid OTP.');
    }
  }
}
