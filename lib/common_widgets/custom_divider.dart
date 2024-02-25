import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/utils.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: Utils.scrHeight * 0.001,
      color: dividerColor,
    );
  }
}