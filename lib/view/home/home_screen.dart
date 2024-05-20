// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, unused_field
import 'dart:async';
import 'dart:developer' as dev;
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/provider/dropdown_provider.dart';
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
import '../../data/news_stream_data.dart';
import '../../model/news_model.dart';
import '../../provider/bottom_navigation_provider.dart';
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
  NewsDataStream newsDataStream = NewsDataStream();
  late Future<NewsModel> fetchAllNews;
  late Future<StoryModel> fetchStory;
  late String searchCategory;
  bool isFav = false;
  bool _isRefresh = false;
  final _isLogin = appData.read(kKeyIsLoggedIn);
  final _authToken = appData.read(kKeyToken);
  List storyData = [];
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    dev.log('initstate call');
    storyPageController.addListener(() {
      _scroolListener();
    });
    fetchStory = NewsData.fetchStory(page);
    // Close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  void _scroolListener() {
    if (storyPageController.position.pixels ==
        storyPageController.position.maxScrollExtent) {
      setState(() {
        // page = page + 1;
      });
      fetchStory = NewsData.fetchStory(page);
      dev.log('scrool');
    }
  }

  @override
  Widget build(BuildContext context) {
    dev.log('widget build');
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
  FutureBuilder<NewsModel> _newsSection() {
    dev.log('news section call');
    return FutureBuilder<NewsModel>(
      future: fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final data = snapshot.data!.data!.data!;
          if (data.isNotEmpty) {
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
                        CustomFlipWidget(
                          pages: data.map((e) => screenDesign(e)).toList(),
                          data: data.map((e) => e).toList(),
                        ),

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
          } else {
            return _errorSection(context);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // News Screen Design
  NewsScreen screenDesign(Datum data) {
    return NewsScreen(
        category: data.categoryId!,
        newsId: data.id!,
        image: data.featuredImage ?? ApiUrl.imageNotFound,
        newsDec: data.description ?? 'News Description Not Found',
        sourceLink: data.url ?? 'Url Not Found',
        newsTitle: data.title ?? 'News Title Not Found');
  }

  // Error Handling From Api
  Center _errorSection(BuildContext context) {
    return Center(
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
    );
  }

  // Fetch all Story Form api
  FutureBuilder<StoryModel> _storySection() {
    return FutureBuilder<StoryModel>(
        future: fetchStory,
        builder: (context, snapshot) {
          // Remove the bottom navigation when go to story page
          if (snapshot.hasData) {
            final data = snapshot.data!.storyboard!.data;
            if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
              Timer(const Duration(seconds: 1), () {
                Provider.of<BarsVisibility>(context, listen: false).hideBars();
              });
            }
            return PageView.builder(
                controller: storyPageController,
                scrollDirection: Axis.vertical,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  // Story Screen Widget
                  return StoryScreen(
                      images: data[index].images,
                      videoUrl: data[index].video ?? '',
                      title: data[index].title ?? '');
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
              Navigator.pushNamed(context, RoutesName.bookmark);
            } else if (provider.selectedIndex == 3) {
              shareContent(context);
            }
          },
        );
      }),
    );
  }

  Future<NewsModel> fetchNews() async {
    dev.log('fetchNews Call');
    dev.log('categories is : ${widget.category}');
    if (widget.category == null) {
      // Fetch All News
      fetchAllNews = NewsData.fetchAllNews();
    } else {
      String categoriesString = widget.category!.join(',');
      dev.log('categories is : $categoriesString');
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
