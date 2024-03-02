import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/view/change_password/change_password_screen.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/action_button.dart';
import '../../common_widgets/email_form_field.dart';
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
                _sendMail();
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

  void _sendMail() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      try {
        final Map<String, dynamic>? result =
            await _authProvider.forgotPassword(email);

        if (result != null) {
          if (result["status"] == false) {
            Utils.showSnackBar(
                context, 'Error: ${result['message']['email'][0]}');
          } else {
            Utils.showSnackBar(
                context, 'Password reset instructions sent to $email');
            String uniqueString = result["data"]["unique_string"];
            Navigator.pushNamed(context, RoutesName.changePassword,
                arguments: CombineEmailOtp(
                    email: _emailController.text, uniqueString: uniqueString));
            // You can navigate to a success screen or take other actions here
          }
        } else {
          Utils.showSnackBar(context,
              'Failed to send password reset instructions. Please try again.');
        }
      } catch (e) {
        print('Error: $e');
        Utils.showSnackBar(context,
            'Failed to send password reset instructions. Please try again.');
      }
    }
  }
}
