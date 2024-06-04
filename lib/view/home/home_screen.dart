// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, unused_field, unused_element
import 'dart:async';
import 'dart:developer' as dev;
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/provider/dropdown_provider.dart';
import 'package:am_innnn/provider/news_provider.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/view/home/widgets/custom_flip_widget.dart';
import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:am_innnn/view/home/widgets/tab_bar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/news_model.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/story_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/utils.dart';
import '../drawer/drawer_screen.dart';
import '../story/story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.category});

  final List<int>? category;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late PageController storyPageController = PageController();
  late Future<NewsModel> fetchAllNews;
  late Future<StoryModel> fetchStory;
  late String searchCategory;
  bool isFav = false;
  bool _isRefresh = false;
  final _isLogin = appData.read(kKeyIsLoggedIn);
  final _authToken = appData.read(kKeyToken);
  int page = 1;
  bool loading = false;
  bool hasMore = true;

  @override
  void initState() {
    dev.log('initstate call');
    storyPageController.addListener(() {
      _scroolListener();
    });

    Provider.of<StoryProvider>(context, listen: false).fetchStories();
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
    // fetchStory = NewsData.fetchStory(page);
    // fetchStory =
    //     Provider.of<StoryProvider>(context, listen: false).fetchStories();

    // fetchStory = _fetchStory(page + 1);
    // Close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  // News Scrool Listener
  void _scroolListener() {
    if (storyPageController.position.pixels ==
        storyPageController.position.maxScrollExtent) {
      Provider.of<StoryProvider>(context, listen: false).fetchStories();
      // setState(() {
      //   // page = page + 1;
      // });
      // fetchStory = NewsData.fetchStory(page);
      // // fetchStory = _fetchStory(page + 1);
      // dev.log('scrool');
    }
  }

  // Get All Story Data
  // Future<StoryModel> _fetchStory(int page) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     final response = await NewsData.fetchStory(page);
  //     setState(() {
  //       storyData.addAll(response.storyboard!.data!);
  //       this.page = page;
  //       hasMore = response.storyboard!.data!.isNotEmpty;
  //     });
  //     return response;
  //   } catch (e) {
  //     dev.log(e.toString());
  //     rethrow;
  //   } finally {
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Provider.of<BarsVisibility>(context).showBars
          ? _bottomNavigationMenu(context)
          : null,
      drawer: const DrawerScreen(),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          // All news with Vertical Scroll view
          _newsSection(),

          // All Story for swipe horizontally
          _storySection(),
        ],
      ),
    );
  }

  //News Section and fetch the news from api
  // FutureBuilder<NewsModel> _newsSection() {
  //   return FutureBuilder<NewsModel>(
  //     future: fetchNews(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasData) {
  //         final data = snapshot.data!.data!.data!;
  //         return !_isRefresh
  //             ? GestureDetector(
  //                 onTap: () {
  //                   dev.log('barsVisibility on tap');
  //                   Provider.of<BarsVisibility>(context, listen: false)
  //                       .toggleBars();
  //                   if (Provider.of<BarsVisibility>(context, listen: false)
  //                       .showBars) {
  //                     // Timer(const Duration(seconds: 3), () {
  //                     Provider.of<BarsVisibility>(context, listen: false)
  //                         .hideBars();
  //                     Provider.of<BarsVisibility>(context, listen: false)
  //                         .toggleBars();
  //                     // });
  //                   }
  //                 },
  //                 child: Stack(
  //                   children: [
  //                     // Flip Animation & News Screen Widget
  //                     data.isNotEmpty
  //                         ? CustomFlipWidget(
  //                             pages: data.map((e) => screenDesign(e)).toList(),
  //                             data: data.map((e) => e).toList(),
  //                           )
  //                         : _errorSection(context),

  //                     // Show Tob TabBar
  //                     Provider.of<BarsVisibility>(context).showBars
  //                         ? Positioned(
  //                             top: 0,
  //                             right: 0,
  //                             left: 0,
  //                             child: CustomTabBar(
  //                                 homeOnTap: () =>
  //                                     Scaffold.of(context).openDrawer(),
  //                                 startOnTap: () {
  //                                   dev.log('startOnTap');
  //                                   // searchCategory = '';
  //                                   _refreshData();
  //                                 },
  //                                 refreshOnTap: () {
  //                                   // searchCategory = '';
  //                                   // _refreshData();
  //                                   Navigator.pushNamedAndRemoveUntil(context,
  //                                       RoutesName.home, (route) => false);
  //                                 }))
  //                         : const SizedBox(),
  //                   ],
  //                 ),
  //               )
  //             : const Center(child: CircularProgressIndicator());
  //       } else {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }
  Consumer<NewsProvider> _newsSection() {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.newes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.newes.isEmpty) {
          return const Center(child: Text('We Are Coming Soon Be Paction'));
        }

        return !_isRefresh
            ? GestureDetector(
                onTap: () {
                  dev.log('barsVisibility on tap');
                  Provider.of<BarsVisibility>(context, listen: false)
                      .toggleBars();
                  if (Provider.of<BarsVisibility>(context, listen: false)
                      .showBars) {
                    // Timer(const Duration(seconds: 3), () {
                    Provider.of<BarsVisibility>(context, listen: false)
                        .hideBars();
                    Provider.of<BarsVisibility>(context, listen: false)
                        .toggleBars();
                    // });
                  }
                },
                child: Stack(
                  children: [
                    // Flip Animation & News Screen Widget
                    provider.newes.isNotEmpty
                        ? CustomFlipWidget(
                            pages: provider.newes
                                .map((e) => screenDesign(e))
                                .toList(),
                            data: provider.newes.map((e) => e).toList(),
                          )
                        : _errorSection(context),

                    // Show Tob TabBar
                    Provider.of<BarsVisibility>(context).showBars
                        ? Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: CustomTabBar(
                                homeOnTap: () =>
                                    Scaffold.of(context).openDrawer(),
                                startOnTap: () {
                                  dev.log('startOnTap');
                                  // searchCategory = '';
                                  _refreshData();
                                },
                                refreshOnTap: () {
                                  // searchCategory = '';
                                  // _refreshData();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      RoutesName.home, (route) => false);
                                }))
                        : const SizedBox(),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  // News Screen Design
  NewsScreen screenDesign(Datum data) {
    return NewsScreen(
        newsId: data.id!,
        image: data.featuredImage ?? ApiUrl.imageNotFound,
        newsDec: data.description ?? 'News Description Not Found',
        sourceLink: data.url ?? 'Url Not Found',
        newsTitle: data.title ?? 'News Title Not Found');
  }

  // Error Handling From Api
  Widget _errorSection(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('We Are Coming Soon Be Paction'),
            SizedBox(height: Utils.scrHeight * .03),
            SizedBox(
              width: Utils.scrHeight * .2,
              child: ActionButton(
                buttonColor: appThemeColor,
                buttonName: 'Try Again',
                onTap: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .resetLanguage();
                  appData.write(kKeyLanguageCode, 'en');
                  appData.write(kKeyLanguageId, 2);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.home, (route) => false);
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // Fetch all Story Form api
  // FutureBuilder<StoryModel> _storySection() {
  //   return FutureBuilder<StoryModel>(
  //       future: fetchStory,
  //       builder: (context, snapshot) {
  //         // Remove the bottom navigation when go to story page
  //         if (snapshot.hasData) {
  //           final data = snapshot.data!.storyboard!.data;
  //           if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
  //             Timer(const Duration(seconds: 1), () {
  //               Provider.of<BarsVisibility>(context, listen: false).hideBars();
  //             });
  //           }
  //           return PageView.builder(
  //               controller: storyPageController,
  //               scrollDirection: Axis.vertical,
  //               itemCount: data!.length,
  //               itemBuilder: (context, index) {
  //                 // Story Screen Widget
  //                 return StoryScreen(
  //                     images: data[index].images,
  //                     videoUrl: data[index].video ?? '',
  //                     title: data[index].title ?? '');
  //               });
  //         } else if (snapshot.hasError) {
  //           return const Center(
  //             child: Text('No Story Found'),
  //           );
  //         } else {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }
  Consumer<StoryProvider> _storySection() {
    return Consumer<StoryProvider>(builder: (context, storyProvider, child) {
      // Remove the bottom navigation when go to story page
      if (storyProvider.isLoading && storyProvider.stories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (storyProvider.stories.isEmpty) {
        return const Center(child: Text('We Are Coming Soon Be Paction'));
      }

      if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
        Timer(const Duration(seconds: 1), () {
          Provider.of<BarsVisibility>(context, listen: false).hideBars();
        });
      }
      return PageView.builder(
          controller: storyPageController,
          scrollDirection: Axis.vertical,
          itemCount: storyProvider.stories.length,
          itemBuilder: (context, index) {
            final story = storyProvider.stories[index];
            return StoryScreen(
              images: story.images,
              videoUrl: story.video ?? '',
              title: story.title ?? '',
            );
          });
    });
  }

  // BottomNavigationMenu
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
          // BottomNavigation Bar Item
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Utils.showSvgPicture('search',
                    height: Utils.scrHeight * 0.024,
                    width: Utils.scrHeight * 0.024),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Utils.showSvgPicture('font',
                    height: Utils.scrHeight * 0.024,
                    width: Utils.scrHeight * 0.024),
                label: 'Font'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.language,
                  size: Utils.scrHeight * 0.030,
                ),
                label: 'Language'),
            BottomNavigationBarItem(
                icon: Utils.showSvgPicture('bookmark',
                    height: Utils.scrHeight * 0.024,
                    width: Utils.scrHeight * 0.024),
                label: 'BookMark'),
            BottomNavigationBarItem(
                icon: provider.selectedIndex == 3
                    ? Utils.showSvgPicture('share',
                        height: Utils.scrHeight * 0.024,
                        width: Utils.scrHeight * 0.024)
                    : Utils.showSvgPicture('share',
                        height: Utils.scrHeight * 0.024,
                        width: Utils.scrHeight * 0.024),
                label: 'Share'),
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
              Navigator.pushNamed(context, RoutesName.onBoarding);
            } else if (provider.selectedIndex == 3) {
              Navigator.pushNamed(context, RoutesName.bookmark);
            } else if (provider.selectedIndex == 4) {
              shareContent(context);
            }
          },
        );
      }),
    );
  }

  Future<NewsModel> fetchNews() async {
    if (appData.read(kKeyCategory) == null ||
        appData.read(kKeyCategory).isEmpty ||
        appData.read(kKeyCategory) == []) {
      // Fetch All News
      fetchAllNews = NewsData.fetchAllNews();
    } else {
      String categoriesString = appData.read(kKeyCategory).join(',');
      // Fetch News filter by Category
      fetchAllNews = NewsData.fetchAllNews(category: categoriesString);
    }
    return fetchAllNews;
  }

  // Fetch News for All News, With Category and Search Title
  // Future<NewsModel> fetchNews() async {
  //   if (_isLogin) {
  //     if (widget.category == null) {
  //       // Fetch All News
  //       fetchAllNews = newsDataStream.fetchNewsStream(authToken: _authToken);
  //     } else {
  //       // Fetch News filter by Category
  //       fetchAllNews =
  //           newsDataStream.fetchNewsStream(category: widget.category);
  //     }
  //   } else {
  //     if (widget.category == null) {
  //       // Fetch All News
  //       fetchAllNews = newsDataStream.fetchNewsStream();
  //     } else {
  //       // Fetch News filter by Category
  //       fetchAllNews =
  //           newsDataStream.fetchNewsStream(category: widget.category);
  //     }
  //   }
  //   return fetchAllNews;
  // }

  // Share App Url to anyone
  void shareContent(BuildContext context) async {
    try {
      await Share.share('https://flutter.dev/');
    } catch (e) {
      Utils.showSnackBar(context, '$e');
    }
  }

  // Add the _refreshData method
  void _refreshData() async {
    if (_isRefresh) {
      return;
    }
    setState(() {
      _isRefresh = true;
    });

    try {
      // newsPageController.jumpToPage(0);
      await fetchNews();
      setState(() {
        _isRefresh = false;
      });
    } catch (error) {
      dev.log('Error during refresh: $error');
      setState(() {
        _isRefresh = false;
      });
    }
  }

  // Function to show popUp massage
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
              child: childBuilder(context));
        });
  }

  @override
  void dispose() {
    // newsPageController.dispose();
    storyPageController.dispose();
    super.dispose();
  }
}
