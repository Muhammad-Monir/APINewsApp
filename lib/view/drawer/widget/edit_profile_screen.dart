// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/common_widgets/email_form_field.dart';
import 'package:am_innnn/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/user_data.dart';
import '../../../route/routes_name.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? localImagePath;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserData _userData = UserData();
  late String _authToken = '';

  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the session data exists
    String? authToken = prefs.getString('token');
    setState(() {
      _authToken = authToken!;
    });
  }

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Profile',
              style: mediumTS(appTextColor, fontSize: 24))),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: Utils.scrHeight * .02,
              vertical: Utils.scrHeight * .014),
          children: [
            buildImageSection(),
            SizedBox(height: Utils.scrHeight * .02),
            EmailFormField(
                validate: true,
                textInputType: TextInputType.text,
                emailController: _nameController,
                hintText: 'Input your name'),
            SizedBox(height: Utils.scrHeight * .06),
            ActionButton(
              onTap: () {
                _updateProfile();
              },
              width: Utils.scrHeight * .25,
              buttonName: 'Update Profile',
              buttonColor: appThemeColor,
            )
          ],
        ),
      ),
    );
  }

  Container buildImageSection() {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          SizedBox(
            height: Utils.scrHeight * .2,
            width: Utils.scrHeight * .2,
            child: localImagePath == null
                ? const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(
                      'assets/images/profile_image.png',
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Container(
                        height: Utils.scrHeight * .3,
                        width: Utils.scrHeight * .3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(File(localImagePath!)),
                                fit: BoxFit.cover)))),
          ),
          Positioned(
            left: Utils.scrHeight * .15,
            top: Utils.scrHeight * .15,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  _getImage();
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xffF9EEEF),
                  radius: 20,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 30,
                    color: appThemeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getImage() async {
    final imageSource = await showModalBottomSheet<ImageSource>(
      scrollControlDisabledMaxHeightRatio: double.infinity,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: Utils.scrHeight * .04),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, ImageSource.camera); // Fixed here
                },
                child: const Column(
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        size: 40, color: Colors.blue),
                    Text('Take a photo',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: const Column(
                  children: [
                    Icon(Icons.photo, size: 40, color: Colors.blue),
                    Text('Choose from gallery',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (imageSource != null) {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          localImagePath = pickedFile.path;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    // if (localImagePath == null) {
    //   Utils.showSnackBar(context, 'Select Profile Picture');
    //   return;
    // }

      final userName = _nameController.text;

      try {
        final Map<String, dynamic>? response = await _userData.updateProfile(
          userName: userName,
          image: localImagePath,
          authToken: _authToken,
        );

        if (response != null) {
          Utils.showSnackBar(context, 'Profile updated successfully');
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
        } else {
          Utils.showSnackBar(context, 'Failed to update profile');
        }
      } catch (error) {
        Utils.showSnackBar(context, 'Error: $error');
      }
  }
}
