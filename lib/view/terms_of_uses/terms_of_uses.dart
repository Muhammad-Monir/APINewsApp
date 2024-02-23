import 'package:am_innn/common_widgets/custom_divider.dart';
import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:flutter/material.dart';

class TermsOfUses extends StatelessWidget {
  const TermsOfUses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms Of Uses',
          style: semiBoldTS(appTextColor, fontSize: 24),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .024,
            vertical: Utils.scrHeight * .01),
        children: [
          Text(
            'Last Update: 10 January, 2024',
            style: regularTS(appSecondTextColor),
          ),
          SizedBox(height: Utils.scrHeight * .01),
          const CustomDivider(),
          SizedBox(height: Utils.scrHeight * .016),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: regularTS(homeTabTextColor, fontSize: 14)),
          SizedBox(
            height: Utils.scrHeight * .016,
          ),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: regularTS(homeTabTextColor, fontSize: 14)),
          SizedBox(height: Utils.scrHeight * .016),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: regularTS(homeTabTextColor, fontSize: 14)),
          SizedBox(height: Utils.scrHeight * .016),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: regularTS(homeTabTextColor, fontSize: 14)),
        ],
      ),
    );
  }
}
