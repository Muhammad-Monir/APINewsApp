import 'package:flutter/material.dart';

import '../../common_widgets/action_button.dart';
import '../../common_widgets/email_form_field.dart';
import '../../route/routes_name.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(Utils.scrHeight * 0.024),
          children: [
            Column(
              children: [
                Text('Forgot Password', style: largeTS(loginTextColor)),
                SizedBox(height: Utils.scrHeight * 0.022),
                Text(
                    'Please enter your email below to receive your password reset instructions.',
                    textAlign: TextAlign.center,
                    style: regularTS(loginTextColor, fontSize: 14)),
                SizedBox(
                  height: Utils.scrHeight * 0.05,
                )
              ],
            ),

            // Email Part
            _buildEmailSection(),

            // Forgot Password Button
            ActionButton(
              buttonColor: appThemeColor,
              buttonName: 'Send Email',
              onTap: () {
                Navigator.pushNamed(context, RoutesName.changePassword);
              },
            )
          ],
        ),
      ),
    );
  }

  Column _buildEmailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('EMAIL', style: mediumTS(loginTextColor)),
        SizedBox(height: Utils.scrHeight * 0.008),
        EmailFormField(
            emailController: _emailController, hintText: 'youremail@email.com'),
        SizedBox(height: Utils.scrHeight * 0.028)
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
