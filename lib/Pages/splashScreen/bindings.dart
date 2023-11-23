import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashController>(() => SplashController());
  }

}