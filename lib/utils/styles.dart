// import 'package:flutter/material.dart';
//
// TextStyle regularTS(int color, {double? fontSize = 12}) => TextStyle(
//     color: Color(color),
//     fontSize: fontSize,
//     fontWeight: FontWeight.w400,
//     fontFamily: 'Avenir LT Pro Black');
//
// TextStyle mediumTS(int color, {double? fontSize = 14, bool isUnderline = false}) => TextStyle(
//     color: Color(color),
//     fontSize: fontSize,
//     decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
//     fontWeight: FontWeight.w500,
//     fontFamily: 'Avenir LT Pro Black');
//
// TextStyle semiBoldTS(int color, {double? fontSize = 16}) => TextStyle(
//     color: Color(color),
//     fontSize: fontSize,
//     fontWeight: FontWeight.w600,
//     fontFamily: 'Avenir LT Pro');
//
// TextStyle largeTS(int color, {double? fontSize = 24}) => TextStyle(
//     color: Color(color),
//     fontSize: fontSize,
//     fontWeight: FontWeight.w700,
//     fontFamily: 'Avenir LT Pro');

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle regularTS(Color color, {double? fontSize = 12}) => GoogleFonts.roboto(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
        color: color, fontSize: fontSize, fontWeight: FontWeight.w400));

TextStyle mediumTS(Color color,
        {double? fontSize = 14, bool isUnderline = false}) =>
    GoogleFonts.roboto(
        textStyle: TextStyle(
            decoration:
                isUnderline ? TextDecoration.underline : TextDecoration.none,
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w500));

TextStyle semiBoldTS(Color color, {double? fontSize = 16}) => GoogleFonts.roboto(
    textStyle: TextStyle(
        decoration: TextDecoration.none,
        color: color, fontSize: fontSize, fontWeight: FontWeight.w600));

TextStyle largeTS(Color color, {double? fontSize = 24}) => GoogleFonts.roboto(
    textStyle: TextStyle(
        decoration: TextDecoration.none,
        color: color, fontSize: fontSize, fontWeight: FontWeight.w700));

// TextStyle appbarTitleTS(Color color, {double? fontSize = 18}) =>
//     GoogleFonts.roboto(
//       textStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.w700,
//         color: appbarTitleColor,
//         height: 24 / 18,
//       ),
//     );
