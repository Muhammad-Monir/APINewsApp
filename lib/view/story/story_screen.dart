// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/view/story/widgets/my_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/api_url.dart';
import '../../utils/utils.dart';

class StoryScreen extends StatelessWidget {
  final List<Images>? images;
  final String? videoUrl;

  const StoryScreen({super.key, this.images, this.videoUrl});

  @override
  Widget build(BuildContext context) {
    // log('story screen video ${videoUrl!}');
    final hasImages = images != null && images!.isNotEmpty;
    return Scaffold(
        backgroundColor: const Color(0xffF6F5F3),
        // Share Icon Part
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: Utils.scrHeight * .08),
          child: FloatingActionButton(
            shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(Utils.scrHeight * .1),
            ),
            onPressed: () {
              shareContent(context);
            },
            child: Container(
              child: Utils.showSvgPicture('share'),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show Story Video
            if (!hasImages && videoUrl != null && videoUrl!.isNotEmpty)
              Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: MyPlayer(
                          t: 'http://192.168.40.38/Am_inn/public/$videoUrl',
                        ))),
              ),

            // Show Story Image
            if (hasImages)
              Expanded(
                child: SizedBox(
                  // height: Utils.scrHeight * .8,
                  // width: double.infinity,
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images!.length,
                      itemBuilder: (context, index) {
                        log(images![index].image!);
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'http://192.168.40.38/Am_inn/public/${images![index].image}',
                          // imageUrl: imageUrl!,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Image.network(ApiUrl.imageNotFound),
                        );
                      }),
                ),
              ),

            // Show Story Image
            if (!hasImages && (videoUrl == null || videoUrl!.isEmpty))
              const Center(
                child: Text(
                  'Your text story',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
          ],
        ));
  }

  Future<void> shareContent(BuildContext context) async {
    try {
      final hasImages = images != null && images!.isNotEmpty;
      // Image Share Part
      if (hasImages) {
        final File? cachedImage = await downloadImage(
            'http://192.168.40.38/Am_inn/public/${images!.first.image}');

        if (cachedImage != null) {
          // ignore: deprecated_member_use
          await Share.shareFiles([cachedImage.path], text: 'Sharing image');
        } else {
          throw Exception('Failed to load or download image');
        }
      }

      // Video Share Part
      else if (!hasImages && (videoUrl != null && videoUrl!.isNotEmpty)) {
        await Share.share('${ApiUrl.imageBaseUrl}$videoUrl');
      }

      // Text Share Part
      else if (!hasImages && (videoUrl == null || videoUrl!.isEmpty)) {
        await Share.share('Your text story');
      }
    } catch (e) {
      log(e.toString());
      Utils.showSnackBar(context, '$e');
    }
  }

  void getPopUp(
    BuildContext context,
    Widget Function(BuildContext) childBuilder,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            // insetPadding: EdgeInsets.only(bottom: Utils.scrHeight * .08),
            child: childBuilder(context),
          );
        });
  }
}

Future<File?> downloadImage(String imageUrl) async {
  try {
    final File file = await DefaultCacheManager().getSingleFile(imageUrl);
    return file;
  } catch (e) {
    log('Error downloading image: $e');
    return null;
  }
}
