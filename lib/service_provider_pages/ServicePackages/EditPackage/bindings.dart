import 'package:e_services_fyp/service_provider_pages/ServicePackages/EditPackage/controller.dart';
import 'package:get/get.dart';

class EditPackageBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<EditPackageController>(() => EditPackageController());
  }

}