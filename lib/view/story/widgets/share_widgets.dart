
import 'package:flutter/material.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class ShareWidget extends StatelessWidget {
  final VoidCallback? onExit;
  const ShareWidget({super.key, this.onExit});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .23,
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
                  if(onExit==null) return;
                  onExit!();
                },
                child:
                const Icon(Icons.close, size: 40, color: Color(0xff9DACC3)))
          ]),
          SizedBox(height: Utils.scrHeight * .028),
          Text('Share this via',
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
