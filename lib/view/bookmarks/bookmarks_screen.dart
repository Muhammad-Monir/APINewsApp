
import 'package:am_innnn/view/bookmarks/widgets/bookmark_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/bookmark_provider.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
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
            return Consumer<BookmarkProvider>(
              builder: (context, provider, child) {
                return BookmarkItem(
                  onTap: () {
                    provider.toggleBookMarkColor();
                  },
                    svgName: provider.isFavorite ? 'selected_bookmark' : 'bookmark',
                    imageName: 'bookmark_banner',
                    title:
                        'Launched on international day for girls and women in science',
                    time: '12 Minutes ago');
              }
            );
          },
        ));
  }
}



