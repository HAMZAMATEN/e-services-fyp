import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/widgets/scheduled_widget.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/colors.dart';
import '../../res/text_widget.dart';

class ScheduledView extends GetView<ScheduledController> {
  const ScheduledView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ScheduledController>(() => ScheduledController());
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Scheduled',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PersonData(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 70,
                    width: 400,
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.iconsColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: AppColors.textFieldBgColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextWidget(
                          title: "Select Location on Map",

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(title: "Confirm ", onPress: () {}
                  // Get.toNamed(AppRoutes.SuccessfulView),

                  ),
            ],
          ),
        ),
      ),
    );
  }
}
