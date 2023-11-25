import 'package:e_services_fyp/Pages/OnBoardingPages/controller.dart';
import 'package:get/get.dart';

class OnBoardingBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }

}