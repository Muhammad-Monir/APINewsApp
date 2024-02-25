import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:am_innn/view/home/widgets/home_news_widgets.dart';
import 'package:am_innn/view/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/color.dart';
import '../share/share_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController hPageController = PageController();
    final PageController vPageController = PageController();
    // Hide the status bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        bottomNavigationBar: Provider.of<BarsVisibility>(context).showBars
            ? Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: Consumer<BottomNavigationProvider>(
                    builder: (context, provider, child) {
                  return BottomNavigationBar(
                    selectedLabelStyle: const TextStyle(color: appThemeColor),
                    unselectedLabelStyle:
                        const TextStyle(color: appSecondTextColor),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon:
                            // provider.selectedIndex == 0
                            //     ? Utils.showSvgPicture('search_selected',
                            //     height: Utils.scrHeight * 0.024,
                            //     width: Utils.scrHeight * 0.024)
                            //     :
                            Utils.showSvgPicture('search',
                                height: Utils.scrHeight * 0.024,
                                width: Utils.scrHeight * 0.024),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: provider.selectedIndex == 1
                            ? Utils.showSvgPicture('selected_font',
                                height: Utils.scrHeight * 0.024,
                                width: Utils.scrHeight * 0.024)
                            : Utils.showSvgPicture('font',
                                height: Utils.scrHeight * 0.024,
                                width: Utils.scrHeight * 0.024),
                        label: 'Font',
                      ),
                      BottomNavigationBarItem(
                        icon: provider.selectedIndex == 2
                            ? Stack(
                                children: [
                                  Utils.showSvgPicture('selected_bookmark',
                                      height: Utils.scrHeight * 0.024,
                                      width: Utils.scrHeight * 0.024),
                                ],
                              )
                            : Stack(
                                children: [
                                  Utils.showSvgPicture('bookmark',
                                      height: Utils.scrHeight * 0.024,
                                      width: Utils.scrHeight * 0.024),
                                ],
                              ),
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
              )
            : null,
        body: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            PageView.builder(
                controller: hPageController,
                allowImplicitScrolling: true,
                pageSnapping: true,
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const NewsPage();
                }),
            PageView.builder(
                controller: vPageController,
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const StoryScreen();
                }),
          ],
        ));
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
}
