import 'package:am_innnn/view/home/widgets/caroousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
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
          FullScreenWidget(
            disposeLevel: DisposeLevel.Medium,
            child: InteractiveViewer(
                maxScale: 5,
                minScale: 0.1,
                constrained: true,
                child: CarouselImageSlider(
                  // Api Image's List Empty Case
                  images: (images!.isNotEmpty)
                      ? images ?? imageList // Handled Null
                      : imageList, // Empty Case
                )

                // CachedNetworkImage(
                //   fit: BoxFit.fill,
                //   height: 400,
                //   imageUrl: image!,
                //   placeholder: (context, url) =>
                //       const Center(child: CircularProgressIndicator()),
                //   errorWidget: (context, url, error) =>
                //       Image.network(ApiUrl.imageNotFound),
                // )
                ),
          ),
        ],
      ),
    );
  }
}
