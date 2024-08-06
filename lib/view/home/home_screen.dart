// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, unused_field, unused_element
import 'dart:async';
import 'dart:developer' as dev;
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/provider/news_provider.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/view/home/widgets/custom_flip_widget.dart';
import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:am_innnn/view/home/widgets/tab_bar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/news_model.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/story_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/api_url.dart';
import '../../utils/toast_util.dart';
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
  List<String>? imageList = [ApiUrl.imageNotFound];
  bool isConnected = false;

  @override
  void initState() {
    dev.log('initstate call');
    isConnect();
    storyPageController.addListener(() {
      _scroolListener();
    });
    fetchData();
    // Close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  void isConnect() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  // News Scrool Listener
  void _scroolListener() {
    if (storyPageController.position.pixels ==
        storyPageController.position.maxScrollExtent) {
      ToastUtil.showShortToast('Loading....');
      Provider.of<StoryProvider>(context, listen: false).fetchStories();
    }
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
          _buildNewsSection(),

          // All Story for swipe horizontally
          _buildStorySection(),
        ],
      ),
    );
  }

  Consumer<NewsProvider> _buildNewsSection() {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.newes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // if (provider.newes.isEmpty) {
        //   return const Center(child: Text('We Are Coming Soon Be Paction'));
        // }

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
                        : _errorSection(context, provider.massage),

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
                                  Provider.of<NewsProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<NewsProvider>(context,
                                          listen: false)
                                      .fetchNews();
                                },
                                refreshOnTap: () {
                                  Provider.of<NewsProvider>(context,
                                          listen: false)
                                      .clearList();

                                  Provider.of<StoryProvider>(context,
                                          listen: false)
                                      .clearList();
                                  // Provider.of<BookmarkProvider>(context,
                                  //         listen: false)
                                  //     .clearList();
                                  _refreshData();
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
      // image: data.featuredImage ?? ApiUrl.imageNotFound,
      images: data.featuredImage ?? imageList,
      video: data.video,
      newsDec: data.description ?? 'News Description Not Found',
      sourceLink: data.url ?? 'Url Not Found',
      newsTitle: data.title ?? 'News Title Not Found',
    );
  }

  // Error Handling From Api
  Widget _errorSection(BuildContext context, String massage) {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              !isConnected
                  ? 'Looks like you are offline.\nPlease switch on your data or WIFI and try again.'
                  : massage == null || massage == ''
                      ? 'We Are Coming Soon Be Patient'
                      : massage,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Utils.scrHeight * .03),
            SizedBox(
              width: Utils.scrHeight * .2,
              child: ActionButton(
                buttonColor: appThemeColor,
                buttonName: 'Try Again',
                onTap: () {
                  // Provider.of<LanguageProvider>(context, listen: false)
                  //     .resetLanguage();
                  // appData.write(kKeyLanguageCode, 'en');
                  // appData.write(kKeyLanguageId, 22);
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

  Consumer<StoryProvider> _buildStorySection() {
    return Consumer<StoryProvider>(builder: (context, storyProvider, _) {
      // dev.log(storyProvider.stories.first.video!);
      // Remove the bottom navigation when go to story page
      if (storyProvider.isLoading && storyProvider.stories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (storyProvider.stories.isEmpty) {
        return Center(
          child: Text(
            storyProvider.massage == null || storyProvider.massage == ''
                ? 'We Are Coming Soon Be Patient'
                : storyProvider.massage,
            textAlign: TextAlign.center,
          ),
        );
      }

      return PageView.builder(
          controller: storyPageController,
          scrollDirection: Axis.vertical,
          itemCount: storyProvider.stories.length,
          itemBuilder: (context, index) {
            final story = storyProvider.stories[index];
            if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
              Timer(const Duration(seconds: 1), () {
                Provider.of<BarsVisibility>(context, listen: false).hideBars();
              });
            }
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
                icon: Utils.showSvgPicture('language',
                    height: Utils.scrHeight * 0.024,
                    width: Utils.scrHeight * 0.024),
                label: 'Language'),
            BottomNavigationBarItem(
                icon: Utils.showSvgPicture('bookmark',
                    height: Utils.scrHeight * 0.024,
                    width: Utils.scrHeight * 0.024),
                label: 'BookMark'),
            BottomNavigationBarItem(
              icon: Utils.showSvgPicture('share',
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

  // Share App Url to anyone
  void shareContent(BuildContext context) async {
    try {
      await Share.share(
          'https://play.google.com/store/apps/details?id=com.quikkbyte.quikkbyte&pli=1');
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
      Provider.of<NewsProvider>(context, listen: false).clearList();
      Provider.of<StoryProvider>(context, listen: false).clearList();
      fetchData();
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
    storyPageController.dispose();
    super.dispose();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (Provider.of<NewsProvider>(context, listen: false)
                .newes
                .isNotEmpty ||
            Provider.of<StoryProvider>(context, listen: false)
                .stories
                .isNotEmpty) {
          dev.log('fetchData call if ');
          Provider.of<StoryProvider>(context, listen: false).clearList();
          Provider.of<NewsProvider>(context, listen: false).clearList();
          Provider.of<StoryProvider>(context, listen: false).fetchStories();
          Provider.of<NewsProvider>(context, listen: false).fetchNews();
        } else {
          dev.log('fetchData call else ');
          Provider.of<StoryProvider>(context, listen: false).fetchStories();
          Provider.of<StoryProvider>(context, listen: false).clearList();
          Provider.of<NewsProvider>(context, listen: false).fetchNews();
          Provider.of<StoryProvider>(context, listen: false).fetchStories();
        }
      }
    });
  }
}
