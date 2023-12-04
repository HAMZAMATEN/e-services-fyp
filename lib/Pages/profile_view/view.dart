import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/update/update.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:e_services_fyp/utils/routes/routes.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Profile',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: AppColors.iconsColor,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: controller.image == null
                                  ? snapshot.data!['photoUrl'].toString() == ''
                                      ? Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: AppColors.iconsColor,
                                          ),
                                        )
                                      : Image(
                                          image: NetworkImage(snapshot
                                              .data!['photoUrl']
                                              .toString()),
                                          fit: BoxFit.cover,
                                        )
                                  : Image.file(
                                      File(controller.image!.path).absolute,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  UpdateScreen(),
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.iconsColor,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed(AppRoutes.UpdateProfileScreen);
                        // },

                        TextWidget(
                          title: snapshot.data!['userName']
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.black,
                        ),

                        TextWidget(
                          title: snapshot.data!['email'].toString(),
                          fontSize: 18,
                          textColor: Colors.black,
                        ),

                        SizedBox(
                          height: 20,
                        ),


                        ListTile(
                          leading: Icon(
                            Icons.schedule,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: TextWidget(
                            title: 'Scheduled Services',
                            textColor: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {
                            Get.toNamed(AppPages.scheduledServicesView);
                          },
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.auto_fix_off_outlined,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: TextWidget(
                            title: 'Booked Services',
                            textColor: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {
                            Get.toNamed(AppPages.bookedServicesView);
                          },
                        ),
                        //
                        ListTile(
                          leading: Icon(
                            Icons.question_answer_outlined,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: TextWidget(
                            title: 'FAQ\'s',
                            textColor: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {
                            Get.toNamed(AppPages.faqView);
                          },
                        ),

                        ListTile(
                          onTap: (){
                            Get.toNamed(AppPages.aboutUsView);

                          },
                          leading: Icon(
                            Icons.description,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: TextWidget(
                            title: 'About Us',
                            textColor: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Obx(() {
                          return controller.state.logoutLoading.value
                              ? Container(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                  color: AppColors.iconsColor,
                                )))
                              : RoundButton(
                                  title: 'LogOut',
                                  onPress: () {
                                    controller.handleLogout();
                                  },
                                );
                        }),
                      ]);
                } else if (snapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.iconsColor,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
