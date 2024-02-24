import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .36,
      width: Utils.scrHeight * .542,
      padding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .024, vertical: Utils.scrHeight * .028),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Share', style: mediumTS(appTextColor, fontSize: 24)),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child:
                    const Icon(Icons.close, size: 40, color: Color(0xff9DACC3)))
          ]),
          SizedBox(height: Utils.scrHeight * .028),
          Text('Share this app via',
              style: mediumTS(tabBarDividerColor, fontSize: 16)),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Utils.scrHeight * .02,
                  vertical: Utils.scrHeight * .016),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomSharePlatform(icon: 'facebook2'),
                    CustomSharePlatform(icon: 'instagram'),
                    CustomSharePlatform(icon: 'linkedin'),
                    CustomSharePlatform(icon: 'threats'),
                    CustomSharePlatform(icon: 'telegram'),
                  ])),
          SizedBox(height: Utils.scrHeight * .02),
          Text('Or copy link',
              style: mediumTS(tabBarDividerColor, fontSize: 16)),
          SizedBox(height: Utils.scrHeight * .012),
          Container(
            height: Utils.scrHeight * .05,
            width: Utils.scrHeight * .35,
            padding: EdgeInsets.symmetric(
                horizontal: Utils.scrHeight * .008,
                vertical: Utils.scrHeight * .008),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Utils.scrHeight * .012),
                border: Border.all(
                    color: const Color(0xffC7DDFF),
                    width: Utils.scrHeight * .001)),
            child: Row(
              children: [
                Text('https://yourapplink.com',
                    style: regularTS(tabBarDividerColor, fontSize: 16)),
                const Spacer(),
                GestureDetector(
                  child: Container(
                    height: Utils.scrHeight * .048,
                    width: Utils.scrHeight * .06,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Utils.scrHeight * .01),
                        color: appThemeColor),
                    child: Text('Copy',
                        textAlign: TextAlign.center,
                        style: mediumTS(Colors.white, fontSize: 14)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomSharePlatform extends StatelessWidget {
  const CustomSharePlatform({super.key, required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Utils.showSvgPicture(
          icon,
          height: Utils.scrHeight * .04,
          width: Utils.scrHeight * .04,
        ),
      ),
    );
  }
}
