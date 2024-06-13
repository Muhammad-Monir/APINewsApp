// ignore_for_file: avoid_unnecessary_containers

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/api_url.dart';
import '../../../utils/utils.dart';

class CarouselImageSlider extends StatefulWidget {
  final List<String> images;
  const CarouselImageSlider({super.key, required this.images});

  @override
  State<CarouselImageSlider> createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
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
              .map(
                (item) => CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.network(ApiUrl.imageNotFound),
                ),
              )
              .toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            height: Utils.scrHeight * .335,
            scrollPhysics: const BouncingScrollPhysics(),
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
