import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final state = SplashState();

  void Navigate(){
    Future.delayed(Duration(seconds: 3), ()=> Get.offNamed(AppPages.signUpView));
  }
}