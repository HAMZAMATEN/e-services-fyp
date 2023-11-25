import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  IconData icon;
  TextEditingController contr;
  FocusNode? focNode;
  String descrip;
  bool readOnly;
  final void Function(String)? onChange;

  CustomTextField({
    super.key,
    required this.contr,
    required this.descrip,
    this.focNode,
    required this.textInputAction,
    required this.keyboardType,
    required this.obsecure,
    required this.icon,
    this.onChange,
    this.readOnly = false,

    //
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: TextField(
          controller: contr,
          readOnly: readOnly,
          textInputAction: textInputAction,
          obscureText: obsecure,
          keyboardType: keyboardType,
          onChanged: onChange,
          style: GoogleFonts.poppins(
            fontSize: 17,
          ),

          // focusNode: focNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: AppColors.iconsColor,
            ),
            border: InputBorder.none,
            hintText: descrip,
            hintStyle: GoogleFonts.poppins(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}




class CustomTextFieldForDateTime extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  IconData icon;
  FocusNode? focNode;
  String descrip;
  bool readOnly;
  Widget suffixIcon;
  final void Function(String)? onChange;

  CustomTextFieldForDateTime({
    super.key,
    required this.descrip,
    this.focNode,
    required this.textInputAction,
    required this.keyboardType,
    required this.obsecure,
    required this.icon,
    this.onChange,
    this.readOnly = false,
    required this.suffixIcon,


    //
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: TextField(
          readOnly: readOnly,
          textInputAction: textInputAction,
          obscureText: obsecure,
          keyboardType: keyboardType,
          onChanged: onChange,

          style: GoogleFonts.poppins(
            fontSize: 17,
          ),

          // focusNode: focNode,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: Icon(
              icon,
              color: AppColors.iconsColor,
            ),
            border: InputBorder.none,
            hintText: descrip,
            hintStyle: GoogleFonts.poppins(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
