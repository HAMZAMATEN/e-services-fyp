import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_services_fyp/Pages/application_view/controller.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/home/view.dart';
import 'package:e_services_fyp/Pages/profile_view/view.dart';
import 'package:e_services_fyp/Pages/scheduled_view/view.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/colors.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navbarItem = [

      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/icons/bookings.png",
          width: 35,
          height: 35,
        ),
        label: "Bookings",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/icons/categories.png",
          width: 35,
          height: 35,
        ),
        label: "Categories",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/icons/home.png",
          width: 35,
          height: 40,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/icons/chat.png",
          width: 35,
          height: 35,
        ),
        label: "Schedule",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/icons/profile.png",
          width: 35,
          height: 35,
        ),
        label: "Profile",
      ),
    ];
    var navBody = [

      Center(child: Text('BookingView')),
      Center(child: Text('CategoryView')),
      HomeView(),
      ScheduledView(),
      ProfileView(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
                child:
                    navBody.elementAt(controller.state.currentNavIndex.value),
              )),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 90,
          child: BottomNavigationBar(
            currentIndex: controller.state.currentNavIndex.value,
            selectedItemColor: AppColors.iconsColor,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: navbarItem,
            onTap: (value) {
              controller.state.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
