import 'package:e_services_fyp/service_provider_pages/drawer/controller.dart';
import 'package:get/get.dart';

class DrawerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomDrawerController>(() => CustomDrawerController());
  }
}
