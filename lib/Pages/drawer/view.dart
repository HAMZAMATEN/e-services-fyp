import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/drawer/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/controller.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/widgets/list_tile_widget.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/text_widget.dart';

class UserDrawer {
  static Drawer buildDrawer(BuildContext context) {
    final con = Get.put(
      UserCustomDrawerController(),
    );
    return Drawer(
      width: 300,
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                TextWidget(
                  title: 'Hey , ',
                  fontSize: 16,
                  textColor: Colors.black,
                ),
                Obx(
                  () => TextWidget(
                    title: con.state.userName.value.toString().capitalizeFirst.toString(),
                    fontSize: 18,
                    textColor: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            // height: 30.sp,
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTileWidget(
            iconData: Icons.category_outlined,
            title: 'Categories',
            onPress: () {
              Navigator.pop(context);

              Get.toNamed(AppPages.catogeryView);
            },
          ),

          ListTileWidget(
            iconData: Icons.details_outlined,
            title: 'About Us',
            onPress: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.aboutUsView);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.auto_fix_off_rounded,
            title: 'Booked Services',
            onPress: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.bookedServicesView);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.schedule_rounded,
            title: 'Scheduled Services',
            onPress: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.scheduledServicesView);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.favorite_outline,
            title: 'FAQ\'s',
            onPress: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.faqView);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.person_2_rounded,
            title: 'Profile',
            onPress: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.userProfileView);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.logout,
            title: 'Log Out',
            onPress: () async {
              Navigator.pop(context);

            },
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }
}
