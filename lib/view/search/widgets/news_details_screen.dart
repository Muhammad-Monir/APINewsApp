// ignore_for_file: use_build_context_synchronously, unused_element
import 'dart:developer';

import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/user_data.dart';
import '../../../provider/bookmark_provider.dart';
import '../../../provider/font_size_provider.dart';
import '../../../utils/api_url.dart';
import '../../../utils/color.dart';
import '../../../utils/di.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';
import '../../home/widgets/favorite_popup.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String? image;
  final String? newsDec;
  final String sourceLink;
  final String newsTitle;
  final int newsId;

  const NewsDetailsScreen({
    super.key,
    this.image,
    required this.newsDec,
    required this.sourceLink,
    required this.newsTitle,
    required this.newsId,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final _isLogin = appData.read(kKeyIsLoggedIn);
  final _authToken = appData.read(kKeyToken);
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
    // isLoggedIn();
    _initBannerAd();
    super.initState();
  }

  // Check Is Login or Not
  // void isLoggedIn() {
  //   _isLogin = Provider.of<AuthService>(context, listen: false).isLoggedIn();
  //   if (_isLogin) {
  //     _authToken = Provider.of<AuthService>(context, listen: false).getToken();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Banner Section
      floatingActionButton: _isAdLoaded
          ? SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd..load()))
          : const SizedBox(),
    );
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

  // News Title & News Description
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
          height: Utils.scrHeight * .28,
          child: Text(
            Utils.truncateText(widget.newsDec!, 55),
            style:
                regularTS(appSecondTextColor, fontSize: 15 * fontSize.fontSize),
          ),
        ),
        socialLinkSection(),
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
              // Text(
              //   'Source Link : ',
              //   style: regularTS(appTextColor, fontSize: 14),
              // ),
              // const SizedBox(width: 2),
              SizedBox(
                width: Utils.scrHeight * .28,
                child: GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse(widget.sourceLink));
                  },
                  child: Text('Tap to know more',
                      overflow: TextOverflow.ellipsis,
                      style: regularTS(appThemeColor,
                          fontSize: 14, isUnderline: true)),
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

        // Promo Code
        Positioned(
          bottom: -Utils.scrHeight * .02,
          right: Utils.scrHeight * .05,
          child: _buildAppBandingName(),
        ),

        // backbutton
        Positioned(
            top: Utils.scrHeight * .05,
            left: Utils.scrHeight * .02,
            child: Container(
              alignment: Alignment.center,
              width: Utils.scrHeight * .04,
              height: Utils.scrHeight * .04,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0),
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.home, ((route) => false));
                },
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            )),

        // BookMark Button
        // if (_isLogin) _addToBookmark()
        // if (_isLogin) _addToBookmark()
      ],
    );
  }

  Consumer<BookmarkProvider> _addToBookmark() {
    return Consumer<BookmarkProvider>(builder: (context, provider, child) {
      return Positioned(
          top: Utils.scrHeight * .05,
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

  // News Image
  Container topImageSection() {
    return Container(
        height: Utils.scrHeight * .3,
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

  // App Banding Name
  Widget _buildAppBandingName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .01),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: redContainerColor),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child:
          Text('Quikkbyte', style: mediumTS(redContainerColor, fontSize: 20)),
    );
  }

  // Function to showdialog massage
  void getPopUp(
    BuildContext context,
    Widget Function(BuildContext) childBuilder,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true, // Prevent dismissal by tapping outside
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: childBuilder(context),
          );
        });
  }

  // Googles AdsMob
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
