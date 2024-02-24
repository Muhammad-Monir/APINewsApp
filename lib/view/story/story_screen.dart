import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F5F3),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F5F3),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Utils.showImage('story')],
      ),
    );
  }
}
