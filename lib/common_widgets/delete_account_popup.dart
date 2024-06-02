import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class WelComePopup extends StatelessWidget {
  const WelComePopup({super.key});

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
            child: Text('Are You Sure Want to Delete You Account',
                textAlign: TextAlign.center,
                style: mediumTS(homeTabTextColor, fontSize: 20)),
          ),
          SizedBox(height: Utils.scrHeight * .02),
          ActionButton(
            buttonName: 'Delete',
            buttonColor: const Color(0xffFFCFCC),
            textColor: const Color(0xffFF3B30),
            onTap: () {},
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
}
