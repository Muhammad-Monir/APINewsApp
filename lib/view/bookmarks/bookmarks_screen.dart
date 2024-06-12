import 'package:am_innnn/common_widgets/action_button.dart';
import 'package:am_innnn/data/bookmark_data.dart';
import 'package:am_innnn/model/bookmark_model.dart';
import 'package:am_innnn/provider/story_provider.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/view/bookmarks/widgets/bookmark_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/user_data.dart';
import '../../provider/news_provider.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  final _isLogin = appData.read(kKeyIsLoggedIn);
  final _authToken = appData.read(kKeyToken);
  late Future<BookmarkModel> fetchAllBookMark;
  BookMarkDataStream bookMarkDataStream = BookMarkDataStream();

  @override
  void initState() {
    // _isLogin = Provider.of<AuthService>(context, listen: false).isLoggedIn();
    // if (_isLogin) {
    //   _authToken = Provider.of<AuthService>(context, listen: false).getToken();
    // }
    // bookMarkDataStream.fetchBookMarkStream(_authToken);
    if (_isLogin) {
      bookMarkDataStream.fetchBookMarkStream(_authToken);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
      },
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Bookmarks', style: largeTS(appBarColor)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigatToHome();
              },
            ),
          ),
          body: _isLogin ? allBookMarkData() : _ifNotLogin(context)),
    );
  }

  StreamBuilder<BookmarkModel> allBookMarkData() {
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
                    // Show bookmark item
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
                      time: DateFormat('yyyy-MM-dd HH:mm')
                          .format(data[index].createdAt!),
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

  // If user not loged in
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

  void navigatToHome() {
    if (Provider.of<NewsProvider>(context, listen: false).newes.isNotEmpty) {
      Provider.of<NewsProvider>(context, listen: false).clearList();
      // Provider.of<BookmarkProvider>(context, listen: false).clearList();
      Provider.of<StoryProvider>(context, listen: false).clearList();
      Navigator.pushNamed(context, RoutesName.home);
    } else {
      // Provider.of<BookmarkProvider>(context, listen: false).clearList();
      Provider.of<StoryProvider>(context, listen: false).clearList();
      Navigator.pushNamed(context, RoutesName.home);
    }
  }
}
