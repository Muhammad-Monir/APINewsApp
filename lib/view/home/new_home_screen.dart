import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/news_model.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/utils.dart';
import '../drawer/drawer_screen.dart';
import '../story/story_screen.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key, this.category});

  final Map<String, dynamic>? category;

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen>
    with TickerProviderStateMixin {
  final PageController storyPageController = PageController();
  final PagingController<int, Data> pagingController =
      PagingController(firstPageKey: 1);
  bool _isRefresh = false;

  // Animation Property
  late Animation<double> flipAnim;
  late PageController newsPageController;
  late AnimationController _animationController;

  // API Property
  late Future<NewsModel> fetchAllNews;
  late Future<StoryModel> fetchStory;

  // Filter Category
  late String searchCategory;
  late String searchText;

  @override
  void initState() {
    // isLoggedIn();
    // pagingController.addPageRequestListener((pageKey) async {
    //   dev.log(pageKey.toString());
    //   List<Data> story = await NewsData.fetchStory(pageKey);
    //   pagingController.appendPage(story, pageKey + 1);
    // });

    fetchStory = NewsData.fetchStory();

    animation();
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
            return PageView.builder(
              controller: newsPageController,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(0, 2, 0.001)
                        ..rotateX(2 * pi * flipAnim.value),
                      alignment: Alignment.center,
                      child: !_isRefresh
                          ? SizedBox(
                              child: NewsScreen(
                                category: data[index].category!,
                                newsId: data[index].id!,
                                homeOnTap: () =>
                                    Scaffold.of(context).openDrawer(),
                                startOnTap: () {
                                  newsPageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                refreshOnTap: () {
                                  _refreshData();
                                },
                                image: data[index].featuredImage ??
                                    ApiUrl.imageNotFound,
                                newsDec: data[index].description ??
                                    'News Description Not Found',
                                sourceLink: data[index].url ?? 'Url Not Found',
                                newsTitle:
                                    data[index].title ?? 'News Title Not Found',
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    );
                  },
                );
              },
            );

            // return !_isRefresh
            //     ? CustomFlipWidget(
            //         pages: data
            //             .map((e) => SizedBox(
            //                   child: _screenDesign(e, context),
            //                 ))
            //             .toList())
            //     : const Center(child: CircularProgressIndicator());
          } else {
            return _errorSection(context);
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // NewsScreen screenDesign(NewesData data, BuildContext context) {
  //   return NewsScreen(
  //     newsId: data.id!,
  //     homeOnTap: () => Scaffold.of(context).openDrawer(),
  //     startOnTap: () {
  //       newsPageController.animateToPage(
  //         0,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     },
  //     refreshOnTap: () {
  //       _refreshData();
  //     },
  //     image: data.featuredImage ?? ApiUrl.imageNotFound,
  //     newsDec: data.description ?? 'News Description Not Found',
  //     sourceLink: data.url ?? 'Url Not Found',
  //     newsTitle: data.title ?? 'News Title Not Found',
  //   );
  // }

  Center _errorSection(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text('No News Found '),
          SizedBox(
            height: Utils.scrHeight * .03,
          ),
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
                  return StoryScreen(
                    imageUrl: data[index].image ?? '',
                    videoUrl: data[index].video ?? '',
                  );
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
  // PagedListView<int, Data> _storySection() {
  //   return PagedListView<int, Data>(
  //     pagingController: pagingController,
  //     builderDelegate: PagedChildBuilderDelegate<Data>(
  //       itemBuilder: (context, data, index) {
  //         dev.log(data.toString());
  //         return StoryScreen(
  //           imageUrl: data.image ?? ApiUrl.imageNotFound,
  //           videoUrl: data.video ??
  //               'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4',
  //         );
  //       },
  //       firstPageErrorIndicatorBuilder: (context) => const Center(
  //         child: Text('Error loading data.'),
  //       ),
  //       noItemsFoundIndicatorBuilder: (context) => const Center(
  //         child: Text('Last item'),
  //       ),
  //     ),
  //   );
  // }

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
              shareContent(context);
            }
          },
        );
      }),
    );
  }

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
      newsPageController.jumpToPage(0);
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

  void animation() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2), // Adjust animation duration
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
  void dispose() {
    newsPageController.dispose();
    storyPageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
