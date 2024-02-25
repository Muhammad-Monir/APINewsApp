import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/view/bookmarks/widgets/bookmark_item.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bookmarks', style: largeTS(appBarColor))),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: Utils.scrHeight * .024,
              vertical: Utils.scrHeight * .024),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const BookmarkItem(
                svgName: 'bookmark',
                imageName: 'bookmark_banner',
                title:
                    'Launched on international day for girls and women in science',
                time: '12 Minutes ago');
          },
        ));
  }
}


