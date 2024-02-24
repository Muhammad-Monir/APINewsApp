import 'package:flutter/material.dart';
import '../../common_widgets/action_button.dart';
import '../../common_widgets/password_form_field.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../feedback/widgets/custom_welcome_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _resetCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
            _buildResetCodeSection(),

            // New Password Part
            _buildNewPasswordSection(),

            // Confirm Password Part
            _buildConfirmPasswordSection(),

            // Change Password Part
            ActionButton(
              buttonColor: appThemeColor,
              buttonName: 'Change Password',
              onTap: () {
                getPopUp(
                    context,
                    (p0) => const CustomWelcomeScreen(
                          title: 'Congrats!',
                          description:
                              'You have successfully change password.Please use the new password when logging in.',
                        ));
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
            // insetPadding: EdgeInsets.only(bottom: Utils.scrHeight * .08),
            child: childBuilder(context),
          );
        });
  }
}
