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
import '../../../provider/video_controller_provider.dart';
import '../../../route/routes_name.dart';
import 'custom_vertical_flip_page_turn.dart';

class CustomFlipWidget extends StatefulWidget {
  final List<Widget> pages;
  final List<Datum> data;

  const CustomFlipWidget({super.key, required this.pages, required this.data});

  @override
  State<CustomFlipWidget> createState() => _CustomFlipWidgetState();
}

class _CustomFlipWidgetState extends State<CustomFlipWidget> {
  PageController controller = PageController();
  CustomVerticalFlipPageTurnController turnController =
      CustomVerticalFlipPageTurnController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      turnController.animCustom(
          controller.page ?? 0, (controller.page ?? 0).toInt());
      log('page number: ${controller.page}');
      log('page number: ${widget.pages.length}');

      // When news flipped, that time the current video need's to be paused
      Provider.of<VideoControllerProvider>(context, listen: false).pause();

      if (controller.page == (widget.pages.length - 1)) {
        Provider.of<NewsProvider>(context, listen: false).fetchNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: LayoutBuilder(builder: (context, constraints) {
                return CustomVerticalFlipPageTurn(
                  cellSize: Size(constraints.maxWidth, constraints.maxHeight),
                  controller: turnController,
                  children: widget.pages,
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
              children: widget.pages
                  .mapIndexed((index, e) =>
                      VideoPage(index: index, data: widget.data[index]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  final int index;
  final Datum data;

  const VideoPage({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    final videoControllerProvider =
        Provider.of<VideoControllerProvider>(context, listen: false);
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              data.featuredImage!.isNotEmpty
                  ? Navigator.pushNamed(context, RoutesName.fullScreen,
                      arguments: data.featuredImage!)
                  : data.video != null
                      ? null
                      : ToastUtil.showShortToast('No Image Found');
            },
            child: Container(
              width: double.infinity,
              height: 250,
              color: Colors.transparent,
              child: data.video != null
                  ? GestureDetector(
                      onTap: () {
                        if (data.video != null) {
                          videoControllerProvider.togglePlayPause();
                        } else {
                          // Handle cases where there is no video
                          ToastUtil.showShortToast('No Video Available');
                        }
                      },
                      child: data.video != null
                          ? Consumer<VideoControllerProvider>(
                              builder: (context, value, child) {
                                return GestureDetector(
                                  onTap: () {
                                    value.togglePlayPause();
                                  },
                                  child: Center(
                                    child: Icon(
                                      value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: !value.isPlaying ||
                                              value.shouldShowControls()
                                          ? Colors.white
                                          : Colors.transparent,
                                      size: 100,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          if (appData.read(kKeyIsLoggedIn))
            AddBookMArkWidget(newsId: data.id, index: index)
          else
            const SizedBox.shrink(),
          Positioned(
            bottom: Utils.scrHeight * .09,
            left: Utils.scrHeight * .02,
            right: Utils.scrHeight * .02,
            child: GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(data.url!));
              },
              child: Text(
                'read: ${data.url!}',
                // 'Tap to know more',\
                maxLines: 1,
                style: regularTS(Colors.black, fontSize: 14, isUnderline: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
































// My Previous Code [20-June-2024]

// class CustomFlipWidget extends StatefulWidget {
//   final List<Widget> pages;
//   final List<Datum> data;

//   const CustomFlipWidget({
//     super.key,
//     required this.pages,
//     required this.data,
//   });

//   @override
//   State<CustomFlipWidget> createState() => _CustomFlipWidgetState();
// }

// class _CustomFlipWidgetState extends State<CustomFlipWidget> {
//   PageController controller = PageController();
//   int page = 0;
//   CustomVerticalFlipPageTurnController turnController =
//       CustomVerticalFlipPageTurnController();

//   @override
//   void initState() {
//     controller.addListener(() {
//       // log('viewport- ${controller.viewportFraction} | page-${controller.page}');
//       // log('page- ${controller.page} | offset-${controller.offset}');
//       // log('page- ${controller.page} | offset-${controller.offset}');
//       turnController.animCustom(
//           controller.page ?? 0, (controller.page ?? 0).toInt());
//       log('page number: ${controller.page}');
//       log('page number: ${widget.pages.length}');
//       if (controller.page == (widget.pages.length - 1)) {
//         Provider.of<NewsProvider>(context, listen: false).fetchNews();
//         // if (appData.read(kKeyIsLoggedIn)) {
//         //   Provider.of<BookmarkProvider>(context, listen: false)
//         //       .fetchBookmarkNews();
//         // }
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       child: Stack(
//         clipBehavior: Clip.antiAlias,
//         children: [
//           Container(
//             color: Colors.yellow,
//             child: Padding(
//               padding: const EdgeInsets.all(0),
//               child: LayoutBuilder(builder: (context, constraints) {
//                 return CustomVerticalFlipPageTurn(
//                   cellSize: Size(constraints.maxWidth, constraints.maxHeight),
//                   controller: turnController,
//                   children: widget.pages.map((e) => e).toList(),
//                 );
//               }),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             top: Utils.scrHeight * .1,
//             child: PageView(
//               controller: controller,
//               scrollDirection: Axis.vertical,
//               onPageChanged: (index) {
//                 // log('before assign page index = $index');
//                 // log('before assign page = $page');
//                 page = index;
//                 // log('after assign page = $page');
//               },
//               children: widget.pages
//                   .mapIndexed((index, e) => Container(
//                         color: Colors.transparent,
//                         child: Stack(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 log('on tap fullscreen');
//                                 widget.data[index].featuredImage!.isNotEmpty
//                                     ? Navigator.pushNamed(
//                                         context, RoutesName.fullScreen,
//                                         arguments:
//                                             widget.data[index].featuredImage!)
//                                     : widget.data[index].video != null
//                                         ? {
//                                             // if (_chewieController == null) return;
//                                             // if (_chewieController!.isPlaying) {
//                                             //   _chewieController?.pause();
//                                             //   playValue.value = true;
//                                             // } else {
//                                             //   _chewieController?.play();
//                                             //   playValue.value = false;
//                                             // }
//                                             ToastUtil.showShortToast(
//                                                 'Video is Available')
//                                           }
//                                         : ToastUtil.showShortToast(
//                                             'No Image Found');
//                                 // FullScreenView(
//                                 //     image: widget
//                                 //         .data[index].featuredImage!.first);
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 250,
//                                 color: Colors.transparent,
//                                 child: const Icon(
//                                   Icons.play_arrow,
//                                   color: Colors.white,
//                                   size: 100,
//                                 ),
//                               ),
//                             ),
//                             appData.read(kKeyIsLoggedIn)
//                                 //  ||
//                                 //         Provider.of<BookmarkProvider>(context,
//                                 //                 listen: false)
//                                 //             .isLoading
//                                 ? AddBookMArkWidget(
//                                     newsId: widget.data[index].id,
//                                     index: index,
//                                   )
//                                 : const SizedBox.shrink(),
//                             Positioned(
//                                 bottom: Utils.scrHeight * .1,
//                                 left: Utils.scrHeight * .02,
//                                 right: Utils.scrHeight * .02,
//                                 child:
//                                     socialLinkSection(widget.data[index].url!))
//                           ],
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget socialLinkSection(String sourceLink) {
//     return SizedBox(
//       width: Utils.scrHeight * .398,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(width: 2),
//               SizedBox(
//                 width: Utils.scrHeight * .28,
//                 child: GestureDetector(
//                   onTap: () async {
//                     await launchUrl(Uri.parse(sourceLink));
//                   },
//                   child: Text('Tap to know more',
//                       style: regularTS(Colors.black,
//                           fontSize: 14, isUnderline: true)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }