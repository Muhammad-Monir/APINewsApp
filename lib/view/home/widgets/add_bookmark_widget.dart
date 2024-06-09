// ignore_for_file: unused_local_variable, unused_field
import 'dart:developer';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/news_stream_data.dart';
import '../../../provider/bookmark_provider.dart';
import '../../../utils/utils.dart';

class AddBookMArkWidget extends StatefulWidget {
  final int? newsId;
  final int? index;
  const AddBookMArkWidget({super.key, required this.newsId, this.index});

  @override
  State<AddBookMArkWidget> createState() => _AddBookMArkWidgetState();
}

class _AddBookMArkWidgetState extends State<AddBookMArkWidget> {
  final _isLogin = appData.read(kKeyIsLoggedIn);
  final _authToken = appData.read(kKeyToken);
  int? userId;
  bool? isFav = false;
  NewsDataStream newsDataStream = NewsDataStream();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (context.read<BookmarkProvider>().newes.isEmpty ||
    //     widget.index == null ||
    //     widget.index! >= context.read<BookmarkProvider>().newes.length) {
    //   context.read<BookmarkProvider>().setFavoriteValue(
    //       context.read<BookmarkProvider>().newes[widget.index!].isBookmarked!);
    // }
    return _isLogin
        // ? StreamBuilder<NewsModel>(
        //     stream: newsDataStream.broadCastStream,
        //     builder: (context, AsyncSnapshot<NewsModel> snapshot) {
        //       if (snapshot.hasData) {
        //         final data = snapshot.data!.data!.data!;
        //         bool isBookmarked = data[widget.index!].isBookmarked ?? false;
        //         // log(isBookmarked.toString());
        //         return data.isNotEmpty
        ? Consumer<BookmarkProvider>(builder: (context, provider, _) {
            if (provider.newes.isEmpty ||
                widget.index == null ||
                widget.index! >= provider.newes.length) {
              return const SizedBox();
            } else {
              return Positioned(
                  top: Utils.scrHeight * .1,
                  right: Utils.scrHeight * .02,
                  child: GestureDetector(
                    onTap: () {
                      if (_isLogin) {
                        log('news id from news screen: ${widget.newsId}');
                        log('news id from provider: ${provider.newes[widget.index!].id}');
                        provider.toggleBookmark(
                            appData.read(kKeyToken), widget.newsId!);
                        // provider.isFavorite ?
                        // UserData.addBookMark(_authToken, widget.newsId.toString())
                        //     .then((value) {
                        //   if (value == 'Bookmark added successfully') {
                        //     Utils.showSnackBar(context, value);
                        //     context
                        //         .watch<BookmarkProvider>()
                        //         .setFavoriteValue(true);
                        //     provider.toggleIsFavorite();
                        //     // newsDataStream.fetchNewsStream(authToken: _authToken);

                        //     log("on tap isbookmark  ${provider.isFavorite}");
                        //   } else if (value == 'Bookmark Remove successfully') {
                        //     Utils.showSnackBar(context, value);
                        //     context
                        //         .watch<BookmarkProvider>()
                        //         .setFavoriteValue(false);
                        //     provider.toggleIsFavorite();
                        //     // newsDataStream.fetchNewsStream(authToken: _authToken);

                        //     log("on tap isbookmark  ${provider.isFavorite}");
                        //   }
                        // });
                      }
                    },
                    child: Container(
                      width: Utils.scrHeight * .04,
                      height: Utils.scrHeight * .04,
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: !provider.isFavorite
                            ? Colors.white.withOpacity(0)
                            : Colors.white.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: Utils.scrHeight * .001,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: !provider.isFavorite
                          ? Utils.showSvgPicture('bookmarks',
                              height: Utils.scrHeight * .020)
                          : Utils.showSvgPicture('selected_bookmark',
                              height: Utils.scrHeight * .020),
                    ),
                  ));
            }
          })
        : const SizedBox();
    //       } else if (snapshot.hasError) {
    //         return const Center(
    //           child: SizedBox(),
    //         );
    //       } else {
    //         return const Center(
    //           child: SizedBox(),
    //         );
    //       }
    //     },
    //   )
    // : const SizedBox();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<BookmarkProvider>(context, listen: false).newes.isEmpty) {
        log('index: ${widget.index}');
        log('news id from news screen: ${widget.newsId}');
        Provider.of<BookmarkProvider>(context, listen: false)
            .fetchNews()
            .then((value) {
          if (Provider.of<BookmarkProvider>(context, listen: false)
                  .newes
                  .isEmpty ||
              widget.index == null ||
              widget.index! <=
                  Provider.of<BookmarkProvider>(context, listen: false)
                      .newes
                      .length) {
            log('news id from provider: ${Provider.of<BookmarkProvider>(context, listen: false).newes[widget.index!].id}');

            Provider.of<BookmarkProvider>(context, listen: false)
                .setFavoriteValue(
                    Provider.of<BookmarkProvider>(context, listen: false)
                        .newes[widget.index!]
                        .isBookmarked!);
          }
        });
        log('index is ${widget.index}');
      } else {
        Provider.of<BookmarkProvider>(context, listen: false).clearList();
        Provider.of<BookmarkProvider>(context, listen: false)
            .fetchNews()
            .then((value) {
          if (Provider.of<BookmarkProvider>(context, listen: false)
                  .newes
                  .isEmpty ||
              widget.index == null ||
              widget.index! <=
                  Provider.of<BookmarkProvider>(context, listen: false)
                      .newes
                      .length) {
            Provider.of<BookmarkProvider>(context, listen: false)
                .setFavoriteValue(
                    Provider.of<BookmarkProvider>(context, listen: false)
                        .newes[widget.index!]
                        .isBookmarked!);
          }
        });
      }
    });
  }

  // void getPopUp(
  //   BuildContext context,
  //   Widget Function(BuildContext) childBuilder,
  // ) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true, // Prevent dismissal by tapping outside
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           backgroundColor: Colors.transparent, // Optional customization
  //           // insetPadding: EdgeInsets.only(bottom: Utils.scrHeight * .08),
  //           child: childBuilder(context),
  //         );
  //       });
  // }
}
