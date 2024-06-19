// ignore_for_file: unnecessary_import
import 'dart:developer';
import 'package:am_innnn/model/news_model.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/utils/styles.dart';
import 'package:am_innnn/utils/toast_util.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:am_innnn/view/home/widgets/add_bookmark_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../provider/news_provider.dart';
import '../../../route/routes_name.dart';
import 'custom_vertical_flip_page_turn.dart';

class CustomFlipWidget extends StatefulWidget {
  final List<Widget> pages;
  final List<Datum> data;

  const CustomFlipWidget({
    super.key,
    required this.pages,
    required this.data,
  });

  @override
  State<CustomFlipWidget> createState() => _CustomFlipWidgetState();
}

class _CustomFlipWidgetState extends State<CustomFlipWidget> {
  PageController controller = PageController();
  int page = 0;
  CustomVerticalFlipPageTurnController turnController =
      CustomVerticalFlipPageTurnController();

  @override
  void initState() {
    controller.addListener(() {
      // log('viewport- ${controller.viewportFraction} | page-${controller.page}');
      // log('page- ${controller.page} | offset-${controller.offset}');
      // log('page- ${controller.page} | offset-${controller.offset}');
      turnController.animCustom(
          controller.page ?? 0, (controller.page ?? 0).toInt());
      // log('page number: ${controller.page}');
      // log('page number: ${widget.pages.length}');
      if (controller.page == (widget.pages.length - 1)) {
        Provider.of<NewsProvider>(context, listen: false).fetchNews();
        // if (appData.read(kKeyIsLoggedIn)) {
        //   Provider.of<BookmarkProvider>(context, listen: false)
        //       .fetchBookmarkNews();
        // }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: LayoutBuilder(builder: (context, constraints) {
                return CustomVerticalFlipPageTurn(
                  cellSize: Size(constraints.maxWidth, constraints.maxHeight),
                  controller: turnController,
                  children: widget.pages.map((e) => e).toList(),
                );
              }),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Utils.scrHeight * .1,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                // log('before assign page index = $index');
                // log('before assign page = $page');
                page = index;
                // log('after assign page = $page');
              },
              children: widget.pages
                  .mapIndexed((index, e) => Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                log('on tap fullscreen');
                                widget.data[index].featuredImage!.isNotEmpty
                                    ? Navigator.pushNamed(
                                        context, RoutesName.fullScreen,
                                        arguments:
                                            widget.data[index].featuredImage!)
                                    : widget.data[index].video != null
                                        ? null
                                        : ToastUtil.showShortToast(
                                            'No Image Found');
                                // FullScreenView(
                                //     image: widget
                                //         .data[index].featuredImage!.first);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 250,
                                color: Colors.transparent,
                              ),
                            ),
                            appData.read(kKeyIsLoggedIn)
                                //  ||
                                //         Provider.of<BookmarkProvider>(context,
                                //                 listen: false)
                                //             .isLoading
                                ? AddBookMArkWidget(
                                    newsId: widget.data[index].id,
                                    index: index,
                                  )
                                : const SizedBox.shrink(),
                            Positioned(
                                bottom: Utils.scrHeight * .1,
                                left: Utils.scrHeight * .02,
                                right: Utils.scrHeight * .02,
                                child:
                                    socialLinkSection(widget.data[index].url!))
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialLinkSection(String sourceLink) {
    return SizedBox(
      width: Utils.scrHeight * .398,
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
              const SizedBox(width: 2),
              SizedBox(
                width: Utils.scrHeight * .28,
                child: GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse(sourceLink));
                  },
                  child: Text('Tap to know more',
                      style: regularTS(Colors.black,
                          fontSize: 14, isUnderline: true)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
