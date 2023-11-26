import 'dart:ffi';

import 'package:e_services_fyp/Pages/home/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/service_provider_pages/provider_home/state.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SPHomeController extends GetxController{
  final state = SPHomeState();
  final auth = FirebaseAuth.instance;


  void setLogoutLoading(bool val){
    state.logoutLoading.value = val;
  }

  Future<void> handleLogout() async{
    setLogoutLoading(true);
   try{
     await auth.signOut().then((value){
       SessionController().userId = null;
       setLogoutLoading(false);
       Get.offAllNamed(AppPages.signUpView);
       Snackbar.showSnackBar('Logout', 'Successfully', Icons.done_outline_rounded);
     }).onError((error, stackTrace){
       setLogoutLoading(false);
       Snackbar.showSnackBar('Error', error.toString(), Icons.error_outline);
     });
   }catch(e){
     setLogoutLoading(false);
     Snackbar.showSnackBar('Error', e.toString(), Icons.error_outline);
   }
  }

}