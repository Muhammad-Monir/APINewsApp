import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              onTap: () {},
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
}
