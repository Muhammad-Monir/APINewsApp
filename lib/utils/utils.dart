import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class Utils {
  static late double scrHeight;
  static late double scrWidth;

  // Responsive Screen Size
  static void initScreenSize(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    scrHeight = size.height;
    scrWidth = size.width;
  }

  // Show SvgImage
  static Widget showSvgPicture(String svg,
          {double? height = 16, double? width = 16}) =>
      SvgPicture.asset(height: height, width: width, "assets/icons/$svg.svg");

  // Show PngImage
  static Widget showPngImage(String imageName,
      {double? height, double? width}) {
    return Image.asset("assets/icons/$imageName.png",
        fit: BoxFit.contain, height: height, width: width);
  }

  // show images
  static Widget showImage(String imageName,
      {double? height, double? width}) {
    return Image.asset("assets/images/$imageName.png",
        fit: BoxFit.cover, height: height, width: width);
  }


  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(message),
          duration: const Duration(seconds: 1)),
    );
  }

   static String truncateText(String text, int maxLength) {
    final words = text.split(' ');
    if (words.length <= maxLength) {
      return text;
    }
    final truncatedWords = words.sublist(0, maxLength);
    return '${truncatedWords.join(' ')}...';
  }


  static List<String> categoriesName = [
    'Politics',
    'Health',
    'Stocks',
    'Weather',
    'Crime',
    'Shopping',
    'Sports',
    'Entertainment'
  ];

}
