import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
  }

}