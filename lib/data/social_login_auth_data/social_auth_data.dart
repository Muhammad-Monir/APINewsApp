// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:am_innnn/data/auth_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../utils/toast_util.dart';

class SocialAuthData {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      await InternetAddress.lookup('google.com');

      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      // ToastUtil.showLongToast(authResult.toString());
      if (authResult.user != null) {
        Provider.of<AuthenticationProvider>(context, listen: false).socialLogin(
            authResult.user!.email!,
            authResult.user!.displayName!,
            authResult.credential!.accessToken!,
            'google',
            context);
        // ToastUtil.showLongToast('Login Sussessfully');
      }
      log("google sing in info$authResult");
      // Return the current user
      return authResult.user;
    } catch (error) {
      ToastUtil.showLongToast(error.toString());
      log(error.toString());
      return null;
    }
  }

  // static Future<void> signInWithTwitter() async {
  //   TwitterAuthProvider twitterProvider = TwitterAuthProvider();

  //   if (kIsWeb) {
  //     await FirebaseAuth.instance.signInWithPopup(twitterProvider);
  //   } else {
  //     await FirebaseAuth.instance.signInWithProvider(twitterProvider);
  //   }
  // }

  static Future<User?> signInWithApple(BuildContext context) async {
    try {
      // Trigger the Apple Sign In flow
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create a new credential
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Once signed in, return the UserCredential
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.user != null) {
        Provider.of<AuthenticationProvider>(context, listen: false).socialLogin(
            authResult.user!.email!,
            authResult.user!.displayName ?? '',
            appleCredential.authorizationCode,
            'apple',
            context);
      }

      log("Apple sign in info: $authResult");
      // Return the current user
      return authResult.user;
    } catch (error) {
      ToastUtil.showLongToast(error.toString());
      log(error.toString());
      return null;
    }
  }

  static final TwitterLogin twitterLogin = TwitterLogin(
      apiKey: 'f5sqyyJGNPQIYdKvHcDPFXX6G',
      apiSecretKey: 'N52pPIpI0zE1xAswBvNpAmE4E1UQjsN2OnDUgsNLjCd1sVTITt',
      redirectURI: '');

  static Future signInWithTwitter() async {
    final authResult = await twitterLogin.login();
    if (authResult.status == TwitterLoginStatus.loggedIn) {
      try {
        final credential = TwitterAuthProvider.credential(
            accessToken: authResult.authToken!,
            secret: authResult.authTokenSecret!);
        await _auth.signInWithCredential(credential);

        final userDetails = authResult.user;
        ToastUtil.showShortToast(userDetails!.name);
        // save all the data
        // final name = userDetails!.name;
        // final email = _auth.currentUser!.email;
        // final imageUrl = userDetails.thumbnailImage;
        // final uid = userDetails.id.toString();
        // final provider = "TWITTER";
        // final hasError = false;
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
