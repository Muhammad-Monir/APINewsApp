import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/bookmark_data.dart';
import 'package:am_innnn/model/bookmark_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/services/auth_service.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/view/bookmarks/widgets/bookmark_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/user_data.dart';
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
  String? _authToken = '';
  late Future<BookmarkModel> fetchAllBookMark;
  BookMarkDataStream bookMarkDataStream = BookMarkDataStream();

  @override
  void initState() {
    _isLogin = Provider.of<AuthService>(context, listen: false).isLoggedIn();
    if (_isLogin) {
      _authToken = Provider.of<AuthService>(context, listen: false).getToken();
    }
    // isLoggedIn();
    super.initState();
  }

  Future<BookmarkModel> fetchBookMark() async {
    fetchAllBookMark = UserData.fetchBookMark(_authToken);
    return fetchAllBookMark;
  }

  // Future<void> isLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // // Check if the session data exists
  //   // bool isLogin = prefs.containsKey('token');
  //   _isLogin = await AuthService.isLoggedIn();
  //   // setState(() {
  //   //   _isLogin = isLogin;
  //   // });
  //   if (_isLogin) {
  //     String? authToken = prefs.getString('token');
  //     bookMarkDataStream.fetchBookMarkStream(authToken);
  //     setState(() {
  //       _authToken = authToken!;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bookmarks', style: largeTS(appBarColor))),
        body: _isLogin ? _allBookMark() : _ifNotLogin(context));
  }

  StreamBuilder<BookmarkModel> _allBookMark() {
    return StreamBuilder<BookmarkModel>(
      stream: bookMarkDataStream.broadCastStream,
      builder: (context, AsyncSnapshot<BookmarkModel> snapshot) {
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
                        UserData.addBookMark(
                                _authToken, data[index].id.toString())
                            .then((value) {
                          Utils.showSnackBar(
                              context, 'Bookmark Remove successfully');
                          bookMarkDataStream.fetchBookMarkStream(_authToken);
                        });
                      },
                      svgName: 'selected_bookmark',
                      imageName:
                          data[index].featuredImage ?? ApiUrl.imageNotFound,
                      title: data[index].title!,
                      time: data[index].createdAt!,
                    );
                  },
                )
              : const Center(child: Text('Data not found'));
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No BookMark Added To List'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
