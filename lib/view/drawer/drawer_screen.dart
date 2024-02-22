import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Design'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: Utils.scrHeight * .00, vertical: Utils.scrWidth * .0),
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  // height: Utils.scrHeight * .20,
                  // width: Utils.scrWidth * .20,
                  child: Utils.showImage('pic'),
                ),
                Positioned(
                  left: 120,
                  bottom: -40,
                  child: Container(
                    child: Utils.showImage('profile_image'),
                    height: Utils.scrHeight * .096,
                    width: Utils.scrWidth * .096,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Utils.scrHeight * .050,
            ),
            CustomDrawerItem(
              onTap: () {},
              text: 'App Share',
              svgName: 'drawer_share',
              icon: Icons.arrow_forward_ios,
            ),
            CustomDrawerItem(
              onTap: () {},
              text: 'Rate this App',
              svgName: 'rating',
              icon: Icons.arrow_forward_ios,
            ),
            CustomDrawerItem(
              onTap: () {},
              text: 'Feedback',
              svgName: 'feedback',
              icon: Icons.arrow_forward_ios,
            ),
            CustomDrawerItem(
              onTap: () {},
              text: 'Contact Us',
              svgName: 'contact_us',
              icon: Icons.arrow_forward_ios,
            ),
            CustomDrawerItem(
              onTap: () {},
              text: 'Terms Of Uses',
              svgName: 'terms_of_uses',
              icon: Icons.arrow_forward_ios,
            ),
            CustomDrawerItem(
              onTap: () {},
              text: 'Privacy & Policy',
              svgName: 'privacy&policy',
              icon: Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final String svgName;
  final VoidCallback onTap;

  const CustomDrawerItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.svgName,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .016,
            vertical: Utils.scrWidth * .016),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Utils.showSvgPicture(svgName),
                SizedBox(
                  width: Utils.scrHeight * .010,
                ),
                Text(
                  text,
                  style: mediumTS(homeTabTextColor),
                ),
                const Spacer(),
                Icon(
                  icon,
                  size: Utils.scrHeight * .016,
                  color: homeTabTextColor,
                ),
              ],
            ),
            SizedBox(
              height: Utils.scrHeight * .010,
            ),
            const Divider(
              color: homeTabTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
