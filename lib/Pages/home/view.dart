import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            RoundButton(
                title: 'LogOut',
                onPress: () {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Get.offAllNamed(AppPages.signUpView),
                      );
                }),
          ],
        ),
      ),
    );
  }
}
