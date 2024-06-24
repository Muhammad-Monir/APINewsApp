import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common_widgets/custom_divider.dart';
import '../../../utils/api_url.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/color.dart';
import '../../../utils/di.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    super.key,
    // required this.svgName,
    this.imageName,
    this.title,
    this.time,
    // this.onTap,
  });

  // final String svgName;
  final String? imageName;
  final String? title;
  final String? time;
  // final VoidCallback? onTap;

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
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageName ?? ApiUrl.imageNotFound,
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
                      // width: Utils.scrHeight * .25,
                      child: Text(title ?? '',
                          maxLines: 3,
                          textAlign: !(appData.read(kKeyLanguageId) == 4 ||
                                  appData.read(kKeyLanguageId) == 83)
                              ? TextAlign.left
                              : TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: regularTS(appTextColor, fontSize: 17)),
                    ),
                    SizedBox(height: Utils.scrHeight * .004),
                    Text(
                        DateFormat('dd MMM yyyy hh:mm a')
                            .format(DateTime.parse(time!)),
                        textAlign: !(appData.read(kKeyLanguageId) == 4 ||
                                appData.read(kKeyLanguageId) == 83)
                            ? TextAlign.left
                            : TextAlign.right,
                        style: regularTS(homeTabTextColor, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Utils.scrHeight * .010),
        const CustomDivider(),
        SizedBox(height: Utils.scrHeight * .016),
      ],
    );
  }
}
