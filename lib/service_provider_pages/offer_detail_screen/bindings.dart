import 'package:e_services_fyp/service_provider_pages/offer_detail_screen/controller.dart';
import 'package:get/get.dart';

class OfferDetailsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OfferDetailController());
  }

}