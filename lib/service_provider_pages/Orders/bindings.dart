import 'package:e_services_fyp/service_provider_pages/Orders/controller.dart';
import 'package:get/get.dart';

class OrdersBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OrdersControllers());
  }

}