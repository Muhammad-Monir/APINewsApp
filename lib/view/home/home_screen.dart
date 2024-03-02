import 'dart:async';
import 'dart:math';
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/news_model.dart';
import '../../provider/bottom_navigation_provider.dart';
import '../../provider/timer_provider.dart';
import '../../utils/utils.dart';
import '../drawer/drawer_screen.dart';
import '../story/story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.category});

  final String? category ;

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
  late Future<NewsModel> fetchAllNews;
  late Future<StoryModel> fetchStroy;

  @override
  void initState() {
    fetchStroy = NewsData.fetchStory();

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

    super.initState();
  }

  Future<NewsModel> fetchNews() async {
    if(widget.category == null){
      fetchAllNews =  NewsData.fetchAllNews();
    }else{
      // fetchAllNews = NewsData.fetchAllNews(category: widget.category);
      fetchAllNews = NewsData.searchNews(searchText: widget.category);
    }

    return fetchAllNews;
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

          FutureBuilder<NewsModel>(
            future: fetchNews(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              if (snapshot.hasData) {
                List<Articles> data = snapshot.data!.articles!;
                if(data.isNotEmpty){
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
                            child: SizedBox(
                              child: NewsScreen(
                                homeOnTap: () =>
                                    Scaffold.of(context).openDrawer(),
                                startOnTap: () {
                                  newsPageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                image: data[index].urlToImage ?? ApiUrl.imageNotFound,
                                newsDec: data[index].description ??  'News Description Not Found',
                                sourceLink: data[index].url ??  'Url Not Found',
                                newsTitle: data[index].title ??  'News Title Not Found',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }else{
                  return  Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text('No News Found '),
                      SizedBox(height: Utils.scrHeight * .03,),
                      SizedBox(
                        width: Utils.scrHeight * .2,
                        child: ActionButton(buttonColor: appThemeColor,buttonName: 'Try Again',onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
                        },),
                      ),
                      const Spacer(),
                    ],
                  ),);
                }

              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),


          // All Story for swipe horizontally
          FutureBuilder<StoryModel>(
            future: fetchStroy,
            builder: (context,snapshot) {
              if(snapshot.hasData){
                final data = snapshot.data!.story!.data;
                return PageView.builder(
                    controller: storyPageController,
                    scrollDirection: Axis.vertical,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      Provider.of<BarsVisibility>(context).hideBars();
                      return  StoryScreen(imageUrl: '${ApiUrl.appBaseUrl}${data[index].image}' ?? ApiUrl.imageNotFound);
                    });
              }else if(snapshot.hasError){
                return Center(child: Text(snapshot.hasError.toString()),);
              }else {
                return const Center(child: CircularProgressIndicator(),);
              }

            }
          ),
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
                  shareContent(context);
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

  void shareContent(BuildContext context) async {
    try {
      await Share.share('https://flutter.dev/');
    } catch (e) {
      Utils.showSnackBar(context, '$e');
    }
  }


  @override
  void dispose() {
    newsPageController.dispose();
    storyPageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
