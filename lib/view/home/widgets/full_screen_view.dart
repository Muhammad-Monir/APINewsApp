import 'package:am_innnn/view/home/widgets/caroousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/api_url.dart';

class FullScreenView extends StatelessWidget {
  final List<String>? images;
  const FullScreenView({super.key, this.images});

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [ApiUrl.imageNotFound];
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.black,
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselImageSlider(
            // Api Image's List Empty Case
            images: (images!.isNotEmpty)
                ? images ?? imageList // Handled Null
                : imageList, // Empty Case
          ),
        ],
      ),
    );
  }
}
