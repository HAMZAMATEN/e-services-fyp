import 'package:e_services_fyp/service_provider_pages/offer_detail_screen/controller.dart';
import 'package:e_services_fyp/service_provider_pages/order_detail_screen/controller.dart';
import 'package:get/get.dart';

class OrderDetailsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OrderDetailController());
  }

}