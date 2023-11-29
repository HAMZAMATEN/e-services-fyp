import 'package:e_services_fyp/service_provider_pages/ServicePackages/AddPackage/controller.dart';
import 'package:get/get.dart';

class AddPacakageBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AddPackageController>(() => AddPackageController());
  }

}