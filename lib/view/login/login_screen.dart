// ignore_for_file: unnecessary_null_comparison, unused_element
import 'dart:developer';
import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/data/social_login_auth_data/social_auth_data.dart';
import 'package:am_innnn/view/login/widgets/custom_platform_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/action_button.dart';
import '../../common_widgets/email_form_field.dart';
import '../../common_widgets/password_form_field.dart';
import '../../route/routes_name.dart';
import '../../services/notification_service.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

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
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: Utils.scrHeight * .024,
                    vertical: Utils.scrHeight * .12),
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                    // child: Text(
                    //   'LOGO',
                    //   style: largeTS(loginTextColor, fontSize: 64),
                    // ),
                  ),

                  SizedBox(height: Utils.scrHeight * .012),
                  Center(
                    child: Text('Welcome to quikkbyte !',
                        style: semiBoldTS(loginTextColor, fontSize: 24)),
                  ),
                  Center(
                    child: Text('Simple and emphasizes global reach',
                        style: regularTS(loginWelcomeColor, fontSize: 14)),
                  ),
                  SizedBox(height: Utils.scrHeight * .03),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Center(
                        child: Text(
                      'Login With',
                      style: TextStyle(fontSize: 16),
                    )),
                  ),

                  // Email Form Field Part
                  // _buildEmailPart(),

                  // Password Form Field Part
                  // _buildPasswordPart(),

                  // Forgot Password Part
                  // _buildForgotPassword(),
                  // SizedBox(height: Utils.scrHeight * .03),

                  // Login Button
                  // loginButton(),
                  // SizedBox(height: Utils.scrHeight * .03),

                  // Or Login Other Platform
                  _buildLoginOtherPlatform(),

                  // Create Account Part
                  // _buildRegisterPart()
                ],
              ),
              Positioned.fill(
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, value, child) {
                    return value
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox
                            .shrink(); // You can change Container() to any other widget you want to display when not loading
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Consumer<AuthenticationProvider> loginButton() {
    return Consumer<AuthenticationProvider>(
        builder: (context, provider, child) {
      return ActionButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              final email = _emailController.text;
              final password = _passwordController.text;
              Provider.of<AuthenticationProvider>(context, listen: false)
                  .login(email, password, context)
                  .then((value) {
                LocalNotificationService.getToken();
                log('*********auth is calling');
                // Provider.of<NewsProvider>(context, listen: false).clearList();
                // Provider.of<StoryProvider>(context, listen: false).clearList();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, RoutesName.home, (route) => false);
              });
            }
          },
          buttonColor: appThemeColor,
          buttonName: 'Log In');
    });
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
        // Center(
        //     child: Text('Or Log in with',
        //         style: regularTS(const Color(0xff858E92), fontSize: 14))),
        SizedBox(height: Utils.scrHeight * .02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformButton(
              onTap: () async {
                isLoading.value = true;
                await SocialAuthData.signInWithGoogle(context).then((value) {
                  isLoading.value = false;
                }).then((user) {
                  if (user != null) {
                    log('log in and navigate to home');
                    Navigator.pushNamed(context, RoutesName.home);
                    // Utils.showSnackBar(context, user.email!);
                    // log('\nUser: ${user.displayName}');
                    // log('\nUserAdditionalInfo: ${user.email}');
                  }
                });
              },
              icon: 'google',
            ),
            // PlatformButton(
            //   icon: 'twitter',
            //   onTap: () {
            //     SocialAuthData.signInWithTwitter();
            //   },
            // ),
            // PlatformButton(
            //   onTap: () {
            //     FacebookAuthData().signInWithFacebook().then((user) {
            //       if (user != null) {
            //         ToastUtil.showLongToast(
            //             '\nUser: ${user.user!.displayName}');
            //         ToastUtil.showLongToast('\nUser: ${user.user!.email}');
            //         log('\nUser: ${user.user!.displayName}');
            //         log('\nUserAdditionalInfo: ${user.user!.email}');
            //       }
            //     });
            //   },
            //   icon: 'facebook',
            // ),
            PlatformButton(
              onTap: () async {
                isLoading.value = true;
                await SocialAuthData.signInWithApple(context).then((value) {
                  isLoading.value = false;
                }).then((user) {
                  if (user != null) {
                    log('log in and navigate to home');
                    Navigator.pushNamed(context, RoutesName.home);
                    // Utils.showSnackBar(context, user.email!);
                    // log('\nUser: ${user.displayName}');
                    // log('\nUserAdditionalInfo: ${user.email}');
                  }
                });
              },
              icon: 'apple',
            ),
          ],
        ),
        SizedBox(height: Utils.scrHeight * .02)
      ],
    );
  }

  GestureDetector _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.forgotPassword);
      },
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
        Text('Email Address', style: regularTS(loginTextColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        EmailFormField(
            emailController: _emailController, hintText: 'Enter email'),
        SizedBox(height: Utils.scrHeight * .02),
      ],
    );
  }
}
