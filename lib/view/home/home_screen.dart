import 'dart:math';

import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/timer_provider.dart';
import '../../route/routes_name.dart';
import '../../utils/color.dart';
import '../../utils/utils.dart';
import '../drawer/drawer_screen.dart';
import '../story/story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.category});

  final List<String>? category;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // final PageController newsPageController = PageController(initialPage: 0);
  final PageController storyPageController = PageController();

  // Animation Property
  late Animation<double> flipAnim;
  late PageController newsPageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(microseconds: 100), // Adjust animation duration
      vsync: this,
    );

    flipAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.slowMiddle,
    ));

    newsPageController = PageController();

    newsPageController.addListener(() {
      if (newsPageController.page != null) {
        _animationController.value = (newsPageController.page! % 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      // // Hide able BottomNavigationMenu
      // bottomNavigationBar: Provider.of<BarsVisibility>(context).showBars
      //     ? _bottomNavigationMenu(context)
      //     : null,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          // All news with Vertical Scroll view
          PageView.builder(
            controller: newsPageController,
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: flipAnim,
                builder: (context, child) {
                  return Transform(
                      // transform: Matrix4.identity()
                      //   ..setEntry(0, 3, 0.003)
                      // // ..setEntry(0, 2, 0.003)
                      // // ..setEntry(0, 2, 0.003)
                      // // ..setEntry(0, 2, 0.003)
                      //   ..rotateX(-flipAnim.value * (3.14 / 2)),
                      // alignment: FractionalOffset.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(0, 2, 0.001)
                        ..rotateX(2 * pi * flipAnim.value),
                      alignment: Alignment.center,

                    child: SizedBox(
                      child: NewsScreen(
                          homeOnTap: () => Scaffold.of(context).openDrawer(),
                          startOnTap: () {
                            newsPageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                    ),
                  );
                },
              );
            },
          ),


          // PageView.builder(
          //   controller: newsPageController,
          //   allowImplicitScrolling: true,
          //   pageSnapping: true,
          //   scrollDirection: Axis.vertical,
          //   itemCount: 5,
          //   itemBuilder: (context, index) {
          //     return AnimatedBuilder(
          //       animation: newsPageController,
          //       builder: (context, child) {
          //         double value = 1.0;
          //         if (newsPageController.position.hasContentDimensions) {
          //           value = newsPageController.page! - index;
          //           value = (1 - (value.abs() * 0.5)).clamp(0.2, 1.0);
          //         }
          //         // Calculate opacity based on the value
          //         // double opacity = value.clamp(0.0, 1.0);
          //         // Calculate the scaling factor for the height and width
          //         double scaleFactor = Curves.easeInOut.transform(value);
          //         return Transform.scale(
          //           alignment: AlignmentDirectional.center,
          //           scale: scaleFactor,
          //           // scale: max(1 - (newsPageController.page! - index ), .5 ),
          //           child: SizedBox(
          //             child: NewsScreen(
          //               homeOnTap: () => Scaffold.of(context).openDrawer(),
          //               startOnTap: () {
          //                 newsPageController.animateToPage(
          //                   0,
          //                   duration: const Duration(milliseconds: 500),
          //                   curve: Curves.easeInOut,
          //                 );
          //               },
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),

          // PageView.builder(
          //     controller: newsPageController,
          //     // allowImplicitScrolling: true,
          //     // pageSnapping: true,
          //     scrollDirection: Axis.vertical,
          //     itemCount: 5,
          //     itemBuilder: (context, index) {
          //       // News Screen
          //       return NewsScreen(
          //         homeOnTap: () => Scaffold.of(context).openDrawer(),
          //         startOnTap: (){
          //           newsPageController.animateToPage(
          //             0,
          //             duration: const Duration(milliseconds: 500),
          //             curve: Curves.easeInOut,
          //           );
          //         },
          //       );
          //     }),

          // All Story for swipe horizontally


          PageView.builder(
              controller: storyPageController,
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                Provider.of<BarsVisibility>(context).hideBars();
                return const StoryScreen();
              }),
        ],
      ),
    );
  }

  Theme _bottomNavigationMenu(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      child: Consumer<BottomNavigationProvider>(
          builder: (context, provider, child) {
            return BottomNavigationBar(
              selectedLabelStyle: const TextStyle(color: appSecondTextColor),
              unselectedLabelStyle: const TextStyle(color: appSecondTextColor),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Utils.showSvgPicture('search',
                      height: Utils.scrHeight * 0.024,
                      width: Utils.scrHeight * 0.024),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Utils.showSvgPicture('font',
                      height: Utils.scrHeight * 0.024,
                      width: Utils.scrHeight * 0.024),
                  label: 'Font',
                ),
                BottomNavigationBarItem(
                  icon: Utils.showSvgPicture('bookmark',
                      height: Utils.scrHeight * 0.024,
                      width: Utils.scrHeight * 0.024),
                  label: 'BookMark',
                ),
                BottomNavigationBarItem(
                  icon: provider.selectedIndex == 3
                      ? Utils.showSvgPicture('share',
                      height: Utils.scrHeight * 0.024,
                      width: Utils.scrHeight * 0.024)
                      : Utils.showSvgPicture('share',
                      height: Utils.scrHeight * 0.024,
                      width: Utils.scrHeight * 0.024),
                  label: 'Share',
                ),
              ],
              useLegacyColorScheme: false,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: provider.selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                provider.updateSelectedIndex(index);
                if (provider.selectedIndex == 0) {
                  Navigator.pushNamed(context, RoutesName.search);
                } else if (provider.selectedIndex == 1) {
                  Navigator.pushNamed(context, RoutesName.font);
                } else if (provider.selectedIndex == 2) {
                  Navigator.pushNamed(context, RoutesName.bookmark);
                } else if (provider.selectedIndex == 3) {
                  shareContent();
                  // getPopUp(
                  //     context,
                  //     (p0) => ShareScreen(onExit: () {
                  //           Navigator.pop(p0);
                  //         }));
                }
              },
            );
          }),
    );
  }

  void shareContent() async {
    try {
      await Share.share('https://flutter.dev/');
    } catch (e) {
      Utils.showSnackBar(context, '$e');
    }
  }


  void getPopUp(BuildContext context,
      Widget Function(BuildContext) childBuilder,) {
    showDialog(
        context: context,
        barrierDismissible: true, // Prevent dismissal by tapping outside
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent, // Optional customization
            // insetPadding: EdgeInsets.only(bottom: Utils.scrHeight * .08),
            child: childBuilder(context),
          );
        });
  }

  @override
  void dispose() {
    newsPageController.dispose();
    storyPageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
