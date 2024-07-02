import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../utils/api_url.dart';
import '../../../utils/utils.dart';

class FullScreenView extends StatelessWidget {
  final List<String>? images;
  const FullScreenView({super.key, this.images});

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [ApiUrl.imageNotFound];
    log('image: $images');
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.black,
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              // height: Utils.scrHeight * .8,
              width: double.infinity,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (images!.isNotEmpty)
                      ? images?.length ?? imageList.length // Handled Null
                      : imageList.length,
                  itemBuilder: (context, index) {
                    log(images![index]);
                    return FullScreenWidget(
                        disposeLevel: DisposeLevel.High,
                        child: Hero(
                          tag: 'tag',
                          child: InteractiveViewer(
                            maxScale: 5,
                            minScale: 0.1,
                            constrained: true,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: images![index],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Image.network(ApiUrl.imageNotFound),
                            ),
                          ),
                        ));
                  }),
            ),
          ),
          // Expanded(
          //   child: FullScreenCarouselImageSlider(
          //     // Api Image's List Empty Case
          //     images: (images!.isNotEmpty)
          //         ? images ?? imageList // Handled Null
          //         : imageList, // Empty Case
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_unnecessary_containers

class FullScreenCarouselImageSlider extends StatefulWidget {
  final List<String> images;
  const FullScreenCarouselImageSlider({super.key, required this.images});

  @override
  State<FullScreenCarouselImageSlider> createState() =>
      _FullScreenCarouselImageSliderState();
}

class _FullScreenCarouselImageSliderState
    extends State<FullScreenCarouselImageSlider> {
  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // log(' images name is ${widget.images}');
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        // Image Carousel Slider
        _buildCarouselSliderImage(),

        // Dot Indicator's
        widget.images.length > 1
            ? Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: _buildDotIndicator(entry),
                    );
                  }).toList(),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Container _buildDotIndicator(MapEntry<int, dynamic> entry) {
    return Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == entry.key
              ? const Color.fromARGB(255, 166, 195, 245)
              : const Color.fromARGB(255, 111, 113, 130),
        ));
  }

  Container _buildCarouselSliderImage() {
    return Container(
      child: InkWell(
        onTap: () {
          log("Current Index: $currentIndex");
        },
        child: CarouselSlider(
          items: widget.images
              .asMap()
              .entries
              .map(
                (item) => FullScreenWidget(
                  disposeLevel: DisposeLevel.High,
                  child: Hero(
                    tag: 'tag',
                    child: InteractiveViewer(
                      maxScale: 5,
                      minScale: 0.1,
                      constrained: true,
                      child: SizedBox(
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: item.value,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Image.network(ApiUrl.imageNotFound),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            height: Utils.scrHeight * .400,
            scrollPhysics: widget.images.length > 1
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            aspectRatio: 2,
            viewportFraction: 1,
            autoPlay: widget.images.length > 1 ? true : false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
