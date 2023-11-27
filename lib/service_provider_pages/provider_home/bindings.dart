import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/service_provider_pages/provider_home/controller.dart';
import 'package:e_services_fyp/service_provider_pages/shedule_offers/controller.dart';
import 'package:get/get.dart';

class SPHomeBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SPHomeController>(() => SPHomeController());
    Get.lazyPut<ScheduleOffersController>(() => ScheduleOffersController());
  }

}