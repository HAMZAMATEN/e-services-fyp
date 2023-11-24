import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Snackbar {
  static void showSnackBar (String title, String msg,IconData iconData){
    String message = extractErrorMessage(msg);
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.iconsColor, // dark grey background
      colorText: Colors.white,
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.bold,
           color: Colors.white
           // for a splash of color
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 15,
            color: Colors.white

        ),
      ),
      icon: Icon(
        iconData,
          color: Colors.white,
        size: 25,

      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeInOut,
    );


  }


  static String extractErrorMessage(String error) {
    if (error.contains(']')) {
      return error.split(']').last.trim();
    }
    return error; // return the original error if no "]" is found
  }
}