// ignore_for_file: use_build_context_synchronously, unused_element
import 'dart:developer';
import 'package:am_innnn/services/auth_service.dart';
import 'package:am_innnn/view/home/widgets/tab_bar_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/user_data.dart';
import '../../../provider/bookmark_provider.dart';
import '../../../provider/font_size_provider.dart';
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
  final String category;

  const NewsScreen(
      {super.key,
      this.startOnTap,
      this.homeOnTap,
      this.image,
      required this.newsDec,
      required this.sourceLink,
      required this.newsTitle,
      this.refreshOnTap,
      required this.newsId,
      required this.category});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLogin = false;
  late String? _authToken = '';
  int? userId;
  bool isFav = false;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  final adUnitId = 'ca-app-pub-6659386038146270/8006413063';

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isLoggedIn();
    _initBannerAd();
    super.initState();
  }

  // Check Is Login or Not
  void isLoggedIn() {
    _isLogin = Provider.of<AuthService>(context, listen: false).isLoggedIn();
    if (_isLogin) {
      _authToken = Provider.of<AuthService>(context, listen: false).getToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // onTap: () {
        //   log('barsVisibility ontap');
        //   Provider.of<BarsVisibility>(context, listen: false).toggleBars();
        //   if (Provider.of<BarsVisibility>(context, listen: false).showBars) {
        //     Timer(const Duration(seconds: 3), () {
        //       Provider.of<BarsVisibility>(context, listen: false).hideBars();
        //     });
        //   }
        // },
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // // Banner Section
      // floatingActionButton: _isAdLoaded
      //     ? SizedBox(
      //         height: _bannerAd.size.height.toDouble(),
      //         width: _bannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: _bannerAd..load()))
      //     : const SizedBox()
    );
  }

  // Showing Floating Add Banner
  // Padding _floatingActionButton() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         right: Utils.scrHeight * .054,
  //         left: Utils.scrHeight * .054,
  //         bottom: Utils.scrHeight * .01),
  //     child: GestureDetector(
  //       child: SizedBox(
  //         width: double.infinity,
  //         height: Utils.scrHeight * .054,
  //         child: Image.asset(
  //           'assets/images/floating_add.png',
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
      child: newsBody(fontSize),
    );
  }

  Column newsBody(FontSizeProvider fontSize) {
    return Column(
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
            style:
                regularTS(appSecondTextColor, fontSize: 15 * fontSize.fontSize),
          ),
        ),
        SizedBox(
          height: Utils.scrHeight * .02,
        ),
        // socialLinkSection(),
        // SizedBox(height: Utils.scrHeight * .02),
      ],
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

        // // Home Screen Top Tab Bar
        // Provider.of<BarsVisibility>(context).showBars
        //     ? buildTabBar()
        //     : Container(),

        // Promo Code
        Positioned(
          bottom: -Utils.scrHeight * .014,
          right: Utils.scrHeight * .05,
          child: _buildPromoCode(),
        ),

        // BookMark Button
        // if (_isLogin) _addToBookmark()
      ],
    );
  }

  Consumer<BookmarkProvider> _addToBookmark() {
    return Consumer<BookmarkProvider>(builder: (context, provider, child) {
      return Positioned(
          top: Utils.scrHeight * .1,
          right: Utils.scrHeight * .02,
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
            child: GestureDetector(
              onTap: () {
                log('bookmark on Tap');
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
          SizedBox(height: Utils.scrHeight * .05),
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


  // Widget _buildPromoCode() {
  //   return ClipOval(
  //     child: Container(
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .01),
  //       // width: Utils.scrHeight * .14,
  //       // height: 66,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //        border: Border.all( width: 1)
  //       ),
  //       child: Text('Quikkbyte',
  //           style: mediumTS(redContainerColor, fontSize: 20)),
  //     ),
  //   );
  // }


  Widget _buildPromoCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .01),
      // width: Utils.scrHeight * .14,
      // height: 66,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: redContainerColor),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text('Quikkbyte',
          style: mediumTS(redContainerColor, fontSize: 20)),
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

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      // adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
        onAdOpened: (ad) {
          log('ad  opened');
        },
        onAdClosed: (ad) {
          log('Ad closed');
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }
}
