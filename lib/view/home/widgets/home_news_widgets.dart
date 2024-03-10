import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/user_data.dart';
import '../../../provider/bookmark_provider.dart';
import '../../../provider/font_size_provider.dart';
import '../../../provider/timer_provider.dart';
import '../../../utils/api_url.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';
import 'favorite_popup.dart';

class NewsScreen extends StatefulWidget {
  final VoidCallback? startOnTap;
  final VoidCallback? homeOnTap;
  final VoidCallback? refreshOnTap;
  final String? image;
  final String? newsDec;
  final String sourceLink;
  final String newsTitle;
  final int newsId;

  const NewsScreen({
    super.key,
    this.startOnTap,
    this.homeOnTap,
    this.image,
    required this.newsDec,
    required this.sourceLink,
    required this.newsTitle,
    this.refreshOnTap,
    required this.newsId,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          log('barsVisibility ontap');
          Provider.of<BarsVisibility>(context, listen: false).toggleBars();
          if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
            Timer(const Duration(seconds: 3), () {
              Provider.of<BarsVisibility>(context, listen: false).hideBars();
            });
          }
        },
        child: Consumer<FontSizeProvider>(builder: (context, fontSize, child) {
          return Column(
            children: [
              // Top Banner Image
              _imageBanner(context),

              // News Section
              _newsSection(fontSize)
            ],
          );
        }),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  // Showing Floating Add Banner
  Padding _floatingActionButton() {
    return Padding(
      padding: EdgeInsets.only(
          right: Utils.scrHeight * .054,
          left: Utils.scrHeight * .054,
          bottom: Utils.scrHeight * .01),
      child: GestureDetector(
        child: SizedBox(
          width: double.infinity,
          height: Utils.scrHeight * .054,
          child: Image.asset(
            'assets/images/floating_add.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Share Content Function
  void shareContent(BuildContext context) async {
    try {
      await Share.share('https://flutter.dev/');
    } catch (e) {
      Utils.showSnackBar(context, '$e');
    }
  }

  // News Section to Show News Data
  Container _newsSection(FontSizeProvider fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Utils.scrHeight * .02,
        horizontal: Utils.scrHeight * .024,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Utils.scrHeight * .027),
          SizedBox(
            // width: Utils.scrHeight * .342,
            child: Text(
              widget.newsTitle,
              style: semiBoldTS(appTextColor, fontSize: 19 * fontSize.fontSize),
            ),
          ),
          SizedBox(height: Utils.scrHeight * .02),
          SizedBox(
            height: Utils.scrHeight * .3,
            child: Text(
              Utils.truncateText(widget.newsDec!, 55),
              style: regularTS(appSecondTextColor,
                  fontSize: 15 * fontSize.fontSize),
            ),
          ),
          SizedBox(
            height: Utils.scrHeight * .02,
          ),
          socialLinkSection(),
          // SizedBox(height: Utils.scrHeight * .02),
        ],
      ),
    );
  }

  // Social Link Section
  SizedBox socialLinkSection() {
    return SizedBox(
      width: Utils.scrHeight * .398,
      height: Utils.scrHeight * .02,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Source Link : ',
                style: regularTS(appTextColor, fontSize: 14),
              ),
              const SizedBox(width: 2),
              SizedBox(
                width: Utils.scrHeight * .28,
                child: GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse(widget.sourceLink));
                  },
                  child: Text(widget.sourceLink,
                      overflow: TextOverflow.ellipsis,
                      style: regularTS(appThemeColor, fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Top Image Banner with promo code

  Stack _imageBanner(
    BuildContext context,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Top Image Section
        topImageSection(),

        // Home Screen Top Tab Bar
        Provider.of<BarsVisibility>(context).showBars
            ? buildTabBar()
            : Container(),

        // Promo Code
        Positioned(
          bottom: -Utils.scrHeight * .01,
          left: Utils.scrHeight * .05,
          child: _buildPromoCode(),
        ),

        // BookMark Button
        if (_isLogin) _addToBookmark()
      ],
    );
  }

  Consumer<BookmarkProvider> _addToBookmark() {
    return Consumer<BookmarkProvider>(builder: (context, provider, child) {
      return Positioned(
          top: Utils.scrHeight * .1,
          right: Utils.scrHeight * .02,
          child: GestureDetector(
            onTap: () {
              if (_isLogin) {
                // provider.isFavorite ?
                UserData.addBookMark(_authToken, widget.newsId.toString())
                    .then((value) {
                  Utils.showSnackBar(context, value);
                  if (value == 'Bookmark added successfully') {
                    setState(() {
                      isFav = !isFav;
                    });
                  } else if (value == 'Bookmark Remove successfully') {
                    isFav = false;
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

  Container topImageSection() {
    return Container(
        height: Utils.scrHeight * .335,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Utils.scrHeight * .12),
          bottomRight: Radius.circular(Utils.scrHeight * .12),
        )),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Utils.scrHeight * .022),
            bottomRight: Radius.circular(Utils.scrHeight * .022),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget.image!,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Image.network(ApiUrl.imageNotFound),
          ),
        ));
  }

  Container buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Utils.scrHeight * .024,
      ),
      color: Colors.white,
      height: Utils.scrHeight * .09,
      child: Column(
        children: [
          SizedBox(height: Utils.scrHeight * .045),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: widget.homeOnTap, child: const HomeTabBar()),
              GestureDetector(
                  onTap: widget.refreshOnTap, child: const RefreshTabBar()),
              GestureDetector(
                  onTap: widget.startOnTap, child: const StartTabBar()),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildPromoCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .01),
      // width: Utils.scrHeight * .14,
      // height: 66,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: redContainerColor),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child:
          Text('ABCDEFGHI', style: mediumTS(redContainerColor, fontSize: 20)),
    );
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

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Utils.showSvgPicture(
            'home',
            height: Utils.scrHeight * .022,
            width: Utils.scrHeight * .022,
          ),
          SizedBox(width: Utils.scrHeight * .006),
          Text('Home', style: regularTS(homeTabTextColor, fontSize: 15)),
          SizedBox(width: Utils.scrHeight * .013),
          Text('|', style: regularTS(tabBarDividerColor, fontSize: 14))
        ],
      ),
    );
  }
}

class RefreshTabBar extends StatelessWidget {
  const RefreshTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          children: [
            Utils.showSvgPicture(
              'refresh',
              height: Utils.scrHeight * .022,
              width: Utils.scrHeight * .022,
            ),
            SizedBox(width: Utils.scrHeight * .006),
            Text('Refresh', style: regularTS(homeTabTextColor, fontSize: 15)),
            SizedBox(width: Utils.scrHeight * .013),
            Text('|', style: regularTS(tabBarDividerColor, fontSize: 14))
          ],
        ),
      ),
    );
  }
}

class UnreadTabBar extends StatelessWidget {
  const UnreadTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          children: [
            Utils.showSvgPicture(
              'unread',
              height: Utils.scrHeight * .022,
              width: Utils.scrHeight * .022,
            ),
            SizedBox(width: Utils.scrHeight * .006),
            Text('Unread', style: regularTS(homeTabTextColor, fontSize: 15)),
            SizedBox(width: Utils.scrHeight * .013),
            Text('|', style: regularTS(tabBarDividerColor, fontSize: 14))
          ],
        ),
      ),
    );
  }
}

class StartTabBar extends StatelessWidget {
  const StartTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          children: [
            Utils.showSvgPicture(
              'start',
              height: Utils.scrHeight * .022,
              width: Utils.scrHeight * .022,
            ),
            SizedBox(width: Utils.scrHeight * .006),
            Text('Start', style: regularTS(homeTabTextColor, fontSize: 15)),
            SizedBox(width: Utils.scrHeight * .013),
          ],
        ),
      ),
    );
  }
}
