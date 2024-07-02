import 'package:flutter/material.dart';

import 'color.dart';

TextStyle regularTS(Color color,
        {double? fontSize = 12, bool isUnderline = false}) =>
    // GoogleFonts.hind(
    //     textStyle:
    TextStyle(
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: isUnderline ? Colors.black : Colors.transparent,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Nirmala'
        // )
        );

TextStyle mediumTS(Color color,
        {double? fontSize = 14, bool isUnderline = false}) =>
    // GoogleFonts.hind(
    //     textStyle:
    TextStyle(
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        decorationColor:
            isUnderline ? const Color(0xff2E8540) : Colors.transparent,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Nirmala'
        // )
        );

TextStyle semiBoldTS(Color color,
        {double? fontSize = 16, bool isUnderline = false}) =>
    // GoogleFonts.hind(
    //     textStyle:
    TextStyle(
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: isUnderline ? appThemeColor : Colors.transparent,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nirmala'
        // )
        );

TextStyle largeTS(Color color, {double? fontSize = 24}) =>
// GoogleFonts.hind(
//     textStyle:
    TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Nirmala'
        // )
        );

// TextStyle appbarTitleTS(Color color, {double? fontSize = 18}) =>
//     GoogleFonts.hind(
//       textStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.w700,
//         color: appbarTitleColor,
//         height: 24 / 18,
//       ),
//     );
