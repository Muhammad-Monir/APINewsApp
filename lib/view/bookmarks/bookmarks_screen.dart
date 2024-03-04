import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/model/bookmark_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/view/bookmarks/widgets/bookmark_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/user_data.dart';
import '../../provider/bookmark_provider.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  bool _isLogin = false;
  String _authToken = '';
  int? userId;

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the session data exists
    bool isLogin = prefs.containsKey('token');
    String? authToken = prefs.getString('token');
    int? id = prefs.getInt('id');
    setState(() {
      _isLogin = isLogin;
      _authToken = authToken!;
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bookmarks', style: largeTS(appBarColor))),
        body: _isLogin ? _allBookMark() : _ifNotLogin(context));
  }

  Consumer<BookmarkProvider> _allBookMark() {
    return Consumer<BookmarkProvider>(builder: (context, provider, child) {
      return FutureBuilder<BookMarkModel>(
          future: UserData.fetchBookMark(_authToken, userId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.data;
              return data!.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: Utils.scrHeight * .024,
                          vertical: Utils.scrHeight * .024),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return BookmarkItem(
                            onTap: () {
                              // provider.toggleIsFavorite();
                            },
                            svgName: 'selected_bookmark',
                            // provider.isFavorite
                            //     ? 'selected_bookmark'
                            //     : 'bookmark',
                            imageName:
                                data[index].image ?? ApiUrl.imageNotFound,
                            title: data[index].title!,
                            time: data[index].createdAt!);
                      },
                    )
                  : const Center(child: Text('Data not found'));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            } else {
              return Center(
                child: Container(),
              );
            }
          });
    });
  }

  Center _ifNotLogin(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You Are not Login! Please Login First',
            style: semiBoldTS(appTextColor),
          ),
          SizedBox(height: Utils.scrHeight * .02),
          ActionButton(
            width: Utils.scrHeight * .25,
            buttonName: 'Login',
            onTap: () {
              Navigator.pushNamed(context, RoutesName.login);
            },
            buttonColor: appThemeColor,
          )
        ],
      ),
    );
  }
}
