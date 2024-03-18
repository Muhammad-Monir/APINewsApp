// ignore_for_file: unnecessary_import

import 'package:am_innnn/model/news_model.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/utils/styles.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:am_innnn/view/home/widgets/add_bookmark_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_vertical_flip_page_turn.dart';

class CustomFlipWidget extends StatefulWidget {
  final List<Widget> pages;
  final List<NewesData> data;

  const CustomFlipWidget({super.key, required this.pages, required this.data});

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
      //log('viewport- ${controller.viewportFraction} | page-${controller.page}');
      //log('page- ${controller.page} | offset-${controller.offset}');
      turnController.animCustom(
          controller.page ?? 0, (controller.page ?? 0).toInt());
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
            top: 0,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                page = index;
              },
              children: widget.pages
                  .mapIndexed((index, e) => Container(
                        color: Colors.transparent,
                        child: Stack(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AddBookMArkWidget(newsId: widget.data[index].id),
                            Positioned(
                                bottom: Utils.scrHeight * .13,
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

  SizedBox socialLinkSection(String sourceLink) {
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
                    await launchUrl(Uri.parse(sourceLink));
                  },
                  child: Text('Tap for more info',
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
}
