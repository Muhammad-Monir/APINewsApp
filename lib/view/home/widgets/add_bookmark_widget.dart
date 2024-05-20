import 'dart:developer';

import 'package:am_innnn/model/news_model.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/news_stream_data.dart';
import '../../../data/user_data.dart';
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
    // _isLogin = Provider.of<AuthService>(context, listen: false).isLoggedIn();
    // if (_isLogin) {
    //   _authToken = Provider.of<AuthService>(context, listen: false).getToken()!;
    // }
    newsDataStream.fetchNewsStream(authToken: _authToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin
        ? StreamBuilder<NewsModel>(
            stream: newsDataStream.broadCastStream,
            builder: (context, AsyncSnapshot<NewsModel> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data!.data!;
                bool isBookmarked = data[widget.index!].isBookmarked ?? false;
                // log(isBookmarked.toString());
                return data.isNotEmpty
                    ? Consumer<BookmarkProvider>(
                        builder: (context, provider, child) {
                        return Positioned(
                            top: Utils.scrHeight * .1,
                            right: Utils.scrHeight * .02,
                            child: GestureDetector(
                              onTap: () {
                                // newsDataStream.fetchNewsStream(
                                //     authToken: _authToken);
                                log("on tap isbookmark  $isBookmarked");
                                // isFav = widget.isBookedMark!;

                                if (_isLogin) {
                                  // provider.isFavorite ?
                                  UserData.addBookMark(
                                          _authToken, widget.newsId.toString())
                                      .then((value) {
                                    if (value ==
                                        'Bookmark added successfully') {
                                      Utils.showSnackBar(context, value);
                                      newsDataStream.fetchNewsStream(
                                          authToken: _authToken);
                                    } else if (value ==
                                        'Bookmark Remove successfully') {
                                      Utils.showSnackBar(context, value);
                                      newsDataStream.fetchNewsStream(
                                          authToken: _authToken);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                width: Utils.scrHeight * .04,
                                height: Utils.scrHeight * .04,
                                padding: const EdgeInsets.all(8),
                                decoration: ShapeDecoration(
                                  color: !isBookmarked
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
                                child: !isBookmarked
                                    ? Utils.showSvgPicture('bookmarks',
                                        height: Utils.scrHeight * .020)
                                    : Utils.showSvgPicture('selected_bookmark',
                                        height: Utils.scrHeight * .020),
                              ),
                            ));
                      })
                    : const SizedBox();
              } else if (snapshot.hasError) {
                return const Center(
                  child: SizedBox(),
                );
              } else {
                return const Center(
                  child: SizedBox(),
                );
              }
            },
          )
        : const SizedBox();
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
