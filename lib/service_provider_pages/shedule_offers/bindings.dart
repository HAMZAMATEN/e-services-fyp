import 'package:e_services_fyp/service_provider_pages/shedule_offers/controller.dart';
import 'package:get/get.dart';

class ScheduleOfferBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScheduleOffersController>(() => ScheduleOffersController());
  }

}