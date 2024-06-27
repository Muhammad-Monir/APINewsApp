import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../common_widgets/custom_divider.dart';
import '../../../utils/api_url.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/color.dart';
import '../../../utils/di.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem({
    super.key,
    required this.svgName,
    this.imageName,
    this.title,
    this.time,
    this.onTap,
  });

  final String svgName;
  final String? imageName;
  final String? title;
  final String? time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Parse the input timestamp
    DateTime utcDateTime = DateTime.parse(time!);

    // Get the IST time zone
    final ist = tz.getLocation('Asia/Kolkata');

    // Convert the UTC time to IST
    final istDateTime = tz.TZDateTime.from(utcDateTime, ist);

    // Format the date with time zone information
    DateFormat formatter = DateFormat('dd MMM yyyy hh:mm a');
    String formattedDate = formatter.format(istDateTime);
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
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageName!,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Image.network(ApiUrl.imageNotFound),
                  ),
                )),
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
                      child: Text(title ?? '',
                          maxLines: 3,
                          textAlign: !(appData.read(kKeyLanguageId) == 4 ||
                                  appData.read(kKeyLanguageId) == 83)
                              ? TextAlign.left
                              : TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: regularTS(appTextColor, fontSize: 15.sp)),
                    ),
                    SizedBox(height: Utils.scrHeight * .004),
                    Text(formattedDate,
                        // DateFormat('dd MMM yyyy HH:MM a')
                        //     .format(DateTime.parse(time!)),
                        textAlign: !(appData.read(kKeyLanguageId) == 4 ||
                                appData.read(kKeyLanguageId) == 83)
                            ? TextAlign.left
                            : TextAlign.right,
                        style: regularTS(homeTabTextColor, fontSize: 13.sp)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Utils.showSvgPicture(svgName,
                  height: Utils.scrHeight * .020,
                  width: Utils.scrHeight * .016),
            )
          ],
        ),
        SizedBox(height: Utils.scrHeight * .010),
        const CustomDivider(),
        SizedBox(height: Utils.scrHeight * .016),
      ],
    );
  }
}
