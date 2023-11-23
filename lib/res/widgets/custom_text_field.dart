import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  IconData icon;
  TextEditingController contr;
  FocusNode? focNode;
  String descrip;
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
          textInputAction: textInputAction,
          obscureText: obsecure,
          keyboardType: keyboardType,
          onChanged: onChange,

          // focusNode: focNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: AppColors.iconsColor,
            ),
            border: InputBorder.none,
            hintText: descrip,
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    //   child: TextField(
    //     controller: contr,
    //     textInputAction: textInputAction,
    //     obscureText: obsecure,
    //     keyboardType: keyboardType,
    //     onChanged: onChange,
    //
    //     // focusNode: focNode,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(
    //         icon,
    //         color: Colors.deepPurple,
    //       ),
    //       border: InputBorder.none,
    //       hintText: descrip,
    //     ),
    //   ),
    // );
  }
}
