import 'package:am_innnn/utils/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    required this.image,
  }) : super(key: key);

  final String title;
  final String image;
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
        child: Column(
          children: [
            SizedBox(
              // padding: EdgeInsets.symmetric(vertical: Utils.scrHeight * .01),
              height: Utils.scrHeight * .095,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Utils.scrHeight * .014),
                    topRight: Radius.circular(Utils.scrHeight * .014)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(seconds: 2),
                  imageUrl: '${ApiUrl.imageBaseUrl}$image',
                  // imageUrl: ApiUrl.imageNotFound,
                  errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Utils.scrHeight * .014),
                          topRight: Radius.circular(Utils.scrHeight * .014)),
                      child: Image.network(
                        ApiUrl.imageNotFound,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            SizedBox(height: Utils.scrHeight * .005),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: semiBoldTS(
                  isSelected ? Colors.white : appThemeColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
