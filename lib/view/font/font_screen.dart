import 'package:am_innn/common_widgets/custom_divider.dart';
import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/font_size_provider.dart';

class FontScreen extends StatelessWidget {
  const FontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Font Size', style: mediumTS(appBarColor, fontSize: 24)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .024,
            vertical: Utils.scrHeight * .021),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FontSizeRadioButton(
              label: 'Small',
              fontSize: 1.0,
            ),
            FontSizeRadioButton(
              label: 'Medium',
              fontSize: 1.1,
            ),
            FontSizeRadioButton(
              label: 'Large',
              fontSize: 1.2,
            ),
          ],
        ),
      ),
    );
  }
}

class FontSizeRadioButton extends StatelessWidget {
  final String label;
  final double? fontSize;

  const FontSizeRadioButton({
    super.key,
    required this.label,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Container(
      padding: EdgeInsets.all(Utils.scrHeight * .012),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              fontSizeProvider.setFontSize(fontSize ?? 20);
            },
            child: Row(
              children: [
                Text(label, style: regularTS(tabBarDividerColor, fontSize: 20)),
                const Spacer(),
                Radio(
                  value: fontSize,
                  groupValue: fontSizeProvider.fontSize,
                  onChanged: (value) {
                    fontSizeProvider.setFontSize(value as double);
                  },
                  hoverColor: appThemeColor,
                  activeColor: appThemeColor,
                ),
              ],
            ),
          ),
          const CustomDivider()
        ],
      ),
    );
  }
}
