import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class CustomCategoryItems extends StatelessWidget {
  const CustomCategoryItems({
    Key? key,
    required this.title,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : categoryColor,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .014),
        ),
        child: Text(
          title,
          style: semiBoldTS(
            isSelected ? Colors.white : appThemeColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}