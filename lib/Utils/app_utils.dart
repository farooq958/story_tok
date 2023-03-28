import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppUtils{


  static showCustomSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
    required Duration duration
    //required bool theme,
  }) {
    final customSnackBar = SnackBar(
      duration: duration,
      content: Text(
        message,
        style: GoogleFonts.lexend(
          fontSize: 15.sp,
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(customSnackBar);
  }
}