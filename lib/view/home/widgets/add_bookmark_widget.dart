import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/user_data.dart';
import '../../../provider/bookmark_provider.dart';
import '../../../utils/utils.dart';
import 'favorite_popup.dart';

class AddBookMArkWidget extends StatefulWidget {
  final int? newsId;
  const AddBookMArkWidget({super.key, required this.newsId});

  @override
  State<AddBookMArkWidget> createState() => _AddBookMArkWidgetState();
}

class _AddBookMArkWidgetState extends State<AddBookMArkWidget> {
  bool _isLogin = false;
  late String _authToken = '';
  int? userId;
  bool isFav = false;

  @override
  void initState() {
    isLoggedIn();
    super.initState();
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
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(builder: (context, provider, child) {
      return Positioned(
          top: Utils.scrHeight * .1,
          right: Utils.scrHeight * .02,
          child: GestureDetector(
            onTap: () {
              log('bookmarkOnTap');
              if (_isLogin) {
                // provider.isFavorite ?
                UserData.addBookMark(_authToken, widget.newsId.toString())
                    .then((value) {
                  if (value == 'Bookmark added successfully') {
                    Utils.showSnackBar(context, value);
                    setState(() {
                      isFav = !isFav;
                    });
                  } else if (value == 'Bookmark Remove successfully') {
                    isFav = !isFav;
                  }
                  // provider.toggleIsFavorite();
                });
              } else {
                getPopUp(
                    context,
                    (p0) => FavoritePopup(
                          onExit: () {
                            Navigator.pop(p0);
                          },
                        ));
              }
            },
            child: Container(
              width: Utils.scrHeight * .04,
              height: Utils.scrHeight * .04,
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: !isFav
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
              child: !isFav
                  ? Utils.showSvgPicture('bookmarks',
                      height: Utils.scrHeight * .020)
                  : Utils.showSvgPicture('selected_bookmark',
                      height: Utils.scrHeight * .020),
            ),
          ));
    });
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
