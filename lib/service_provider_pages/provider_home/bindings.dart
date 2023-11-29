
import 'package:e_services_fyp/service_provider_pages/Orders/controller.dart';
import 'package:e_services_fyp/service_provider_pages/Orders/view.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/controller.dart';
import 'package:e_services_fyp/service_provider_pages/provider_home/controller.dart';
import 'package:e_services_fyp/service_provider_pages/shedule_offers/controller.dart';
import 'package:get/get.dart';

class SPHomeBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SPHomeController>(() => SPHomeController());
    Get.lazyPut<ScheduleOffersController>(() => ScheduleOffersController());
    Get.lazyPut<OrdersControllers>(() => OrdersControllers());
    Get.lazyPut<ServicePackagesController>(() => ServicePackagesController());
  }

}