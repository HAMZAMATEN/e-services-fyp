import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/utils/prefrences/storage_prefs.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final state = SplashState();
  final sp = StorePrefrences();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void Navigate() async{
    final currentUser = await auth.currentUser;

    if(auth.currentUser != null){
      SessionController().userId = currentUser!.uid.toString();
      if(await checkUser(currentUser!.uid.toString())){
        Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.providerHomeView));
      }else{
        Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.applicationView));
      }
    }else{
      Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.onBoardingView));
    }

    // if(sp.getIsFirstOpen()==true){
    //   final currentUserId = await auth.currentUser!.uid.toString();
    //   if( await checkUser(currentUserId)){
    //
    //   }
    //   Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.signUpView));
    // }else{
    // Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.onBoardingView));
    // }
    // if(sp.getIsFirstOpen() != true ){
    //   Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.onBoardingView));
    // }else {
    //   final currentUserId = await auth.currentUser;
    //   if(currentUserId != null){
    //     if(checkUser(currentUserId.uid.toString())==true){
    //       Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.providerHomeView));
    //     }else {
    //       Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.homeView));
    //     }
    //   }else {
    //     Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.signUpView));
    //   }
    // }

  }


  Future<bool> checkUser (String uid) async {

    final serviceData = await firestore
        .collection('serviceProviders')
        .where('id', isEqualTo: uid)
        .get();
    if (serviceData.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}