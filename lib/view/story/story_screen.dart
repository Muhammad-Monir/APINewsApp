import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:am_innnn/view/story/widgets/my_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../provider/timer_provider.dart';
import '../../utils/api_url.dart';
import '../../utils/utils.dart';

class StoryScreen extends StatelessWidget {
  final String? imageUrl;

  const StoryScreen({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Provider.of<BarsVisibility>(context).hideBars();
    const type = 'image';
    print(imageUrl);

    return Scaffold(
      backgroundColor: const Color(0xffF6F5F3),
      // appBar: AppBar(
      //     leading: IconButton(
      //       onPressed: () {
      //         Navigator.pushReplacementNamed(context, RoutesName.home);
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back,
      //         color: Colors.black,
      //       ),
      //     ),
      //     backgroundColor: const Color(0xffF6F5F3),
      //     title: Text('Back', style: mediumTS(appBarColor, fontSize: 20))),

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
          if (type == 'video')
            const Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(aspectRatio: 9 / 19, child: MyPlayer())),
            ),
          if (type == 'image')
            CachedNetworkImage(
              fadeInDuration: const Duration(seconds: 2),
              imageUrl: imageUrl!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.network(ApiUrl.imageNotFound),
            ),
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

      if (type == 'image' && imageUrl != null) {
        final response = await http.get(Uri.parse(imageUrl!));

        if (response.statusCode == 200) {
          final Uint8List bytes = response.bodyBytes;
          final appDocDir = await getApplicationDocumentsDirectory();
          final file = File('${appDocDir.path}/image.jpg');

          await file.writeAsBytes(bytes);
          await Share.shareFiles([file.path]);
        } else {
          throw Exception('Failed to load image');
        }
      } else if (type == 'video' && imageUrl != null) {
      } else if (type == 'text') {
        await Share.share('Your text story');
      }
    } catch (e) {
      print(e);
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
