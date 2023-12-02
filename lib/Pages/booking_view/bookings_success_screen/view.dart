
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/text_widget.dart';
class SuccessfulView extends StatelessWidget {
  SuccessfulView({Key? key}) : super(key: key);
  // final controller = Get.put<SuccessfulController>(SuccessfulController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
            Get.back();

          },
          icon: Icon(Icons.arrow_back , color: Colors.white,),
        ),
    title: TextWidget(
    title: 'Booking Successfully',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: AppColors.iconsColor,
    ),

      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(image: AssetImage('assets/images/successful.png')),
            ),
            SizedBox(height: 10,),
            Container(
              height: 120,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child:  Text(' Booking \n Successfully',
                        style: TextStyle(
                          // color: AppColors.secondaryTextColor,
                            color: AppColors.iconsColor,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),),
                    ),
                  ]
              ),
            ),
          ]),
    );
  }
}