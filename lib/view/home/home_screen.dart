import 'dart:math' as math;
import 'dart:math';
import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:am_innn/view/home/widgets/home_news_widgets.dart';
import 'package:am_innn/view/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';
import 'package:provider/provider.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/color.dart';
import '../drawer/drawer_screen.dart';
import '../share/share_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  // final PageController newsPageController = PageController(initialPage: 0);
  final PageController storyPageController = PageController();
  final _controller = GlobalKey<PageFlipWidgetState>();
  late PageController newsPageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    newsPageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
        duration: const Duration(microseconds: 100)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      // Hide able BottomNavigationMenu
      bottomNavigationBar: Provider.of<BarsVisibility>(context).showBars
          ? _bottomNavigationMenu(context)
          : null,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          // All news with Vertical Scroll view



          PageView.builder(
            controller: newsPageController,
            allowImplicitScrolling: true,
            pageSnapping: true,
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  double value = 1.0;
                  if (newsPageController.position.hasContentDimensions) {
                    value = newsPageController.page! - index;
                    value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                  }
                  double rotationAngle = value != 0 ? math.pi * value : 0.0; // Rotate only if value is not 0
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Apply perspective
                      ..rotateY(_animationController.value * math.pi),
                      // ..setEntry(3, 0, 0.0001),// perspective
                      // ..rotateX(rotationAngle),
                      // ..translate(0.0, 0.0, -200.0 * value), // Apply perspective translation
                    alignment: FractionalOffset.center,
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
                return const StoryScreen();
              }),
        ],
      ),

      // Showing Floating Add Banner
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            right: Utils.scrHeight * .054,
            left: Utils.scrHeight * .054,
            bottom: Utils.scrHeight * .01),
        child: GestureDetector(
          child: SizedBox(
            width: double.infinity,
            height: Utils.scrHeight * .054,
            child: Image.asset(
              'assets/images/floating_add.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
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
              getPopUp(
                  context,
                  (p0) => ShareScreen(onExit: () {
                        Navigator.pop(p0);
                      }));
            }
          },
        );
      }),
    );
  }

  void getPopUp(
    BuildContext context,
    Widget Function(BuildContext) childBuilder,
  ) {
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
