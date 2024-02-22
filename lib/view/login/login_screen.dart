import 'package:am_innn/common_widgets/action_button.dart';
import 'package:am_innn/common_widgets/email_form_field.dart';
import 'package:am_innn/common_widgets/password_form_field.dart';
import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:am_innn/view/login/widgets/custom_platform_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            Text('Welcome Back!',
                style: semiBoldTS(loginTextColor, fontSize: 24)),
            Text('Let’s get you logged in so you can start exploring',
                style: regularTS(loginWelcomeColor, fontSize: 14)),
            SizedBox(height: Utils.scrHeight * .03),

            // Email Form Field Part
            _buildEmailPart(),

            // Password Form Field Part
            _buildPasswordPart(),

            // Forgot Password Part
            _buildForgotPassword(),
            SizedBox(height: Utils.scrHeight * .03),

            // Login Button
            const ActionButton(
                buttonColor: appThemeColor, buttonName: 'Log In'),
            SizedBox(height: Utils.scrHeight * .03),

            // Or Login Other Platform
            _buildLoginOtherPlatform(),

            // Create Account Part
            _buildRegisterPart()
          ],
        ),
      ),
    );
  }

  Row _buildRegisterPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account?  ",
          style: mediumTS(loginWelcomeColor),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, RoutesName.register);
          },
          child: Text(
            "Register",
            style: mediumTS(const Color(0xff2E8540), isUnderline: true),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Column _buildLoginOtherPlatform() {
    return Column(
      children: [
        Center(
            child: Text('Or Log in with',
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

  GestureDetector _buildForgotPassword() {
    return GestureDetector(
      child: Text('Forgot Password?',
          textAlign: TextAlign.end,
          style: regularTS(const Color(0xff2E8540),
              fontSize: 14, isUnderline: true)),
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
        SizedBox(height: Utils.scrHeight * .01),
      ],
    );
  }

  Column _buildEmailPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address or Mobile Number',
            style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        EmailFormField(
            emailController: _emailController,
            hintText: 'Enter email or Mobile Number'),
        SizedBox(height: Utils.scrHeight * .02),
      ],
    );
  }
}
