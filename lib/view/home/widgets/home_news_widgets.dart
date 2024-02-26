import 'dart:async';
import 'package:am_innn/provider/bookmark_provider.dart';
import 'package:am_innn/provider/font_size_provider.dart';
import 'package:am_innn/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../provider/timer_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class NewsScreen extends StatelessWidget {
  final VoidCallback? startOnTap;
  final VoidCallback? homeOnTap;

  const NewsScreen({
    super.key,
    this.startOnTap, this.homeOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerScreen(),
      body: GestureDetector(
        onTap: () {
          Provider.of<BarsVisibility>(context, listen: false).toggleBars();
          if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
            Timer(const Duration(seconds: 5), () {
              Provider.of<BarsVisibility>(context, listen: false).hideBars();
            });
          }
        },
        child: Consumer<FontSizeProvider>(builder: (context, fontSize, child) {
          return Column(
            children: [
              // Top Banner Image
              _imageBanner(context),

              // News Section
              _newsSection(fontSize)
            ],
          );
        }),
      ),
    );
  }

  Container _newsSection(FontSizeProvider fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Utils.scrHeight * .02,
        horizontal: Utils.scrHeight * .024,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Utils.scrHeight * .027),
          SizedBox(
            // width: Utils.scrHeight * .342,
            child: Text(
              'Special ‘Aastha’ train to Ayodhya flagged off from Goa',
              style: semiBoldTS(appTextColor, fontSize: 19 * fontSize.fontSize),
            ),
          ),
          SizedBox(height: Utils.scrHeight * .02),
          SizedBox(
            height: Utils.scrHeight * .25,
            child: ListView(
              clipBehavior: Clip.none,
              padding: EdgeInsets.zero,
              children: [
                Text(
                  'A special “Aastha” train carrying around 2,000 pilgrims to Ayodhya in Uttar Pradesh has been flagged off from Goa.\n Chief Minister Pramod Sawant, state BJP president Sadanand Shet Tanavade and other MLAs were present at the flagging off ceremony held on Monday evening at Thivim railway station in North Goa district.\n\n',
                  style: regularTS(appSecondTextColor,
                      fontSize: 15 * fontSize.fontSize),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Utils.scrHeight * .04,
          ),
          socialLinkSection(),
          SizedBox(height: Utils.scrHeight * .02),
        ],
      ),
    );
  }

  SizedBox socialLinkSection() {
    return SizedBox(
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
                  GestureDetector(
                    onTap: () => _launchURL('https://indianexpress.com/'),
                    child: Text('https://indianexpress.com/',
                        style: regularTS(appThemeColor, fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        );
  }

  // Function to launch the URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Stack _imageBanner(
    BuildContext context,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Top Image Section
        topImageSection(),

        // Home Screen Top Tab Bar
        Provider.of<BarsVisibility>(context).showBars
            ? buildTabBar()
            : Container(),

        // Promo Code
        Positioned(
          bottom: -Utils.scrHeight * .01,
          left: Utils.scrHeight * .05,
          child: _buildPromoCode(),
        ),

        // BookMark Button
        Consumer<BookmarkProvider>(
          builder: (context, provider, child) {
            return Positioned(
              top: Utils.scrHeight * .1,
                right: Utils.scrHeight * .02,
                child: GestureDetector(
                  onTap: (){
                    provider.toggleBookMarkColor();
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: Container(
                                width: Utils.scrHeight * .04,
                                height: Utils.scrHeight * .04,
                                padding: const EdgeInsets.all(8),
                                decoration: ShapeDecoration(
                  color: provider.isFavorite ? Colors.white.withOpacity(0) : Colors.white.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: Utils.scrHeight * .001,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                                ),
                                child: provider.isFavorite ? Utils.showSvgPicture('bookmarks', height: Utils.scrHeight * .020) : Utils.showSvgPicture('selected_bookmark', height: Utils.scrHeight * .020),
                              ),
                ));
          }
        )
      ],
    );
  }

  Container topImageSection() {
    return Container(
          height: Utils.scrHeight * .335,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Utils.scrHeight * .12))),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Utils.scrHeight * .03),
                  bottomRight: Radius.circular(Utils.scrHeight * .03)),
              child: Image.asset(
                'assets/images/banner_image.png',
                fit: BoxFit.cover,
              )));
  }

  Container buildTabBar() {
    return Container(
              padding: EdgeInsets.symmetric(
                horizontal: Utils.scrHeight * .024,
              ),
              color: Colors.white,
              height: Utils.scrHeight * .09,
              child: Column(
                children: [
                  SizedBox(height: Utils.scrHeight * .045),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: homeOnTap,
                          child: const HomeTabBar()),
                      const RefreshTabBar(),
                      GestureDetector(
                          onTap: startOnTap, child: const StartTabBar()),
                    ],
                  ),
                ],
              ),
            );
  }

  Container _buildPromoCode() {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .01),
          // width: Utils.scrHeight * .14,
          // height: 66,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: redContainerColor),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text('ABCDEFGHI',
              style: mediumTS(redContainerColor, fontSize: 20)),
        );
  }
}

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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

class RefreshTabBar extends StatelessWidget {
  const RefreshTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          children: [
            Utils.showSvgPicture(
              'refresh',
              height: Utils.scrHeight * .022,
              width: Utils.scrHeight * .022,
            ),
            SizedBox(width: Utils.scrHeight * .006),
            Text('Refresh', style: regularTS(homeTabTextColor, fontSize: 15)),
            SizedBox(width: Utils.scrHeight * .013),
            Text('|', style: regularTS(tabBarDividerColor, fontSize: 14))
          ],
        ),
      ),
    );
  }
}

class UnreadTabBar extends StatelessWidget {
  const UnreadTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          children: [
            Utils.showSvgPicture(
              'unread',
              height: Utils.scrHeight * .022,
              width: Utils.scrHeight * .022,
            ),
            SizedBox(width: Utils.scrHeight * .006),
            Text('Unread', style: regularTS(homeTabTextColor, fontSize: 15)),
            SizedBox(width: Utils.scrHeight * .013),
            Text('|', style: regularTS(tabBarDividerColor, fontSize: 14))
          ],
        ),
      ),
    );
  }
}

class StartTabBar extends StatelessWidget {
  const StartTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          children: [
            Utils.showSvgPicture(
              'start',
              height: Utils.scrHeight * .022,
              width: Utils.scrHeight * .022,
            ),
            SizedBox(width: Utils.scrHeight * .006),
            Text('Start', style: regularTS(homeTabTextColor, fontSize: 15)),
            SizedBox(width: Utils.scrHeight * .013),
          ],
        ),
      ),
    );
  }
}
