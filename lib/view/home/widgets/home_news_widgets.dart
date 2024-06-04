// ignore_for_file: use_build_context_synchronously, unused_element, unused_field
import 'dart:developer';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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
  // final String category;

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
    // required this.category
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
    _initBannerAd();
    super.initState();
  }

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

      // position of banner section
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
          child: Text(
            // overflow: TextOverflow.ellipsis,
            // maxLines: 3,
            textAlign: TextAlign.justify,
            widget.newsTitle,
            style: semiBoldTS(appTextColor, fontSize: 19),
          ),
        ),
        SizedBox(height: Utils.scrHeight * .02),
        SizedBox(
          // color: Colors.red,
          height: Utils.scrHeight * .3,
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 8,
            textAlign: TextAlign.justify,
            Utils.truncateText(widget.newsDec!, 60),
            style:
                regularTS(appSecondTextColor, fontSize: 15 * fontSize.fontSize),
          ),
        ),
        SizedBox(
          height: Utils.scrHeight * .02,
        ),
      ],
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
        child: FullScreenWidget(
          disposeLevel: DisposeLevel.Medium,
          child: Hero(
            tag: 'teg',
            child: InteractiveViewer(
              maxScale: 5,
              minScale: 0.1,
              constrained: true,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Utils.scrHeight * .022),
                  bottomRight: Radius.circular(Utils.scrHeight * .022),
                ),
                // child: NewsVideoPlayer(),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.image!,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.network(ApiUrl.imageNotFound),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildPromoCode() {
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
