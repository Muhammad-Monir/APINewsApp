
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dot Point Widget
        Container(
          margin: EdgeInsets.only(top: Utils.scrHeight * .008),
          width: Utils.scrHeight * .005,
          height: Utils.scrHeight * .005,
          decoration:
              const BoxDecoration(color: appTextColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: Utils.scrHeight * .4,
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: title,
              style: mediumTS(appTextColor, fontSize: 16),
              children: [
                TextSpan(
                  text: subtitle,
                  style: mediumTS(homeTabTextColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
