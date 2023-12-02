import 'package:e_services_fyp/Pages/drawer/controller.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/controller.dart';
import 'package:get/get.dart';

class UserDrawerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCustomDrawerController>(() => UserCustomDrawerController());
  }
}
