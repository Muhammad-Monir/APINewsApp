import 'dart:async';
import 'dart:math';
import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/view/home/widgets/home_news_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/news_model.dart';
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

  @override
  void initState() {

    print(widget.category);
    super.initState();

    // fetchAllNews = NewsData.fetchAllNews();

    // fetchNews();

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
      drawer: const DrawerScreen(),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          // All news with Vertical Scroll view

          FutureBuilder<NewsModel>(
            future: fetchNews(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
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
                  return  Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No News Found '),
                      SizedBox(height: Utils.scrHeight * .03,),
                      SizedBox(
                        width: Utils.scrHeight * .2,
                        child: ActionButton(buttonColor: appThemeColor,buttonName: 'Try Again',onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
                        },),
                      )
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

  void shareContent() async {
    try {
      await Share.share('https://flutter.dev/');
    } catch (e) {
      Utils.showSnackBar(context, '$e');
    }
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
