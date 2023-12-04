import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/service_provider_pages/Orders/Screens/scheduled/view.dart';
import 'package:e_services_fyp/service_provider_pages/sp_profile_view/controller.dart';
import 'package:e_services_fyp/service_provider_pages/sp_profile_view/update/update.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/routes/routes.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfileView extends GetView<SpProfileController> {
  const SpProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SpProfileController());
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Profile',
          fontSize: 20,
        ),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back , color: Colors.white,),
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('serviceProviders')
                  .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                  .snapshots(),
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
                                  SpUpdateScreen(),
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
                          title: snapshot.data!['providerName']
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

                        // ListTile(
                        //   leading: Icon(
                        //     Icons.wallet,
                        //     color: Colors.indigoAccent,
                        //     size: 30,
                        //   ),
                        //   title: InkWell(
                        //     onTap: () {
                        //     },
                        //     child: TextWidget(
                        //       title: 'Wallet Balance',
                        //       textColor: Colors.black,
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   trailing: TextWidget(
                        //     title: '\$100.00',
                        //     textColor: Colors.black,
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        ListTile(
                          leading: Icon(
                            Icons.edit,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: InkWell(
                            onTap: () {
                              // Get.toNamed(AppPages.u);
                              Get.to(()=>SpUpdateScreen());
                            },
                            child: TextWidget(
                              title: 'Edit Profile',
                              textColor: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {
                            // Get.toNamed(AppPages.directOrdersView);
                            Get.to(()=>SpUpdateScreen());
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.schedule,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: InkWell(
                            onTap: () {
                              // Get.toNamed(AppPages.scheduledServicesView);
                              Get.to(()=>ScheduledOrdersView());
                            },
                            child: TextWidget(
                              title: 'Scheduled Orders',
                              textColor: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {
                            Get.to(()=>ScheduledOrdersView());
                            // Get.to(()=>ScheduledOrdersView());
                          },
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.schedule,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: InkWell(
                            onTap: () {
                              // Get.toNamed(AppPages.scheduledServicesView);
                              Get.toNamed(AppPages.directOrdersView);
                            },
                            child: TextWidget(
                              title: 'Direct Bookings',
                              textColor: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {
                            // Get.to(()=>ScheduledOrdersView());
                            Get.toNamed(AppPages.directOrdersView);
                            // Get.to(()=>ScheduledOrdersView());
                          },
                        ),


                        // ListTile(
                        //   leading: Icon(
                        //     Icons.password_outlined,
                        //     color: Colors.indigoAccent,
                        //     size: 30,
                        //   ),
                        //   title: InkWell(
                        //     onTap: () {
                        //     },
                        //     child: TextWidget(
                        //       title: 'Change Password',
                        //       textColor: Colors.black,
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   trailing: Icon(
                        //     Icons.arrow_forward_ios_rounded,
                        //     size: 20,
                        //     color: Colors.indigoAccent,
                        //   ),
                        //   onTap: () {},
                        // ),
                        //
                        ListTile(
                          leading: Icon(
                            Icons.star,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: InkWell(
                            onTap: () {
                            },
                            child: TextWidget(
                              title: 'Rate Us',
                              textColor: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                          onTap: () {},
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.description,
                            color: Colors.indigoAccent,
                            size: 30,
                          ),
                          title: InkWell(
                            onTap: () {
                              Get.toNamed(AppPages.aboutUsView);
                            },
                            child: TextWidget(
                              title: 'About Us',
                              textColor: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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

                       Obx((){
                         return controller.state.logoutLoading.value ? Container(child: Center(child: CircularProgressIndicator(color: AppColors.iconsColor,))) :  RoundButton(
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
