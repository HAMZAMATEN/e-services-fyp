
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SuccessfulView extends StatelessWidget {
  SuccessfulView({Key? key}) : super(key: key);
  // final controller = Get.put<SuccessfulController>(SuccessfulController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Booking Successfully',
          style: TextStyle(fontSize: 25,
            fontWeight: FontWeight.bold,
            color:Colors.white ,
          ),
        ),
        backgroundColor:AppColors.iconsColor,
        //  elevation: 0,

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