import 'dart:async';
import 'dart:developer' as dev;
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/view/home/widgets/custom_flip_widget.dart';
import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:am_innnn/view/home/widgets/tab_bar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/news_model.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/utils.dart';
import '../drawer/drawer_screen.dart';
import '../story/story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.category});

  final Map<String, dynamic>? category;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Page Controller
  final PageController storyPageController = PageController();
  final PagingController<int, Data> pagingController =
      PagingController(firstPageKey: 1);
  // late PageController newsPageController;

  // API Property
  late Future<NewsModel> fetchAllNews;
  late Future<StoryModel> fetchStory;

  // Filter Category
  late String searchCategory;
  late String searchText;

  // Check Property
  bool _isLogin = false;
  late String _authToken = '';
  int? userId;
  bool isFav = false;
  bool _isRefresh = false;

  @override
  void initState() {
    isLoggedIn();
    fetchStory = NewsData.fetchStory();
    super.initState();
  }

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
              child: childBuilder(context));
        });
  }

  //News Section and fetch the news from api
  FutureBuilder<NewsModel> _newsSection() {
    return FutureBuilder<NewsModel>(
      future: fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final data = snapshot.data!.data!;
          if (data.isNotEmpty) {
            return !_isRefresh
                ? GestureDetector(
                    onTap: () {
                      dev.log('barsVisibility on tap');
                      Provider.of<BarsVisibility>(context, listen: false)
                          .toggleBars();
                      if (Provider.of<BarsVisibility>(context, listen: false)
                          .showBars) {
                        Timer(const Duration(seconds: 3), () {
                          Provider.of<BarsVisibility>(context, listen: false)
                              .hideBars();
                        });
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
                                      // newsPageController.animateToPage(0,
                                      //     duration:
                                      //         const Duration(milliseconds: 500),
                                      //     curve: Curves.easeInOut);
                                    },
                                    refreshOnTap: () {
                                      dev.log('refresh');
                                      _refreshData();
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
  NewsScreen screenDesign(NewesData data) {
    dev.log(data.id.toString());
    return NewsScreen(
        category: data.category!,
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
          const Text('No News Found '),
          SizedBox(height: Utils.scrHeight * .03),
          SizedBox(
            width: Utils.scrHeight * .2,
            child: ActionButton(
              buttonColor: appThemeColor,
              buttonName: 'Try Again',
              onTap: () {
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
                      imageUrl: data[index].image ?? '',
                      videoUrl: data[index].video ?? '');
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

  // Fetch News for All News, With Category and Search Title
  Future<NewsModel> fetchNews() async {
    if (widget.category == null) {
      fetchAllNews = NewsData.fetchAllNews();
    } else {
      setState(() {
        searchCategory = widget.category!['selectedCategory'];
        searchText = widget.category!['searchText'];
      });
      dev.log('Select search: $searchCategory');
      dev.log('Select search: $searchText');
      if (searchText == null || searchText.isEmpty) {
        fetchAllNews = NewsData.fetchAllNews(category: searchCategory);
      } else if (searchCategory == null || searchCategory.isEmpty) {
        fetchAllNews = NewsData.searchText(searchTitle: searchText);
      } else {
        fetchAllNews =
            NewsData.filter(category: searchCategory, searchTitle: searchText);
      }
    }
    return fetchAllNews;
  }

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

  // Check Is Login or Not
  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the session data exists
    bool isLogin = prefs.containsKey('token');
    setState(() {
      _isLogin = isLogin;
    });
    if (_isLogin) {
      String? authToken = await prefs.getString('token');
      setState(() {
        _authToken = authToken!;
      });
    }
  }

  @override
  void dispose() {
    // newsPageController.dispose();
    storyPageController.dispose();
    super.dispose();
  }
}
