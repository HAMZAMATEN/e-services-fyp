import 'package:e_services_fyp/service_provider_pages/ServicePackages/ManagePackages/controller.dart';
import 'package:get/get.dart';

class ManagePackageBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ManagePackageController>(() => ManagePackageController());
  }

}