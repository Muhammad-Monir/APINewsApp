import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.buttonName,
    this.onTap,
    this.width,
    this.buttonColor,
    this.textColor,
  });

  final String buttonName;
  final VoidCallback? onTap;
  final double? width;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: Utils.scrHeight * .052,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .015),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              buttonName,
              style: semiBoldTS(
                  textColor ?? Colors.white, // Convert Color to int value
                  fontSize: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
