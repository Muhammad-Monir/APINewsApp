import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/custom_divider.dart';
import '../../../provider/bookmark_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem({
    super.key,
    required this.svgName,
    required this.imageName,
    required this.title,
    required this.time,
  });

  final String svgName;
  final String imageName;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: Utils.scrHeight * .1,
                width: Utils.scrHeight * .09,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(Utils.scrHeight * .008),
                    child: Utils.showImage(imageName))),
            SizedBox(width: Utils.scrHeight * .01),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: Utils.scrHeight * .016),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Utils.scrHeight * .25,
                      child: Text(title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: semiBoldTS(appTextColor, fontSize: 17)),
                    ),
                    SizedBox(height: Utils.scrHeight * .004),
                    Text(time,
                        style: regularTS(homeTabTextColor, fontSize: 13)),
                  ],
                ),
              ),
            ),
            Consumer<BookmarkProvider>(builder: (context, color, _) {
              return GestureDetector(
                onTap: () {
                  color.toggleBookMarkColor();
                },
                child: color.isFavorite
                    ? Utils.showSvgPicture('selected_bookmark',
                    height: Utils.scrHeight * .020)
                    : Utils.showSvgPicture(svgName,
                    height: Utils.scrHeight * .020,
                    width: Utils.scrHeight * .016),
              );
            }),
          ],
        ),
        SizedBox(height: Utils.scrHeight * .010),
        const CustomDivider(),
        SizedBox(height: Utils.scrHeight * .016),
      ],
    );
  }
}