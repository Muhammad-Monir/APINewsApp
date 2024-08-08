import 'package:am_innnn/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class ToastUtil {
  ToastUtil._();
  static void showLongToast(String message) {
    String trn = message;
    Fluttertoast.showToast(
        msg: trn,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: appThemeColor);
  }

  static void showLoginToast(String message) {
    String trn = message;
    Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        fontSize: 16.sp,
        msg: trn,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red);
  }

  static void showShortToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void showNoInternetToast() {
    Fluttertoast.showToast(
      msg: "Please check your internet connection",
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
