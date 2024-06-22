// ignore_for_file: unused_field

import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../route/routes_name.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/toast_util.dart';
import '../utils/utils.dart';

class DeletePopup extends StatefulWidget {
  const DeletePopup({super.key});

  @override
  State<DeletePopup> createState() => _DeletePopupState();
}

class _DeletePopupState extends State<DeletePopup> {
  final String? _authToken = appData.read(kKeyToken);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 300,
      padding: const EdgeInsets.only(
        top: 35,
        left: 35,
        right: 35,
        bottom: 38,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          SizedBox(height: Utils.scrHeight * .02),
          SizedBox(
            child: Text('Are you sure you want to Delete your account?',
                textAlign: TextAlign.center,
                style: mediumTS(homeTabTextColor, fontSize: 20)),
          ),
          SizedBox(height: Utils.scrHeight * .02),
          ActionButton(
            buttonName: 'Delete',
            buttonColor: const Color(0xffFFCFCC),
            textColor: const Color(0xffFF3B30),
            onTap: () {
              Provider.of<AuthenticationProvider>(context, listen: false)
                  .deleteUser(appData.read(kKeyToken))
                  .then((value) {
                appData.remove(kKeyUserID);
                appData.remove(kKeyToken);
                appData.write(kKeyIsLoggedIn, false);
                ToastUtil.showShortToast('Your Account Deleted Successfully');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.home,
                  (route) => false,
                );
              });
              // _deleteAccount();
            },
          ),
          SizedBox(height: Utils.scrHeight * .02),
          ActionButton(
            buttonName: 'Cancle',
            buttonColor: const Color(0xffFFCFCC),
            textColor: const Color(0xffFF3B30),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // void _deleteAccount() async {
  //   await _authProvider.profileDelete(_authToken!).then((value) {
  //     appData.remove(kKeyUserID);
  //     appData.remove(kKeyToken);
  //     appData.write(kKeyIsLoggedIn, false);
  //     ToastUtil.showShortToast('Your Account Deleted Successfully');
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       RoutesName.home,
  //       (route) => false,
  //     );
  //   });
  // }
}
