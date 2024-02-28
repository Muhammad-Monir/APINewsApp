

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

TextStyle regularTS(Color color,
        {double? fontSize = 12, bool isUnderline = false}) =>
    GoogleFonts.roboto(
        textStyle: TextStyle(
            decoration:
                isUnderline ? TextDecoration.underline : TextDecoration.none,
            decorationColor:
                isUnderline ? const Color(0xff2E8540) : Colors.transparent,
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w400));

TextStyle mediumTS(Color color,
        {double? fontSize = 14, bool isUnderline = false}) =>
    GoogleFonts.roboto(
        textStyle: TextStyle(
            decoration:
                isUnderline ? TextDecoration.underline : TextDecoration.none,
            decorationColor:
                isUnderline ? const Color(0xff2E8540) : Colors.transparent,
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w500));

TextStyle semiBoldTS(Color color,
        {double? fontSize = 16, bool isUnderline = false}) =>
    GoogleFonts.roboto(
        textStyle: TextStyle(
            decoration:
                isUnderline ? TextDecoration.underline : TextDecoration.none,
            decorationColor: isUnderline ? appThemeColor : Colors.transparent,
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w600));

TextStyle largeTS(Color color, {double? fontSize = 24}) => GoogleFonts.roboto(
    textStyle: TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700));

// TextStyle appbarTitleTS(Color color, {double? fontSize = 18}) =>
//     GoogleFonts.roboto(
//       textStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.w700,
//         color: appbarTitleColor,
//         height: 24 / 18,
//       ),
//     );
