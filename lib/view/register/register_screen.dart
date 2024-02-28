
import 'package:flutter/material.dart';

import '../../common_widgets/action_button.dart';
import '../../common_widgets/email_form_field.dart';
import '../../common_widgets/password_form_field.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../login/widgets/custom_platform_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: Utils.scrHeight * .024,
              vertical: Utils.scrHeight * .12),
          children: [
            Center(
                child:
                    Text('LOGO', style: largeTS(loginTextColor, fontSize: 64))),
            SizedBox(height: Utils.scrHeight * .012),
            Text('Create an Account',
                style: semiBoldTS(loginTextColor, fontSize: 24)),
            Text('Registration now to explore the app',
                style: regularTS(loginWelcomeColor, fontSize: 14)),
            SizedBox(height: Utils.scrHeight * .03),

            // Username Part
            _buildUsernamePart(),

            // Email Part
            _buildEmailPart(),

            // Password Part
            _buildPasswordPart(),

            // Repeat Password Part
            _buildRepeatPasswordPart(),

            // Register User
            const ActionButton(
                buttonColor: appThemeColor, buttonName: 'Register'),
            SizedBox(height: Utils.scrHeight * .03),

            // Register Other Platform
            _buildRegisterOtherPlatform(),
          ],
        ),
      ),
    );
  }

  Column _buildRegisterOtherPlatform() {
    return Column(
      children: [
        Center(
            child: Text('Or Register with',
                style: regularTS(const Color(0xff858E92), fontSize: 14))),
        SizedBox(height: Utils.scrHeight * .02),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformButton(icon: 'google'),
            PlatformButton(icon: 'facebook'),
            PlatformButton(icon: 'twitter'),
            PlatformButton(icon: 'apple'),
          ],
        ),
        SizedBox(height: Utils.scrHeight * .02)
      ],
    );
  }

  Column _buildRepeatPasswordPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Repeat Password', style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        PasswordFormField(
            passwordController: _repeatPasswordController,
            hintText: 'Enter password'),
        SizedBox(height: Utils.scrHeight * .046),
      ],
    );
  }

  Column _buildPasswordPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        PasswordFormField(
            passwordController: _passwordController, hintText: 'hintText'),
        SizedBox(height: Utils.scrHeight * .02),
      ],
    );
  }

  Column _buildEmailPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address or Phone Number',
            style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        EmailFormField(
            emailController: _emailController, hintText: 'Enter email'),
        SizedBox(height: Utils.scrHeight * .02)
      ],
    );
  }

  Column _buildUsernamePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username', style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        EmailFormField(
            emailController: _userNameController, hintText: 'Enter username'),
        SizedBox(height: Utils.scrHeight * .02)
      ],
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
}
