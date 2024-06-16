import 'package:am_innnn/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';

class CustomTabBar extends StatelessWidget {
  final VoidCallback? startOnTap;
  final VoidCallback? homeOnTap;
  final VoidCallback? refreshOnTap;

  const CustomTabBar({
    super.key,
    this.startOnTap,
    this.homeOnTap,
    this.refreshOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: Utils.scrHeight * .024,
        vertical: Utils.scrHeight * .02,
      ),
      color: Colors.white,
      height: Utils.scrHeight * .11,
      child: Column(
        children: [
          SizedBox(height: Utils.scrHeight * .043),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(onTap: homeOnTap, child: const HomeTabBar()),
              GestureDetector(
                  onTap: refreshOnTap, child: const RefreshTabBar()),
              GestureDetector(onTap: startOnTap, child: const StartTabBar()),
            ],
          ),
        ],
      ),
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
