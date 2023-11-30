import 'package:e_services_fyp/service_provider_pages/sp_profile_view/controller.dart';
import 'package:get/get.dart';

class SpProfileBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SpProfileController>(() => SpProfileController());
  }

}