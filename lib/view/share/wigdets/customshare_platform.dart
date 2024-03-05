import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CustomSharePlatform extends StatelessWidget {
  const CustomSharePlatform({super.key, required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Utils.showSvgPicture(
          icon,
          height: Utils.scrHeight * .04,
          width: Utils.scrHeight * .04,
        ),
      ),
    );
  }
}