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
        padding: EdgeInsets.all(Utils.scrHeight * .02),
        margin: EdgeInsets.only(right: Utils.scrHeight * .02),
        decoration:
        const BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
        child: SvgPicture.asset('assets/icons/$icon.svg', fit: BoxFit.cover),
      ),
    );
  }
}