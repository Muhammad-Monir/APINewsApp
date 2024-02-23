import 'dart:async';

import 'package:am_innn/view/drawer/drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/timer_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      body: GestureDetector(
        onTap: () {
          Provider.of<BarsVisibility>(context, listen: false).toggleBars();
          if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
            Timer(const Duration(seconds: 4), () {
              Provider.of<BarsVisibility>(context, listen: false).hideBars();
            });
          }
        },
        child: Column(
          children: [
            // Top Banner Image
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    height: Utils.scrHeight * .335,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(Utils.scrHeight * .12))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Utils.scrHeight * .03),
                            bottomRight:
                                Radius.circular(Utils.scrHeight * .03)),
                        child: Image.asset(
                          'assets/images/banner_image.png',
                          fit: BoxFit.cover,
                        ))),
                Provider.of<BarsVisibility>(context).showBars
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Utils.scrHeight * .024,
                        ),
                        color: Colors.white,
                        height: Utils.scrHeight * .09,
                        child: Column(
                          children: [
                            SizedBox(height: Utils.scrHeight * .045),
                            const Row(
                              children: [TabBarItem()],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Positioned(
                  bottom: -Utils.scrHeight * .01,
                  left: Utils.scrHeight * .05,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.scrHeight * .005),
                    width: Utils.scrHeight * .14,
                    // height: 66,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: redContainerColor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text('ABCDEFGHI',
                        style: mediumTS(redContainerColor, fontSize: 20)),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Utils.scrHeight * .02,
                horizontal: Utils.scrHeight * .024,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Utils.scrHeight * .027),
                  SizedBox(
                    width: Utils.scrHeight * .342,
                    child: Text(
                      'Special ‘Aastha’ train to Ayodhya flagged off from Goa',
                      style: semiBoldTS(appTextColor, fontSize: 19),
                    ),
                  ),
                  SizedBox(height: Utils.scrHeight * .02),
                  SizedBox(
                    width: 342,
                    child: Text(
                      'A special “Aastha” train carrying around 2,000 pilgrims to Ayodhya in Uttar Pradesh has been flagged off from Goa.\n Chief Minister Pramod Sawant, state BJP president Sadanand Shet Tanavade and other MLAs were present at the flagging off ceremony held on Monday evening at Thivim railway station in North Goa district.\n\n',
                      style: regularTS(appSecondTextColor, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: Utils.scrHeight * .05,
                  ),
                  SizedBox(
                    width: Utils.scrHeight * .398,
                    height: Utils.scrHeight * .02,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Source Link:',
                              style: regularTS(appTextColor, fontSize: 14),
                            ),
                            const SizedBox(width: 2),
                            Text('https://indianexpress.com/',
                                style: regularTS(appThemeColor, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Utils.scrHeight * .02),
                  GestureDetector(
                    child: SizedBox(
                      width: double.infinity,
                      height: Utils.scrHeight * .054,
                      child: Image.asset(
                        'assets/images/floating_add.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Row(
        children: [
          Utils.showSvgPicture(
            'home',
            height: Utils.scrHeight * .022,
            width: Utils.scrHeight * .022,
          ),
          SizedBox(width: Utils.scrHeight * .006),
          Text('Home', style: regularTS(homeTabTextColor, fontSize: 15)),
          SizedBox(width: Utils.scrHeight * .013),
          Text('|', style: regularTS(tabBarDividerColor, fontSize: 14))
        ],
      ),
    );
  }
}
