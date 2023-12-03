import 'package:e_services_fyp/service_provider_pages/Orders/Screens/Direct/controller.dart';
import 'package:get/get.dart';

class DirectOrdersBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DirectOrdersController>(() => DirectOrdersController());
  }

}