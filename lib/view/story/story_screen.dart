import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Back', style: mediumTS(appBarColor, fontSize: 20))),
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .1),
        ),
        onPressed: () {},
        child: Container(
          child: Utils.showSvgPicture('share'),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
