import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:am_innnn/view/story/widgets/my_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/api_url.dart';
import '../../utils/utils.dart';

class StoryScreen extends StatelessWidget {
  final String? imageUrl;

  const StoryScreen({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    const type = 'image';

    return Scaffold(
      backgroundColor: const Color(0xffF6F5F3),
      // Share Icon Part
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: Utils.scrHeight * .06),
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
          if (type == 'video')
            const Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(aspectRatio: 9 / 19, child: MyPlayer())),
            ),

          // Show Story Image
          if (type == 'image')
            CachedNetworkImage(
              imageUrl: imageUrl!,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image.network(ApiUrl.imageNotFound),
            ),

          // Show Story Text
          if (type == 'text')
            const Center(
              child: Text(
                'Your text story',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> shareContent(BuildContext context) async {
    try {
      const String type = 'image';

      // Image Share Part
      if (type == 'image' && imageUrl != null) {
        final File? cachedImage = await downloadImage(imageUrl!);

        if (cachedImage != null) {
          await Share.shareFiles([cachedImage.path], text: 'Sharing image');
        } else {
          throw Exception('Failed to load or download image');
        }
      }

      // Video Share Part
      else if (type == 'video' && imageUrl != null) {
      }

      // Text Share Part
      else if (type == 'text') {
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
