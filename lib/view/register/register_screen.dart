// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:am_innnn/route/routes_name.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/action_button.dart';
import '../../common_widgets/email_form_field.dart';
import '../../common_widgets/password_form_field.dart';
import '../../data/auth_data.dart';
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
  final _phoneNumberController = TextEditingController();
  final AuthProvider _authProvider = AuthProvider();

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

            // Phone Number
            buildPhoneNumberPart(),

            // Password Part
            _buildPasswordPart(),

            // Repeat Password Part
            _buildRepeatPasswordPart(),

            // Register User
            ActionButton(
                onTap: () {
                  _registerUser();
                },
                buttonColor: appThemeColor,
                buttonName: 'Register'),
            SizedBox(height: Utils.scrHeight * .03),

            // Register Other Platform
            // _buildRegisterOtherPlatform(),
          ],
        ),
      ),
    );
  }

  Column buildPhoneNumberPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        EmailFormField(
            textInputType: TextInputType.phone,
            emailController: _phoneNumberController,
            hintText: 'Enter Phone Number'),
        SizedBox(height: Utils.scrHeight * .02)
      ],
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
            passwordController: _passwordController,
            hintText: 'Enter password'),
        SizedBox(height: Utils.scrHeight * .02),
      ],
    );
  }

  Column _buildEmailPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address', style: regularTS(loginTextColor, fontSize: 16)),
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
            textInputType: TextInputType.text,
            emailController: _userNameController,
            hintText: 'Enter username'),
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
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final String userName = _userNameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String repeatPassword = _repeatPasswordController.text;
      final String phoneNumber = _phoneNumberController.text;

      try {
        await _authProvider
            .registerUser(
          username: userName,
          email: email,
          password: password,
          confirmPassword: repeatPassword,
          phone: phoneNumber,
        )
            .then((value) {
          Utils.showSnackBar(context, 'Registration Successful');
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => false);
        });
      } catch (e) {
        // Handle network errors or other exceptions
        log('Registration failed with an exception: $e');
        Utils.showSnackBar(context, 'Registration failed. Please try again.');
      }
    }
  }
}
