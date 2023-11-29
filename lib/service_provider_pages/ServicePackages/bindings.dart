import 'package:e_services_fyp/service_provider_pages/ServicePackages/controller.dart';
import 'package:get/get.dart';

class ServicePackagesBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ServicePackagesController>(() => ServicePackagesController());
  }

}