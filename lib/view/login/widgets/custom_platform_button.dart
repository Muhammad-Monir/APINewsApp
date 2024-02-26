import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../../../utils/utils.dart';

class PlatformButton extends StatelessWidget {
  const PlatformButton({super.key, required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Utils.scrHeight * .065,
        width: Utils.scrHeight * .065,
        padding: EdgeInsets.all(Utils.scrHeight * .02),
        margin: EdgeInsets.only(right: Utils.scrHeight * .02),
        decoration:  BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(10.0, 10.0), //(x,y)
                blurRadius: 10.0,
              ),
            ]
        ),
        child: SvgPicture.asset('assets/icons/$icon.svg', fit: BoxFit.contain),
      )
    );
  }
}