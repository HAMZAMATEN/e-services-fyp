import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/session_controller.dart';
import '../../utils/compnents/snackbar_widget.dart';
import '../../utils/routes/routesNames.dart';

class CustomDrawerController extends GetxController {
  final state = DrawerState();

  @override
  void onInit() {
    // TODO: implement onInit
    fetchUserName();
    super.onInit();
  }

  fetchUserName() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if (snapshot.data()!.isEmpty) {
      print('empty');
    } else {
      final data = snapshot.data() as Map<String, dynamic>;
      final name = data['providerName'] as String;
      state.userName.value = name;
    }
  }

  Future<void> handleLogout() async{
    try{
      await FirebaseAuth.instance.signOut().then((value){
        SessionController().userId = null;

        Get.offAllNamed(AppPages.signUpView);
        Snackbar.showSnackBar('Logout', 'Successfully', Icons.done_outline_rounded);
      }).onError((error, stackTrace){

        Snackbar.showSnackBar('Error', error.toString(), Icons.error_outline);
      });
    }catch(e){
      Snackbar.showSnackBar('Error', e.toString(), Icons.error_outline);
    }
  }

}
