import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_agent/utils/color_utils.dart';

class AppStyle {

  static final normalHeading20 = GoogleFonts.poppins(
      color: ColorUtils.black, fontWeight: FontWeight.w400, fontSize: 20);

  static customTextTheme(Color color, FontWeight fontWeight, double fontSize) =>
      GoogleFonts.poppins(
          color: color, fontWeight: fontWeight, fontSize: fontSize);
}
